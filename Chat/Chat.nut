local ChatLine = class
{
	constructor(r, g, b, text)
	{
		_line = Draw(0, 0, text)
		_line.setColor({r = r, g = g, b = b})
	}

	function getVisible()
	{
		return _line.visible
	}

	function setVisible(visible)
	{
		_line.visible = visible
	}

	function setPosition(x, y)
	{
		_line.setPositionPx(x, y)
	}

	function setAlpha(alpha)
	{
		_line.alpha = alpha
	}

	function heightPx()
	{
		return _line.heightPx
	}

	_line = null
	_alphaAnimationBeginTime = -1
}

local ChatPlayerLine = class extends ChatLine
{
	constructor(pid, r, g, b, text)
	{
		base.constructor(r, g, b, text)

		local color = getPlayerColor(pid)
		_nickname = Draw(0, 0, getPlayerName(pid) + ": ")
		_nickname.setColor({r = color.r, g = color.g, b = color.b})
	}

	function getVisible()
	{
		return _line.visible
	}

	function setVisible(visible)
	{
		base.setVisible(visible)
		_nickname.visible = visible
	}

	function setPosition(x, y)
	{
		base.setPosition(_nickname.widthPx + x, y)
		_nickname.setPositionPx(x, y)
	}

	function setAlpha(alpha)
	{
		base.setAlpha(alpha)
		_nickname.alpha = alpha
	}

	function heightPx()
	{
		return _nickname.heightPx
	}

	_nickname = null
}

Chat <- {
	x = 5,
	y = 5,

	visible = true,
	animationInterval = 400.0,

	_lines = queue(),
	_maxLines = 15,

	_historySize = 50,
	_location = 0,

	_inputHistory = queue(),
	_inputHistorySize = 5,
	_inputHistoryLocation = 0,

	_moveLinesAnimationBeginTime = -1
}

function Chat::foreachVisibleLine(callback)
{
	for (local i = firstVisibleLine(), end = lastVisibleLine(); i <= end; ++i)
		callback(_lines[i])
}

function Chat::setVisible(visible)
{
	this.visible = visible

	foreachVisibleLine(function(line)
	{
		line.setVisible(visible)
	})
}

function Chat::printPlayer(pid, r, g, b, msg)
{
	local lines = split(msg.tostring(), "\n")

	foreach (line in lines)
	{
		_printLine(ChatPlayerLine(pid, r, g, b, line))

		if (pid == heroId)
			pushInputHistoryMessage(line)
	}
}

function Chat::print(r, g, b, msg)
{
	local lines = split(msg.tostring(), "\n")

	foreach (line in lines)
		_printLine(ChatLine(r, g, b, line))
}

function Chat::_printLine(line)
{
	_lines.push(line)

	local lastVisibleLine = _lines[lastVisibleLine()]

	if (visible && !lastVisibleLine.getVisible())
		lastVisibleLine.setVisible(true)

	if (animationInterval > 0)
	{
		lastVisibleLine.setAlpha(0)
		lastVisibleLine._alphaAnimationBeginTime = getTickCount()
	}

	if (_lines.len() > _maxLines)
	{
		_lines[firstVisibleLine() - 1].setVisible(false)

		if (_lines.len() > _historySize)
			_lines.pop()

		if (animationInterval > 0)
			_moveLinesAnimationBeginTime = getTickCount()
		else
			_calcPosition()
	}
	else
		_calcPosition()
}

function Chat::_calcPosition()
{
	local offset = 0

	foreachVisibleLine(function(line)
	{
		if (visible && !line.getVisible())
			line.setVisible(true)

		line.setPosition(x, y + offset)
		offset += line.heightPx()
	})

	chatInputSetPosition(x, any(y + offset))
}

function Chat::clear()
{
	_lines.clear()
	_calcPosition()
}

function Chat::setHistorySize(historySize)
{
	if (historySize >= _maxLines && _historySize > historySize)
	{
		for (local i = 0, end = _lines.len() - historySize; i < end; ++i)
			_lines.pop()
	}

	_historySize = historySize
}

function Chat::lines()
{
	return _lines.len()
}

function Chat::maxLines()
{
	return _maxLines
}

function Chat::setMaxLines(maxLines)
{
	if (maxLines <= 0 || maxLines > 30)
		return

	foreachVisibleLine(function(line)
	{
		line.setVisible(false)
	})

	_maxLines = maxLines
	_calcPosition()

	if (_historySize < maxLines)
		setHistorySize(maxLines)
}

function Chat::location()
{
	return _location
}

function Chat::firstVisibleLine()
{
	local idx = _lines.len() - _maxLines + _location

	if (idx < 0)
		idx = 0

	return idx
}

function Chat::lastVisibleLine()
{
	if (!_lines.len())
		return -1

	return _lines.len() - 1 + _location
}

function Chat::setLocation(newLocation)
{
	if (_location == newLocation)
		return

	if (_lines.len() < _maxLines)
		return

	if ((_lines.len() - _maxLines + newLocation < 0) || (newLocation > 0))
		return

	foreachVisibleLine(function(line)
	{
		line.setVisible(false)
	})

	_location = newLocation
	_calcPosition()
}

function Chat::setInputHistorySize(size)
{
	if (_inputHistorySize > size)
		loadInputHistoryMessage(0)

	_inputHistorySize = size
}

function Chat::inputHistoryLocation()
{
	return _inputHistoryLocation
}

function Chat::pushInputHistoryMessage(message)
{
	if (_inputHistorySize <= 0)
		return

	_inputHistory.push(message)

	if (_inputHistory.len() > _inputHistorySize)
		_inputHistory.pop()
}

function Chat::loadInputHistoryMessage(newLocation)
{
	if (_inputHistoryLocation == newLocation)
		return

	if (!_inputHistory.len())
		return

	if ((_inputHistory.len() + newLocation < 0) || (newLocation > 0))
		return

	_inputHistoryLocation = newLocation
	chatInputSetText((newLocation != 0) ? _inputHistory[_inputHistory.len() + newLocation] : "")
}

function Chat::moveLineAnimation(idx, line, now)
{
	if (_moveLinesAnimationBeginTime == -1)
		return

	local deltaTime = (now - _moveLinesAnimationBeginTime) / animationInterval
	local lineHeightPx = line.heightPx()

	if (deltaTime < 1.0)
		line.setPosition(x, y + lineHeightPx * (idx + 1) - lineHeightPx * deltaTime)
	else
	{
		_calcPosition()
		_moveLinesAnimationBeginTime = -1
	}
}

function Chat::showLineAnimation(line, now)
{
	if (line._alphaAnimationBeginTime == -1)
		return

	local deltaTime = (now - line._alphaAnimationBeginTime) / animationInterval

	if (deltaTime < 1.0)
		line.setAlpha(255 * deltaTime)
	else
	{
		line.setAlpha(255)
		line._alphaAnimationBeginTime = -1
	}
}

addEventHandler("onInit", function()
{
	Chat._calcPosition()
})

addEventHandler("onRender", function()
{
	if (Chat.animationInterval <= 0)
		return

	local now = getTickCount()
	local idx = 0

	Chat.foreachVisibleLine(function(line)
	{
		Chat.moveLineAnimation(idx, line, now)
		Chat.showLineAnimation(line, now)

		++idx
	})
})

addEventHandler("onKeyDown", function(key)
{
	if (chatInputIsOpen())
	{
		switch (key)
		{
		case KEY_UP:
			if (isKeyPressed(KEY_LCONTROL) || isKeyPressed(KEY_RCONTROL))
				Chat.loadInputHistoryMessage(Chat.inputHistoryLocation() - 1)
			else
				Chat.setLocation(Chat.location() - 1)
			break

		case KEY_DOWN:
			if (isKeyPressed(KEY_LCONTROL) || isKeyPressed(KEY_RCONTROL))
				Chat.loadInputHistoryMessage(Chat.inputHistoryLocation() + 1)
			else
				Chat.setLocation(Chat.location() + 1)
			break

		case KEY_PRIOR:
			Chat.setLocation(-(Chat.lines() - Chat.maxLines()))
			break

		case KEY_NEXT:
			Chat.setLocation(0)
			break

		case KEY_RETURN:
			Chat.setLocation(0)
			chatInputSend()
			Chat.loadInputHistoryMessage(0)

			disableControls(false)
			break

		case KEY_ESCAPE:
			chatInputClose()
			disableControls(false)
			break

		default:
			playGesticulation(heroId)
			break
		}
	}
	else
	{
		switch (key)
		{
		case KEY_T:
			if(!isGUIOpened(null)) {
				if (!isConsoleOpen() && Chat.visible)
				{
					chatInputOpen()
					disableControls(true)
				}
			}
			break
		case KEY_SLASH:
			if(!isGUIOpened(null)) {
				if (!isConsoleOpen() && Chat.visible)
				{
					chatInputOpen()
					chatInputSetText("/");
					disableControls(true)
				}
			}
			break

		case KEY_F7:
			Chat.setVisible(!Chat.visible)
			break
		}
	}
})

addEventHandler("onMouseWheel", function(direction)
{
	if (!Chat.visible)
		return

	if (!chatInputIsOpen())
		return

	if (isKeyPressed(KEY_LCONTROL) || isKeyPressed(KEY_RCONTROL))
		Chat.loadInputHistoryMessage(Chat.inputHistoryLocation() - direction)
	else
		Chat.setLocation(Chat.location() - direction)
})

addEventHandler("onPlayerMessage", function(pid, r, g, b, message)
{
	if (pid != -1)
		Chat.printPlayer(pid, r, g, b, message)
	else
		Chat.print(r, g, b, message)
})
