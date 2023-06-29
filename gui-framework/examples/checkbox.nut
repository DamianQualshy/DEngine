local window = GUI.Window(0, 0, anx(400), any(200), "MENU_INGAME.TGA", null, true)

local drawCheckBox = GUI.CheckBox(anx(125), any(75), anx(50), any(40), "INV_SLOT_EQUIPPED_FOCUS.TGA", "X", window)
local textureCheckBox = GUI.CheckBox(anx(185), any(75), anx(50), any(40), "INV_SLOT_EQUIPPED_FOCUS.TGA", "INV_SLOT_EQUIPPED_HIGHLIGHTED_FOCUS.TGA", window)

addEventHandler("onInit",function()
{
	window.setVisible(true)
	setCursorVisible(true)
})
