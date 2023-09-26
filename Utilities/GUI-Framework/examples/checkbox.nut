local window = GUI.Window({
	positionPx = {x = 0, y = 0}
	sizePx = {width = 400, height = 200}
	file = "MENU_INGAME.TGA"
})

local drawCheckBox = GUI.CheckBox({
	relativePositionPx = {x = 125 y = 75}
	sizePx = {width = 50, height = 40}
	file = "INV_SLOT_EQUIPPED_FOCUS.TGA"
	draw = {text = "X"}
	collection = window
})

local textureCheckBox = GUI.CheckBox({
	relativePositionPx = {x = 185, y = 75}
	sizePx = {width = 50, height = 40}
	checkedFile = "INV_SLOT_EQUIPPED_HIGHLIGHTED_FOCUS.TGA"
	uncheckedFile = "INV_SLOT_EQUIPPED_FOCUS.TGA"
	collection = window
})

addEventHandler("onInit",function()
{
	window.setVisible(true)
	setCursorVisible(true)
})
