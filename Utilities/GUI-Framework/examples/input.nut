local window = GUI.Window({
	sizePx = {width = 340, height = 190}
	file = "MENU_INGAME.TGA"
})

local textInput = GUI.Input({
	relativePositionPx = {x = 20, y = 10}
	sizePx = {width = 300, height = 50}
	file = "DLG_CONVERSATION.TGA"
	font = "FONT_OLD_20_WHITE_HI.TGA"
	type = Input.Text,
	align = Align.Left
	placeholderText = "Type a text"
	paddingPx = 6
	collection = window
})

local passwordInput = GUI.Input({
	relativePositionPx = {x = 20, y = 70}
	sizePx = {width = 300, height = 50}
	file = "DLG_CONVERSATION.TGA"
	font = "FONT_OLD_20_WHITE_HI.TGA"
	type = Input.Password
	align = Align.Center
	placeholderText = "Type a password"
	paddingPx = 6
	collection = window
})

local numbersInput = GUI.Input({
	relativePositionPx = {x = 20, y = 130}
	sizePx = {width = 300, height = 50}
	file = "DLG_CONVERSATION.TGA"
	font = "FONT_OLD_20_WHITE_HI.TGA"
	type = Input.Numbers
	align = Align.Right
	placeholderText = "Type a number"
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

textInput.bind(EventType.InsertLetter, function(self, letter)
{
	print("insert letter: \"" + letter + "\"")
})

textInput.bind(EventType.RemoveLetter, function(self, letter)
{
	print("remove letter: \"" + letter + "\"")
})
