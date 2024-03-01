local window = GUI.Window({
	sizePx = {width = 340, height = 190}
	file = "MENU_INGAME.TGA"
})

local textInput = GUI.Input({
	relativePositionPx = {x = 20, y = 10}
	sizePx = {width = 300, height = 50}
	font = "FONT_OLD_20_WHITE_HI.TGA"
	file = "BLACK.TGA"
	color = {a = 150}
	align = Align.Left
	placeholder = "Type a text"
	paddingPx = 5
	collection = window
})

local passwordInput = GUI.PasswordInput({
	relativePositionPx = {x = 20, y = 70}
	sizePx = {width = 300, height = 50}
	font = "FONT_OLD_20_WHITE_HI.TGA"
	file = "BLACK.TGA"
	color = {a = 150}
	align = Align.Center
	placeholder = "Type a password"
	paddingPx = 6
	collection = window
})

local numberInput = GUI.NumberInput({
	relativePositionPx = {x = 20, y = 130}
	sizePx = {width = 300, height = 50}
	font = "FONT_OLD_20_WHITE_HI.TGA"
	file = "BLACK.TGA"
	color = {a = 150}
	align = Align.Right
	placeholder = "Type a number"
	paddingPx = 2
	collection = window
})

addEventHandler("onInit",function()
{
	local windowSizePx = window.getSizePx()
	local resolution = getResolution()
	window.setPositionPx((resolution.x - windowSizePx.width) / 2, (resolution.y - windowSizePx.height) / 2)

	setCursorVisible(true)
	window.setVisible(true)
})

textInput.bind(EventType.KeyInput, function(self, key, letter)
{
	print("textInput.text = " + textInput.getText())
})

numberInput.bind(EventType.Change, function(self)
{
	print("numberInput.text = " + numberInput.getText())
})