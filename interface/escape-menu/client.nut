//na razie tu, dam potem do bazowego pliku jak zrobię
disableLogicalKey(GAME_END, true)


local mainWindow = GUI.Window(anx(760), any(200), anx(400), any(400), "MENU_INGAME.TGA", null, false)
mainWindow.setAlpha(200)
mainWindow.setColor(255, 0, 0, true)
mainWindow.setSizePx(400, 600)

local quitButton = GUI.Button(anx(100), any(450), anx(50), any(25), "MENU_INGAME.TGA", "Wyjdź", mainWindow)
quitButton.setSizePx(200, 50)



addEventHandler("onInit", function()
{
	enableEvent_Render(true)
	setCursorVisible(true)
})


addEventHandler("onKey", function(key)
{
	if(key == KEY_ESCAPE){
		mainWindow.setVisible(!mainWindow.getVisible())
	}
	
});

addEventHandler("GUI.onClick", function(self)
{
	switch (self)
	{
		case quitButton:
			exitGame()
			break
	}
})

