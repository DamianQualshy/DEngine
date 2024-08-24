/////////////////////////////////////////
///	Row types
/////////////////////////////////////////

local PlayerListDataRow = class
{
	constructor(...)
	{
		color = {r = 255, g = 255, b = 255}
		columns = []

		foreach (value in vargv)
			columns.push(value)
	}

	function setColor(r, g, b)
	{
		color.r = r
		color.g = g
		color.b = b
	}

	color = null
	columns = null
}

local PlayerListVisibleRow = class
{
	constructor()
	{
		columns = []

		foreach (header in PlayerList._headers)
			columns.push(Draw(0, 0, ""))
	}

	function update(dataRow)
	{
		if (dataRow)
		{
			foreach (idx, value in dataRow.columns)
			{
				columns[idx].text = value
				columns[idx].color.set(dataRow.color.r, dataRow.color.g, dataRow.color.b)
			}
		}
		else
		{
			foreach (column in columns)
				column.text = ""
		}
	}

	function setVisible(visible)
	{
		this.visible = visible

		foreach (column in columns)
			column.visible = visible
	}

	function setPositionPx(x, y)
	{
		local headers = PlayerList._headers
		local width = 0

		foreach (id, column in columns)
		{
			column.setPositionPx(x + width, y)
			width += (nax(headers[id].width) + headers[id].draw.widthPx)
		}
	}

	function setColor(r, g, b)
	{
		foreach (column in columns)
			column.color.set(r, g, b)
	}

	columns = null
	visible = false
}

/////////////////////////////////////////
///	Player list
/////////////////////////////////////////

PlayerList <- {
	// Private
	_hostname = null,
	_headers = [],
	_backgrounds = [],
	_rowHeightPx = -1,

	// Public
	visible = false,
	suppressNpcNames = false,
	x = -1,
	y = 100,
	width = -1,
	height = -1,

	// Read only
	begin = 0,
	playerDataRows = {},
	dataRows = [],
	visibleRows = [],

	// Constans
	MAX_VISIBLE_ROWS = 30,

	COLUMN_ID = -1,
	COLUMN_NICKNAME = -1,
	COLUMN_PING = -1,
}

function PlayerList::init()
{
	// Create server name header
	_hostname = Draw(0, 0, getHostname())
	_hostname.font = "FONT_OLD_20_WHITE_HI.TGA"
	_hostname.setPositionPx(nax(4096 - _hostname.width / 2), y / 2)

	// Add columns after this line....
	COLUMN_ID = registerColumn("Id", 200)
	COLUMN_NICKNAME = registerColumn("Nickname", 3000)
	COLUMN_PING = registerColumn("Ping", 100)

	// Add textures after this line...
	registerTexture("MENU_INGAME.TGA", function()
	{
		tex.setPositionPx(PlayerList.x - 25, PlayerList.y - 15)
		tex.setSizePx(PlayerList.width + 50, PlayerList.height + 30)
	})

	// Create visible rows
	for (local i = 0; i < MAX_VISIBLE_ROWS; ++i)
		visibleRows.push(PlayerListVisibleRow())

	// Init row height in pixels
	local oldFont = textGetFont()
	textSetFont("FONT_OLD_10_WHITE_HI.TGA")
		_rowHeightPx = letterHeightPx()
	textSetFont(oldFont)

	// Update UI size
	resize()
}

function PlayerList::registerColumn(name, width)
{
	local draw = Draw(0, 0, name)
	draw.color.set(255, 255, 0)

	_headers.push({
		name = name,
		width = width,
		draw = draw,
	})

	return _headers.len() - 1
}

function PlayerList::registerTexture(name, resize)
{
	local tex = Texture(0, 0, 0, 0, name)
	local bg = {
		resize = resize,
		tex = tex,
	}

	_backgrounds.push(bg)
}

function PlayerList::setVisible(visible)
{
	this.visible = visible
	_hostname.visible = visible

	foreach (bg in _backgrounds)
		bg.tex.visible = visible

	foreach (header in _headers)
		header.draw.visible = visible

	foreach (visibleRow in visibleRows)
		visibleRow.setVisible(visible)
}

function PlayerList::refresh(value)
{
	_updateBegin(value)
	_updateVisibleRows()
}

function PlayerList::insert(pid)
{
	if (suppressNpcNames && pid >= getMaxSlots()) return

	local dataRow = PlayerListDataRow(pid, getPlayerName(pid), getPlayerPing(pid))

	local playerColor = heroId != pid ? getPlayerColor(pid) : {r = 255, g = 150, b = 0}
	dataRow.setColor(playerColor.r, playerColor.g, playerColor.b)

	dataRows.push(dataRow)
	dataRows.sort(@(a, b) a.columns[PlayerList.COLUMN_ID] <=> b.columns[PlayerList.COLUMN_ID])
	playerDataRows[pid] <- dataRow

	local dataRowIdx = dataRows.find(dataRow)

	if (isInView(dataRowIdx))
		_updateVisibleRows()
}

function PlayerList::remove(pid)
{
	if (suppressNpcNames && pid >= getMaxSlots()) return

	local dataRowIdx = dataRows.find(playerDataRows[pid])
	local isInView = isInView(dataRowIdx)

	dataRows.remove(dataRowIdx)
	delete playerDataRows[pid]

	if (dataRowIdx == dataRows.len() - 1)
		_updateBegin(begin - 1)

	if (isInView)
		_updateVisibleRows()
}

function PlayerList::resize()
{
	width = 0
	height = _headers.top().draw.heightPx + _rowHeightPx * MAX_VISIBLE_ROWS

	foreach (header in _headers)
		width += (nax(header.width) + header.draw.widthPx)

	local headerX = x = (getResolution().x - width) / 2
	local headerY = y

	width = 0
	foreach (header in _headers)
	{
		header.draw.setPositionPx(headerX + width, headerY)
		width += (nax(header.width) + header.draw.widthPx)
	}

	local offset = _rowHeightPx
	foreach (visibleRow in visibleRows)
	{
		visibleRow.setPositionPx(x, y + offset)
		offset += _rowHeightPx
	}

	foreach (bg in _backgrounds)
		bg.resize()
}

function PlayerList::_updateBegin(value)
{
	local maxScrollIdx = dataRows.len() - MAX_VISIBLE_ROWS

	if (maxScrollIdx < 0)
		maxScrollIdx = 0

	begin = clamp(value, 0, maxScrollIdx)
}

function PlayerList::isInView(dataRowIdx)
{
	return dataRowIdx >= begin && dataRowIdx <= begin + MAX_VISIBLE_ROWS - 1
}

function PlayerList::_updateVisibleRows()
{
	local dataRowIdx = begin
	local dataRowsLen = dataRows.len()

	foreach (visibleRow in visibleRows)
		visibleRow.update(dataRowIdx < dataRowsLen ? dataRows[dataRowIdx++] : null)
}

/////////////////////////////////////////
///	Events
/////////////////////////////////////////

addEventHandler("onInit", function()
{
	PlayerList.init()
})

addEventHandler("onPlayerCreate", function(pid)
{
	PlayerList.insert(pid)
})

addEventHandler("onPlayerDestroy", function(pid)
{
	PlayerList.remove(pid)
})

addEventHandler("onPlayerChangePing", function(pid, ping)
{
	local dataRow = PlayerList.playerDataRows[pid]
	local dataRowIdx = PlayerList.dataRows.find(dataRow)

	dataRow.columns[PlayerList.COLUMN_PING] = ping

	if (PlayerList.isInView(dataRowIdx))
		PlayerList.visibleRows[dataRowIdx - PlayerList.begin].columns[PlayerList.COLUMN_PING].text = ping
})

addEventHandler("onPlayerChangeNickname", function(pid, name)
{
	local dataRow = PlayerList.playerDataRows[pid]
	local dataRowIdx = PlayerList.dataRows.find(dataRow)

	dataRow.columns[PlayerList.COLUMN_NICKNAME] = name

	if (PlayerList.isInView(dataRowIdx))
		PlayerList.visibleRows[dataRowIdx - PlayerList.begin].columns[PlayerList.COLUMN_NICKNAME].text = name
})

addEventHandler("onPlayerChangeColor", function(pid, r, g, b)
{
	local dataRow = PlayerList.playerDataRows[pid]
	local dataRowIdx = PlayerList.dataRows.find(dataRow)

	dataRow.setColor(r, g, b)

	if (PlayerList.isInView(dataRowIdx))
		PlayerList.visibleRows[dataRowIdx - PlayerList.begin].setColor(r, g, b)
})

addEventHandler("onKeyDown", function(key)
{
	switch (key)
	{
		case KEY_F5:
			if (!chatInputIsOpen())
				PlayerList.setVisible(!PlayerList.visible)
			break

		case KEY_UP:
			if (PlayerList.visible)
				PlayerList.refresh(PlayerList.begin - 1)
			break

		case KEY_DOWN:
			if (PlayerList.visible)
				PlayerList.refresh(PlayerList.begin + 1)
			break

		case KEY_PRIOR:
			if (PlayerList.visible)
				PlayerList.refresh(0)
			break

		case KEY_NEXT:
			if (PlayerList.visible)
				PlayerList.refresh(PlayerList.dataRows.len() - PlayerList.MAX_VISIBLE_ROWS)
			break
	}
})

addEventHandler("onMouseWheel", function(value)
{
	if (PlayerList.visible)
		PlayerList.refresh(PlayerList.begin - value)
})

addEventHandler("onChangeResolution", function()
{
	PlayerList.resize()
})
