local loginCollection = GUI.Collection({
	positionPx = {x = 0, y = 0}
});

local loginGUI = {
	bg = GUI.Texture({
		positionPx = {x = nax(2560), y = nay(2580)}
		sizePx = {width = nax(2990), height = nay(3415)}
		file = "MENU_INGAME.TGA"
		scaling = true
		collection = loginCollection
	}),
	logo = GUI.Texture({
		positionPx = {x = nax(3285), y = nay(3035)}
		sizePx = {width = nax(1600), height = nay(910)}
		file = "MENU_GOTHIC.TGA"
		scaling = true
		collection = loginCollection
	}),

	logInp = GUI.Input({
		positionPx = {x = nax(3090), y = nay(4385)}
		sizePx = {width = nax(2005), height = nay(305)}
		file = "DLG_CONVERSATION.TGA"
		font = "FONT_OLD_10_WHITE.TGA"
		align = Align.Center
		placeholder = "LOGIN"
		placeholderColor = {r = 42, g = 75, b = 141}
		maxLetters = 20
		paddingPx = 4
		collection = loginCollection
	}),
	passInp = GUI.PasswordInput({
		positionPx = {x = nax(3090), y = nay(4780)}
		sizePx = {width = nax(2005), height = nay(305)}
		file = "DLG_CONVERSATION.TGA"
		font = "FONT_OLD_10_WHITE.TGA"
		align = Align.Center
		placeholder = "PASSWORD"
		placeholderColor = {r = 42, g = 75, b = 141}
		maxLetters = 20
		paddingPx = 4
		collection = loginCollection
	}),

	playBtn = GUI.Button({
		positionPx = {x = nax(3500), y = nay(5280)}
		sizePx = {width = nax(515), height = nay(230)}
		file = "INV_SLOT_FOCUS.TGA"
		draw = {text = "Play"}
		collection = loginCollection
	}),
	exitBtn = GUI.Button({
		positionPx = {x = nax(4200), y = nay(5280)}
		sizePx = {width = nax(515), height = nay(230)}
		file = "INV_SLOT_FOCUS.TGA"
		draw = {text = "Exit"}
		collection = loginCollection
	})
}

function toggleLogin(toggle){
	loginCollection.setVisible(toggle);

	setCursorVisible(toggle);
	setCursorPosition(4096, 4096);
	disableControls(toggle);

	if(toggle == true){
		Camera.setPosition(-14096.3, 2758.05, -30978.6);
		Camera.setRotation(0, 64, 0);

		updateDiscordState("Logging In...");
	}

	Camera.movementEnabled = !toggle;
}

addEventHandler("onInit", function(){
	toggleLogin(true);
});

addEventHandler("GUI.onClick", function(self){
		switch(self){
			case loginGUI.playBtn:
				toggleLogin(false);
				toggleCreator(true);
			break;
			case loginGUI.exitBtn:
				exitGame();
				toggleLogin(false);
			break;
		}
});