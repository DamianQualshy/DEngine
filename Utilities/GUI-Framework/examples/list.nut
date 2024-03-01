local window = GUI.Window({
	position = {x = 500, y = 1500}
	sizePx = {width = 700, height = 400}
	file = "MENU_INGAME.TGA"
})

local list = GUI.List({
	relativePositionPx = {x = 400, y = 0}
	sizePx = {width = 300, height = 300}
	marginPx = [20]
	rowHeightPx = 50
	file = "MENU_INGAME.TGA"
	scrollbar = {
		range = {
			file = "MENU_INGAME.TGA"
			indicator = {file = "BAR_MISC.TGA"}
		}
		increaseButton = {file = "O.TGA"}
		decreaseButton = {file = "U.TGA"}
	}
	collection = window
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
	list.insertRow(0, {text = "First row", file = "INV_SLOT_EQUIPPED.TGA"})
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
	list.addRow({text = "Last row", file = "INV_SLOT_EQUIPPED.TGA"})
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
	if (!list.rows.len())
		return

	list.removeRow(0)
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
	if (!list.rows.len())
		return

	local rowsCount = list.rows.len()

	if (!rowsCount)
		return

	list.removeRow(rowsCount - 1)
})

local clearButton = GUI.Button({
	relativePositionPx = {x = 60, y = 160}
	sizePx = {width = 300, height = 40}
	file = "MENU_INGAME.TGA"
	draw = {text = "Clear list"}
	collection = window
})

clearButton.bind(EventType.Click, function(self)
{
	list.clear()
})

local randomChar = @() rand() % 255

addEventHandler("GUI.onClick", function(self)
{
	if (!(self instanceof GUI.ListVisibleRow))
		return

	local parentList = self.parent
	if (parentList != list)
		return

	self.getDataRow().setDrawColor(randomChar(), randomChar(), randomChar())
})

addEventHandler("onInit", function()
{
	for (local i = 1; i <= 10; ++i)
		list.addRow({text = i + " row", file = "INV_SLOT_EQUIPPED.TGA"})

	window.setVisible(true)
	setCursorVisible(true)
})
