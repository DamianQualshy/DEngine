local window = GUI.Window(0, 0, anx(400), any(300), "MENU_INGAME.TGA", null, true)

local horizontalSlider = GUI.Slider(anx(30), any(5), anx(200), any(30), anx(7), any(3), "BAR_BACK.TGA", "BAR_MISC.TGA", "MENU_SLIDER_POS.TGA", Orientation.Horizontal, Align.Left, window)
local verticalSlider = GUI.Slider(anx(5), any(30), anx(30), any(200), anx(3), any(7), "MENU_INGAME.TGA", "INV_SLOT_EQUIPPED.TGA", "MENU_SLIDER_POS.TGA", Orientation.Vertical, Align.Left, window)

addEventHandler("onInit",function()
{
	setCursorVisible(true)
	window.setVisible(true)

	horizontalSlider.bar.setStretching(false)
	verticalSlider.bar.setStretching(false)
})
