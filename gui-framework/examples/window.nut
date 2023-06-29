local window = GUI.Window(anx(100), any(100), anx(400), any(400), "MENU_INGAME.TGA", null, true)
window.setAlpha(200)
window.setColor(255, 0, 0, true)
window.setSizePx(500, 300)
window.setSizePx(500, 300)

addEventHandler("onInit", function()
{
	enableEvent_Render(true)
	window.setVisible(true)
	setCursorVisible(true)
})


addEventHandler("onKey", function(key)
{
	if(key == KEY_P)
		window.setVisible(!window.getVisible())
});