local window = GUI.Window(anx(50), any(50), anx(400), any(200), "MENU_INGAME.TGA", null, true)
local verticalScroll = GUI.ScrollBar(anx(400), 0, anx(20), any(200), "MENU_INGAME.TGA", "BAR_MISC.TGA", "O.TGA", "U.TGA", Orientation.Vertical, window)
local horizontalScroll = GUI.ScrollBar(0, any(200), anx(400), any(20), "MENU_INGAME.TGA", "BAR_MISC.TGA", "L.TGA", "R.TGA", Orientation.Horizontal, window)

addEventHandler("onInit",function()
{
	setCursorVisible(true)
	window.setVisible(true)
})
