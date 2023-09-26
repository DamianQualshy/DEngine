local window = GUI.Window({
	positionPx = {x = 50, y = 50}
	sizePx = {width = 400, height = 200}
	file = "MENU_INGAME.TGA"
})

local verticalScroll = GUI.ScrollBar({
	relativePositionPx = {x = 400, y = 0}
	sizePx = {width = 20, height = 200}
	range = {
		file = "MENU_INGAME.TGA"
		indicator = {file = "BAR_MISC.TGA"}
		orientation = Orientation.Vertical
	}
	increaseButton = {file = "U.TGA"}
	decreaseButton = {file = "O.TGA"}
	collection = window
})

local horizontalScroll = GUI.ScrollBar({
	relativePositionPx = {x = 0, y = 200}
	sizePx = {width = 400, height = 20}
	range = {
		file = "MENU_INGAME.TGA"
		indicator = {file = "BAR_MISC.TGA"}
		orientation = Orientation.Horizontal
	}
	increaseButton = {file = "R.TGA"}
	decreaseButton = {file = "L.TGA"}
	collection = window
})

addEventHandler("onInit",function()
{
	setCursorVisible(true)
	window.setVisible(true)
})
