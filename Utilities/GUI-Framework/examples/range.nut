local window = GUI.Window({
	positionPx = {x = 0, y = 0}
	sizePx = {width = 400, height = 200}
	file = "MENU_INGAME.TGA"
})

local infoDraw = GUI.Draw({
	relativePositionPx = {x = 50, y = 20}
	text = "0"
	collection = window
})

local horizontalRange = GUI.Range({
	relativePositionPx = {x = 50, y = 0}
	sizePx = {width = 200, height = 20}
	marginPx = [5, 0, 10]
	file = "MENU_SLIDER_BACK.TGA"
	indicator = {file = "MENU_SLIDER_POS.TGA"}
	indicatorSizePx = RANGE_INDICATOR_SIZE / 2
	minimum = 0
	maximum = 100
	step = 1
	orientation = Orientation.Horizontal
	collection = window
})

horizontalRange.bind(EventType.Change, function(self)
{
	infoDraw.setText(self.getValue())
})

local verticalRange = GUI.Range({
	relativePositionPx = {x = 30, y = 0}
	sizePx = {width = 20, height = 200}
	file = "MENU_INGAME.TGA"
	indicator = {file = "MENU_SLIDER_POS.TGA"}
	minimum = 0.0
	maximum = 50.0
	step = 0.5
	orientation = Orientation.Vertical
	collection = window
})

verticalRange.bind(EventType.Change, function(self)
{
	infoDraw.setText(self.getValue())
})

addEventHandler("onInit",function()
{
	setCursorVisible(true)
	window.setVisible(true)
})
