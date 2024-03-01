local window = GUI.Window({
	positionPx = {x = 100, y = 50}
	sizePx = {width = 400, height = 200}
	file = "MENU_INGAME.TGA"
})

local closeButton = GUI.Button({
	relativePositionPx = {x = 350, y = 0}
	sizePx = {width = 50, height = 25}
	file = "INV_SLOT_FOCUS.TGA"
	draw = {text = "X"}
	collection = window
})

local msg = GUI.Draw({
	relativePositionPx = {x = 70, y = 80}
	text = "Would you like to update?"
	collection = window
})

local yesButton = GUI.Button({
	relativePositionPx = {x = 125, y = 120}
	sizePx = {width = 50, height = 25}
	file = "INV_SLOT_FOCUS.TGA"
	draw = {text = "Yes"}
	collection = window
})

local noButton = GUI.Button({
	relativePositionPx = {x = 225, y = 120}
	sizePx = {width = 50, height = 25}
	file = "INV_SLOT_FOCUS.TGA"
	draw = {text = "No"}
	collection = window
})

addEventHandler("onInit",function()
{
	setCursorVisible(true)
	window.setVisible(true)
})

// logic

closeButton.bind(EventType.Click, function(self)
{
	window.setVisible(false)
})

yesButton.bind(EventType.Click, function(self)
{
	msg.setText("Update completed [#7676f7]successfully!")
})

noButton.bind(EventType.Click, function(self)
{
	msg.setText("Nah.. [#F60005]that's a pitty")
})

// style

addEventHandler("GUI.onMouseIn", function(self)
{
	if (!(self instanceof GUI.Button))
		return

	self.setColor({r = 255, g = 0, b = 0})
})

addEventHandler("GUI.onMouseOut", function(self)
{
	if (!(self instanceof GUI.Button))
		return

	self.setColor({r = 255, g = 255, b = 255})
})
