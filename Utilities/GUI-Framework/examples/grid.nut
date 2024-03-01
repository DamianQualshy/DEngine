local collection = null
local grid = null
local addBtn = null
local i = 0

local function cell_onClick(self)
{
	local dataCell = self.getDataCell()
	dataCell.setFile("BLACK.TGA")
}

collection = GUI.Collection()
grid = GUI.Grid({
	sizePx = {width = 600, height = 400},
	positionPx = {x = 100, y = 100},
	marginPx = [20],
	cellWidthPx = 100,
	cellHeightPx = 100,
	spacingXPx = 15,
	spacingYPx = 25,
	file = "MENU_INGAME.TGA",
	scrollbar = {
		range = {
			file = "MENU_INGAME.TGA",
			indicator = {file = "BAR_MISC.TGA"}
		}
		increaseButton = {file = "O.TGA"},
		decreaseButton = {file = "U.TGA"}
	},
	collection = collection
})


foreach (visibleCell in grid.visibleCells)
	visibleCell.bind(EventType.Click, cell_onClick)

addBtn = GUI.Button({
	sizePx = {width = 200, height = 50},
	file = "INV_SLOT_FOCUS.TGA",
	draw = {text = "Add cell"},
	positionPx = {x = 100, y = 5 + grid.getSizePx().height + grid.getPositionPx().y}
	collection = collection
})

addBtn.bind(EventType.Click, function(self) {
	grid.addCell({
		text = i,
		file = "RED.TGA"
	})
})

for (; i < 20; ++i)
{
	grid.addCell({
		text = i,
		file = "MENU_INGAME.TGA"
	})
}

collection.setVisible(true)
