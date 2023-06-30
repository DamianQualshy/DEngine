setCursorVisible(true)
local mainWindow = GUI.Window(anx(760), any(200), anx(400), any(400), "MENU_INGAME.TGA", null, false)
mainWindow.setAlpha(200)
mainWindow.setColor(255, 0, 0, true)
mainWindow.setSizePx(400, 550)

local buttons = {
	back = GUI.Button(anx(100), any(50), anx(50), any(25), "MENU_INGAME.TGA", "Wróæ", mainWindow)
	options = GUI.Button(anx(100), any(150), anx(50), any(25), "MENU_INGAME.TGA", "Opcje", mainWindow)
	help = GUI.Button(anx(100), any(250), anx(50), any(25), "MENU_INGAME.TGA", "Pomoc", mainWindow)
	character = GUI.Button(anx(100), any(350), anx(50), any(25), "MENU_INGAME.TGA", "Postaæ", mainWindow)
	quit = GUI.Button(anx(100), any(450), anx(50), any(25), "MENU_INGAME.TGA", "WyjdŸ", mainWindow)
}

foreach(button in buttons){
	button.setSizePx(200, 50)
}



local function changeMenuState(){
	if(BaseInterface.IsInterfaceOpen && !mainWindow.getVisible())
		return
	mainWindow.setVisible(!mainWindow.getVisible())
	BaseInterface.ChangeControlsState()
}

addEventHandler("onKey", function(key)
{
	if(key == KEY_ESCAPE)
		changeMenuState()
});

addEventHandler("GUI.onClick", function(self)
{
	switch (self)
	{
		case buttons.back:
			changeMenuState()
			break
		case buttons.options:
			break
		case buttons.help:
			break
		case buttons.character:
			break
		case buttons.quit:
			exitGame()
			break
	}
})

