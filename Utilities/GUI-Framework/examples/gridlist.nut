local randomChar = @() rand() % 255

local window = GUI.Window({
	position = {x = 500, y = 1500}
	sizePx = {width = 700, height = 400}
	file = "MENU_INGAME.TGA"
})

local gridlist = GUI.GridList({
	relativePositionPx = {x = 400, y = 0}
	sizePx = {width = 300, height = 300}
	marginPx = {top = 10, left = 10}
	rowHeightPx = 28
	rowSpacingPx = 5
	file = "MENU_INGAME.TGA"
	scrollbar = {
		range = {
			file = "MENU_INGAME.TGA"
			indicator = {file = "BAR_MISC.TGA"}
		}
		increaseButton = {file = "U.TGA"}
		decreaseButton = {file = "O.TGA"}
	}
	collection = window
})

local playerColumn = gridlist.addColumn({
	widthPx = 132
	align = Align.Center
})

local pingColumn = gridlist.addColumn({
	widthPx = 133
	align = Align.Center
})

local addFirstRowButton = GUI.Button({
	relativePositionPx = {x = 60, y = 0}
	sizePx = {width = 300, height = 40}
	file = "MENU_INGAME.TGA"
	draw = {text = "Add first row"}
	collection = window
})

addFirstRowButton.bind(EventType.Click, function(self)
{
	if (!gridlist.columns.len())
		return

	gridlist.insertRow(0,
		{text = "1.Cell First", file = "INV_SLOT_EQUIPPED.TGA"}
		{text = "2.Cell First", file = "INV_SLOT_EQUIPPED.TGA"}
	)
})

local addLastRowButton = GUI.Button({
	relativePositionPx = {x = 60, y = 40}
	sizePx = {width = 300, height = 40}
	file = "MENU_INGAME.TGA"
	draw = {text = "Add last row"}
	collection = window
})

addLastRowButton.bind(EventType.Click, function(self)
{
	if (!gridlist.columns.len())
		return

	gridlist.addRow(
		{text = "1.Cell Last", file = "INV_SLOT_EQUIPPED.TGA"}
		{text = "2.Cell Last", file = "INV_SLOT_EQUIPPED.TGA"}
	)
})

local removeFirstRowButton = GUI.Button({
	relativePositionPx = {x = 60, y = 80}
	sizePx = {width = 300, height = 40}
	file = "MENU_INGAME.TGA"
	draw = {text = "Remove first row"}
	collection = window
})

removeFirstRowButton.bind(EventType.Click, function(self)
{
	if (!(0 in gridlist.columns))
		return

	if (!gridlist.rows.len())
		return

	gridlist.removeRow(0)
})

local removeLastRowButton = GUI.Button({
	relativePositionPx = {x = 60, y = 120}
	sizePx = {width = 300, height = 40}
	file = "MENU_INGAME.TGA"
	draw = {text = "Remove last row"}
	collection = window
})

removeLastRowButton.bind(EventType.Click, function(self)
{
	if (!(0 in gridlist.columns))
		return

	local rowsCount = gridlist.rows.len()

	if (!rowsCount)
		return

	gridlist.removeRow(rowsCount - 1)
})

local addPlayerColumnFirstCellButton = GUI.Button({
	relativePositionPx = {x = 60, y = 160}
	sizePx = {width = 300, height = 40}
	file = "MENU_INGAME.TGA"
	draw = {text = "Add Player Column first cell"}
	collection = window
})

addPlayerColumnFirstCellButton.bind(EventType.Click, function(self)
{
	if (!playerColumn)
		return

	if (!(0 in gridlist.rows))
		return

	if (playerColumn in gridlist.rows[0].cells)
		return

	gridlist.rows[0].insertCell(playerColumn, {text = "Player", file = "INV_SLOT_EQUIPPED.TGA", color = {r = randomChar(), g = randomChar(), b = randomChar()}})
})

local addPingColumnFirstCellButton = GUI.Button({
	relativePositionPx = {x = 60, y = 200}
	sizePx = {width = 300, height = 40}
	file = "MENU_INGAME.TGA"
	draw = {text = "Add Ping Column first cell"}
	collection = window
})

addPingColumnFirstCellButton.bind(EventType.Click, function(self)
{
	if (!pingColumn)
		return

	if (!(0 in gridlist.rows))
		return

	if (pingColumn in gridlist.rows[0].cells)
		return

	gridlist.rows[0].insertCell(pingColumn, {value = randomChar(), file = "INV_SLOT_EQUIPPED.TGA", color = {r = randomChar(), g = randomChar(), b = randomChar()}})
})

local removePlayerColumnFirstCellButton = GUI.Button({
	relativePositionPx = {x = 60, y = 240}
	sizePx = {width = 300, height = 40}
	file = "MENU_INGAME.TGA"
	draw = {text = "Remove Player Column first cell"}
	collection = window
})

removePlayerColumnFirstCellButton.bind(EventType.Click, function(self)
{
	if (!playerColumn)
		return

	gridlist.rows[0].removeCell(playerColumn)
})

local removePingColumnFirstCellButton = GUI.Button({
	relativePositionPx = {x = 60, y = 280}
	sizePx = {width = 300, height = 40}
	file = "MENU_INGAME.TGA"
	draw = {text = "Remove Ping Column first cell"}
	collection = window
})

removePingColumnFirstCellButton.bind(EventType.Click, function(self)
{
	if (!pingColumn)
		return

	gridlist.rows[0].removeCell(pingColumn)
})

local removePlayerColumnButton = GUI.Button({
	relativePositionPx ={x = 60, y = 320}
	sizePx = {width = 300, height = 40}
	file = "MENU_INGAME.TGA"
	draw = {text = "Remove Player Column"}
	collection = window
})

removePlayerColumnButton.bind(EventType.Click, function(self)
{
	if (!playerColumn)
		return

	playerColumn = gridlist.removeColumn(playerColumn.id)
})

local removePingColumnButton = GUI.Button({
	relativePositionPx = {x = 60, y = 360}
	sizePx = {width = 300, height = 40}
	file = "MENU_INGAME.TGA"
	draw = {text = "Remove Ping Column" }
	collection = window
})

removePingColumnButton.bind(EventType.Click, function(self)
{
	if (!pingColumn)
		return

	pingColumn = gridlist.removeColumn(pingColumn.id)
})

addEventHandler("GUI.onClick", function(self)
{
	if (!(self instanceof GUI.GridListVisibleCell))
		return

	local visibleRow = self.parent
	if (visibleRow.parent != gridlist)
		return

	foreach (cell in visibleRow.cells)
		cell.draw.setColor({r = randomChar(), g = randomChar(), b = randomChar()})
})

addEventHandler("onInit", function()
{
	local ASCIILetter = 'A'

	for(local i = 1; i <= 26; i++)
	{
		local row = gridlist.addRow(
			{text = ASCIILetter.tochar().tostring(), file = "INV_SLOT_EQUIPPED.TGA"}, 
			{text = randomChar(), file = "INV_SLOT_EQUIPPED.TGA"}
		)

		foreach (cell in row.cells)
			cell.setDrawColor({r = randomChar(), g = randomChar(), b = randomChar()})

		++ASCIILetter
	}

 	window.setVisible(true)
 	setCursorVisible(true)
})
