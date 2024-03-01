local function button_onClick(self)
{
	self.top()
}

local redButton = GUI.Button({
	positionPx = {x = 0, y = 0}
	sizePx = {width = 120, height = 50}
	file = "RED.TGA"
})

redButton.bind(EventType.Click, button_onClick)

local greenButton = GUI.Button({
	positionPx = {x = 20, y = 20}
	sizePx = {width = 120, height = 50}
	file = "GREEN.TGA"
})

greenButton.bind(EventType.Click, button_onClick)

local blueButton = GUI.Button({
	positionPx = {x = 40, y = 40}
	sizePx = {width = 120, height = 50}
	file = "BLUE.TGA"
})

blueButton.bind(EventType.Click, button_onClick)

local whiteButton = GUI.Button({
	positionPx = {x = 60, y = 60}
	sizePx = {width = 120, height = 50}
	file = "WHITE.TGA"
})

whiteButton.bind(EventType.Click, button_onClick)

local blackButton = GUI.Button({
	positionPx = {x = 80, y = 80}
	sizePx = {width = 120, height = 50}
	file = "BROWN.TGA"
})

blackButton.bind(EventType.Click, button_onClick)

local infoDraw = GUI.Draw({
	positionPx = {x = 160, y = 0}
	text = "Hover me, for more info..."
	font = "FONT_OLD_20_WHITE_HI.TGA"

	toolTip = GUI.ToolTip({
		file = "BROWN.TGA"
		align = Align.Left
		draw = {
			text = "This buttons shows, how Framework\n"
				 + "works with depth feature.\n"
				 + "You can hover the buttons or click them,\n"
				 + "to test the behaviour."
		}
	})
})

local toolTip = GUI.ToolTip({
	draw = {text = ""}
	sizePx = {width = 60, height = 25}
	file = "MENU_INGAME.TGA"

	tips = [
		{object = redButton, text = "[#FF0000]Red"}
		{object = greenButton, text = "[#00FF00]Green"}
		{object = blueButton, text = "[#00CCFF]Blue"}
		{object = whiteButton, text = "[#FFFFFF]White"}
		{object = blackButton, text = "[#B26630]Brown"}
	]
})

addEventHandler("onInit",function()
{
	redButton.setVisible(true)
	greenButton.setVisible(true)
	blueButton.setVisible(true)
	whiteButton.setVisible(true)
	blackButton.setVisible(true)

	infoDraw.setVisible(true)

	setCursorVisible(true)
})

// style

addEventHandler("GUI.onMouseIn",function(self)
{
	if (!(self instanceof GUI.Button))
		return

	self.setColor({a = 125})
})

addEventHandler("GUI.onMouseOut",function(self)
{
	if (!(self instanceof GUI.Button))
		return

	self.setColor({a = 255})
})
