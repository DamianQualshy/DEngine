local window = GUI.Window({
	positionPx = {x = 0, y = 0}
	sizePx = {width = 305, height = 230}
	file = "BLACK.TGA"
	color = {a = 127}
})

local infoDraw = GUI.Draw({
	relativePositionPx = {x = 80, y = 50}
	text = "value: 0"
	collection = window
})

local horizontalSliderLeftToRight = GUI.Slider({
	relativePositionPx = {x = 80, y = 5}
	sizePx = {width = 200, height = 15}
	marginPx = [3, 7]
	file = "BLACK.TGA"
	indicator = {
		file = "WHITE.TGA"
		color = {r = 200, g = 200, b = 200}
	}
	indicatorSizePx = 15
	progress = {
		file = "RED.TGA"
		color = {r = 127, g = 0, b = 0}
	}
	minimum = 0
	maximum = 100
	step = 1
	orientation = Orientation.Horizontal
	collection = window
})

local horizontalSliderRightToLeft = GUI.Slider({
	relativePositionPx = {x = 80, y = 30}
	sizePx = {width = 200, height = 15}
	marginPx = [3, 7]
	file = "BLACK.TGA"
	indicator = {
		file = "WHITE.TGA"
		color = {r = 200, g = 200, b = 200}
	}
	indicatorSizePx = 15
	progress = {
		file = "RED.TGA"
		color = {r = 127, g = 0, b = 0}
	}
	minimum = 100
	maximum = 0
	step = 1
	orientation = Orientation.Horizontal
	collection = window
})

local verticalSliderTopToBottom = GUI.Slider({
	relativePositionPx = {x = 30, y = 5}
	sizePx = {width = 15, height = 200}
	marginPx = [7, 3]
	file = "BLACK.TGA"
	indicator = {
		file = "WHITE.TGA"
		color = {r = 200, g = 200, b = 200}
	}
	indicatorSizePx = 15
	progress = {
		file = "YELLOW.TGA"
		color = {r = 220, g = 200, b = 0}
	}
	minimum = 0
	maximum = 100
	step = 1
	orientation = Orientation.Vertical
	collection = window
})

local verticalSliderBottomToTop = GUI.Slider({
	relativePositionPx = {x = 55, y = 5}
	sizePx = {width = 15, height = 200}
	marginPx = [7, 3]
	file = "BLACK.TGA"
	indicator = {
		file = "WHITE.TGA"
		color = {r = 200, g = 200, b = 200}
	}
	indicatorSizePx = 15
	progress = {
		file = "YELLOW.TGA"
		color = {r = 220, g = 200, b = 0}
	}
	minimum = 100
	maximum = 0
	step = 1
	orientation = Orientation.Vertical
	collection = window
})

local function onValueChange(self)
{
	infoDraw.setText("value: " + self.getValue())
}

horizontalSliderLeftToRight.bind(EventType.Change, onValueChange)
horizontalSliderRightToLeft.bind(EventType.Change, onValueChange)
verticalSliderTopToBottom.bind(EventType.Change, onValueChange)
verticalSliderBottomToTop.bind(EventType.Change, onValueChange)

addEventHandler("onInit",function()
{
	setCursorVisible(true)
	window.setVisible(true)
})
