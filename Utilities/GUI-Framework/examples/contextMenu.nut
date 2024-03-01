local colorContextMenu = GUI.ContextMenu({
	sizePx = {width = 400, height = 200}
	marginPx = [20, 20, 0]
	rowHeightPx = 50,
	rowSpacingPx = 5,
	file = "INV_BACK.TGA"
})


local list = GUI.List({
	sizePx = {width = 600, height = 300}
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
})

local function colorOption_onClick(self)
{
	local dataRow = self.getDataRow()
	local selectedRow = self.parent.getActiveParent().getDataRow()
    
	selectedRow.setDrawColor(clone dataRow.getDrawColor())
}

addEventHandler("onInit", function()
{
	foreach (visibleRow in colorContextMenu.visibleRows)
		visibleRow.bind(EventType.Click, colorOption_onClick)

	foreach (visibleRow in list.visibleRows)
		visibleRow.contextMenu = colorContextMenu

	colorContextMenu.addRow({text = "Change color to red", drawColor = Color(255, 0, 0), file = "INV_SLOT.TGA"})
	colorContextMenu.addRow({text = "Change color to green", drawColor = Color(0, 255, 0), file = "INV_SLOT.TGA"})
	colorContextMenu.addRow({text = "Change color to blue", drawColor = Color(0, 0, 255), file = "INV_SLOT.TGA"})


	for (local i = 1; i <= 10; ++i)
		list.addRow({text = i + " row", file = "INV_SLOT_EQUIPPED.TGA"})

	list.setVisible(true)
	setCursorVisible(true)
})