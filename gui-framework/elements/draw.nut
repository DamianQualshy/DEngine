class GUI.Draw extends GUI.Base
{
#private:
	_positionPx = null
	_sizePx = null
	_scale = null
	_lineSizePx = 0

	_text = ""
	_font = "FONT_OLD_10_WHITE_HI.TGA"

	_color = null
	_alpha = 255

	_draws = null
	_drawsCount = 0

	constructor(x, y, text, window = null, colorParserEnabled = true)
	{
		base.constructor()

		_draws = [Draw(x, y, "")]
		_drawsCount = 1

		_color = {r = 255, g = 255, b = 255}

		_positionPx = {x = nax(x), y = nay(y)}
		_sizePx = {width = 0.0, height = 0.0}
		_scale = {width = 1.0, height = 1.0}

		updateLineSize()
		setText(text, colorParserEnabled)

		if (window)
			window.insert(this)
	}

	function leftPx(x, y, width, height)
	{
		local size = getSizePx()

		if (!size.width && !size.height)
			return

		centerPx(x, y, width, height)

		local position = getPositionPx()
		setPositionPx(x, position.y)
	}

	function left(x, y)
	{
		leftPx(nax(x), nay(y))
	}

	function centerPx(x, y, width, height)
	{
		if (!width && !height)
			return

		local size = getSizePx()

		if (!size.width && !size.height)
			return

		local centerX = x + (width - size.width) / 2
		local centerY = y + (height - size.height) / 2

		setPositionPx(centerX, centerY)
	}

	function center(x, y, width, height)
	{
		centerPx(nax(x), nay(y), nax(width), nay(height))
	}

	function rightPx(x, y, width, height)
	{
		local size = getSizePx()

		if (!size.width && !size.height)
			return

		centerPx(x, y, width, height)
		local position = getPositionPx()

		local rightX = x + (width - size.width)
		setPositionPx(rightX, position.y)
	}

	function right(x, y, width, height)
	{
		rightPx(nax(x), nay(y), nax(width), nay(height))
	}

	function updateLineSize()
	{
		local oldFont = textGetFont()

		textSetFont(_font)
		_lineSizePx = letterHeightPx()
		textSetFont(oldFont)
	}

	function setVisible(visible)
	{
		base.setVisible(visible)

		for (local i = 0; i != _drawsCount; ++i)
			_draws[i].visible = visible
	}

	function getPositionPx()
	{
		return _positionPx
	}

	function setPositionPx(x, y)
	{
		for (local i = 0; i != _drawsCount; ++i)
		{
			local draw = _draws[i]
			local drawPosition = draw.getPositionPx()

			draw.setPositionPx(drawPosition.x + (x - _positionPx.x), drawPosition.y + (y - _positionPx.y))
		}

		_positionPx.x = x
		_positionPx.y = y

		base.setPositionPx(x, y)
	}

	function getPosition()
	{
		return {x = anx(_positionPx.x), y = any(_positionPx.y)}
	}

	function setPosition(x, y)
	{
		setPositionPx(nax(x), nay(y))
	}

	function getSizePx()
	{
		return _sizePx
	}

	function getSize()
	{
		return {width = anx(_sizePx.width), height = any(_sizePx.height)}
	}

	function getLineSizePx()
	{
		return _lineSizePx * _scale.height
	}

	function setLineSizePx(lineSize)
	{
		_lineSizePx = lineSize

		setText(getText())
		base.setSizePx.call(this, _sizePx.width, _sizePx.height)
	}

	function getLineSize()
	{
		return any(getLineSizePx())
	}

	function setLineSize(lineSize)
	{
		setLineSizePx(any(lineSize))
	}

	function getLinesCount()
	{
		return getSizePx().height / getLineSizePx()
	}

	function top()
	{
		base.top()

		for (local i = 0; i != _drawsCount; ++i)
			_draws[i].top()
	}

	function parse(text, colorParserEnabled = true)
	{
		local info = []

		local expression = "\\n"
		expression += (colorParserEnabled) ? "|" + @"\[#[0-9_a-f_A-F]{6,}]" : ""

		local regex = regexp(expression)

		local currentPosition = 0
		local currentColor = _color

		_text = ""

		local result = null
		while (result = regex.search(text, currentPosition))
		{
			local isEOLFound = (result.end - result.begin == 1)
			local endPosition = (isEOLFound) ? result.end - 1 : result.begin

			local slicedText = text.slice(currentPosition, endPosition)

			if (slicedText != "" || isEOLFound)
			{
				info.push({text = slicedText, color = currentColor, newLine = isEOLFound})
				_text += slicedText
			}

			currentPosition = result.end
			currentColor = (isEOLFound) ? currentColor : hexToRgb(text.slice(result.begin + 2, result.end - 1))
		}

		local slicedText = text.slice(currentPosition, text.len())

		_text += slicedText
		info.push({text = slicedText, color = currentColor, newLine = false})

		if (info.len())
			return info

		return null
	}

	function getText()
	{
		return _text
	}

	function setText(text, colorParserEnabled = true)
	{
		if (typeof text != "string")
			text = text.tostring()

		if (text == "")
		{
			foreach (draw in _draws)
				draw.text = ""

			_drawsCount = 0

			return
		}
			
		local lineSize = getLineSizePx()
		local x = _positionPx.x, y = _positionPx.y
		local width = 0, height = lineSize
			
		local i = 0
		foreach (info in parse(text, colorParserEnabled))
		{
			local draw = null

			if (info.text != "")
			{
				if (_draws.len() <= i)
					_draws.push(Draw(0, 0, ""))

				draw = _draws[i]

				draw.setPositionPx(x, y)
				draw.setScale(_scale.width, _scale.height)

				draw.setColor(info.color.r, info.color.g, info.color.b)
				draw.alpha = _alpha

				draw.font = _font
				draw.text = info.text

				draw.visible = _visible
			}

			if (info.newLine)
			{
				local lineWidth = x - _positionPx.x

				if (lineWidth > width)
					width = lineWidth

				height += lineSize

				x = _positionPx.x
				y += lineSize

			}
			else if (draw)
				x += draw.widthPx
				
			++i
		}

		local lineWidth = x - _positionPx.x

		if (lineWidth > width)
			width = lineWidth

		_sizePx.width = width
		_sizePx.height = height

		_drawsCount = i

		for (local i = _draws.len() - 1; i >= _drawsCount; --i)
			_draws[i].visible = false
	}

	function getFont()
	{
		return _font
	}

	function setFont(font)
	{
		if (font == _font)
			return

		_font = font

		updateLineSize()

		setText(getText())
		base.setSizePx.call(this, _sizePx.width, _sizePx.height)
	}

	function getColor()
	{
		return _color
	}

	function setColor(r, g, b)
	{
		_color.r = r
		_color.g = g
		_color.b = b

		for (local i = 0; i != _drawsCount; ++i)
			_draws[i].setColor(r, g, b)
	}

	function getAlpha()
	{
		return _alpha
	}

	function setAlpha(alpha)
	{
		_alpha = alpha

		for (local i = 0; i != _drawsCount; ++i)
			_draws[i].alpha = alpha
	}

	function getScale()
	{
		return _scale
	}

	function setScale(width, height)
	{
		_scale.width = width
		_scale.height = height

		setText(getText())
		base.setSizePx.call(this, _sizePx.width, _sizePx.height)
	}
}
