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
		type = Input.Text
		align = Align.Center
		placeholderText = "LOGIN"
		paddingPx = 4
		collection = loginCollection
	}),
	passInp = GUI.Input({
		positionPx = {x = nax(3090), y = nay(4780)}
		sizePx = {width = nax(2005), height = nay(305)}
		file = "DLG_CONVERSATION.TGA"
		font = "FONT_OLD_10_WHITE.TGA"
		type = Input.Password
		align = Align.Center
		placeholderText = "PASSWORD"
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
	}),

	fail = GUI.Draw({
		positionPx = {x = nax(2140), y = nay(1100)}
		text = "Wrong or empty login credentials, try again."
		font = "FONT_OLD_20_WHITE_HI.TGA"
	})
}

local soundLogin = [
	"DIA_ADDON_BDT_1084_SENYAN_HI_12_00.WAV",
	"DIA_DEXTER_HALLO_09_00.WAV",
	"DIA_ADDON_CRONOS_HALLO_04_01.WAV",
	"DIA_ADDON_DEXTER_HALLO_09_00.WAV",
	"DIA_ADDON_MORGAN_HELLO_07_01.WAV",
	"DIA_ADDON_SKIP_HELLO_08_00.WAV",
	"DIA_ADDON_SKIP_NW_HALLO_08_00.WAV",
	"DIA_ADDON_WACHE_02_HI_13_01.WAV",
	"DIA_ADDON_XARDAS_HELLO_14_00.WAV",
	"DIA_BRONKO_HALLO_06_00.WAV",
	"DIA_CANTHAR_HALLO_09_00.WAV",
	"DIA_CIPHER_HELLO_07_01.WAV",
	"DIA_GRIMES_HALLO_05_00.WAV",
	"DIA_HOKURN_HELLO_01_00.WAV",
	"DIA_JAN_HELLO_10_00.WAV",
	"DIA_JARVIS_HELLO_04_00.WAV",
	"DIA_LARES_HALLO_09_00.WAV",
	"DIA_LEE_HALLO_04_00.WAV",
	"DIA_LOTHAR_HELLOAGAIN_01_00.WAV",
	"DIA_MILTENOW_HELLO_03_00.WAV",
	"DIA_RAOUL_HELLO_01_00.WAV",
	"DIA_SENGRATH_HELLO_03_00.WAV"
];
local soundRegister = [
	"DIA_ADDON_ALLIGATORJACK_HELLO_12_00.WAV",
	"DIA_ADDON_BRANDON_HELLO_04_00.WAV",
	"DIA_ADDON_FRANCO_HI_08_00.WAV",
	"DIA_ADDON_GARETT_HELLO_09_00.WAV",
	"DIA_ADDON_LOGAN_HI_10_00.WAV",
	"DIA_ADDON_MALCOM_HELLO_04_01.WAV",
	"DIA_ADDON_MATT_HELLO_10_01.WAV",
	"DIA_ADDON_MYXIR_HALLO_12_01.WAV",
	"DIA_ADDON_NEFARIUS_HALLO_05_01.WAV",
	"DIA_ADDON_OWEN_HELLO_13_01.WAV",
	"DIA_ADDON_SAMUEL_HELLO_14_00.WAV",
	"DIA_ADDON_SANCHO_HI_06_00.WAV",
	"DIA_ANDRE_HALLO_08_00.WAV",
	"DIA_ATTILA_HALLO_09_00.WAV",
	"DIA_BABO_HELLO_03_00.WAV",
	"DIA_EGILL_HALLO_08_01.WAV",
	"DIA_GARWIG_HELLO_06_00.WAV",
	"DIA_GERBRANDT_HELLO_10_01.WAV",
	"DIA_GESTATH_HALLO_09_01.WAV",
	"DIA_LOTHAR_HALLO_01_00.WAV",
	"DIA_MALETH_HALLO_08_00.WAV",
	"DIA_THORBEN_HALLO_06_00.WAV"
];

loginGUI.logInp.maxLetters = 20;
loginGUI.passInp.maxLetters = 20;


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

	hudBarToggle(!toggle);

	loginGUIvisible = toggle;
	loginGUI.fail.setVisible(false);
}

addEventHandler("onInit", function(){
	toggleLogin(true);
});

local showButtons = function(toggle){
	loginGUI.playBtn.setVisible(toggle);
	loginGUI.exitBtn.setVisible(toggle);
}

addEventHandler("GUI.onClick", function(self){
	if(loginGUIvisible){
		switch(self){
			case loginGUI.playBtn:
				loginGUI.fail.setVisible(false);
				if(loginGUI.logInp != "" && loginGUI.passInp != ""){
					showButtons(false);
					local loginPacket = PlayerLoginMessage(heroId,
						loginGUI.logInp.getText(),
						loginGUI.passInp.getText()
						).serialize();
					loginPacket.send(RELIABLE_ORDERED);
				} else {
					loginGUI.fail.setVisible(true);
				}
			break;
			case loginGUI.exitBtn:
				exitGame();
				toggleLogin(false);
			break;
		}
	}
});

PlayerLoginFailMessage.bind(function(message){
	local soundFail = format("SVM_%d_HANDSOFF.WAV", rand() % 15);
	loginGUI.fail.setVisible(true);

	showButtons(true);
		Sound(soundFail).play();

	setTimer(function(){
		loginGUI.fail.setVisible(false);
	}, 5000, 1);
});

PlayerLoginSuccessMessage.bind(function(message){
	toggleLogin(false);
		Sound(soundLogin[rand() % soundLogin.len()]).play();
});

PlayerRegisterMessage.bind(function(message){
	toggleLogin(false);
	toggleCreator(true);
		Sound(soundRegister[rand() % soundRegister.len()]).play();
});

local creatorCollection = GUI.Collection({
	positionPx = {x = 0, y = 0}
});
local creatorGUI = {
	visBG = GUI.Texture({
		positionPx = {x = nax(300), y = nay(2085)}
		sizePx = {width = nax(3000), height = nay(4020)}
		file = "MENU_INGAME.TGA"
		scaling = true
		collection = creatorCollection
	}),
	statsBG = GUI.Texture({
		positionPx = {x = nax(4900), y = nay(2085)}
		sizePx = {width = nax(3000), height = nay(4020)}
		file = "MENU_INGAME.TGA"
		scaling = true
		collection = creatorCollection
	}),

	facesScroll = GUI.ScrollBar({
		positionPx = {x = nax(1000), y = nay(2580)}
		sizePx = {width = nax(85), height = nay(3185)}
		range = {
			file = "MENU_SLIDER_BACK.TGA"
			indicator = {file = "MENU_SLIDER_POS.TGA"}
			orientation = Orientation.Vertical
		}
		increaseButton = {file = ""}
		decreaseButton = {file = ""}
		collection = creatorCollection
	}),
	bodiesScroll = GUI.ScrollBar({
		positionPx = {x = nax(1600), y = nay(2580)}
		sizePx = {width = nax(85), height = nay(3185)}
		range = {
			file = "MENU_SLIDER_BACK.TGA"
			indicator = {file = "MENU_SLIDER_POS.TGA"}
			orientation = Orientation.Vertical
		}
		increaseButton = {file = ""}
		decreaseButton = {file = ""}
		collection = creatorCollection
	}),

	bodyM = GUI.Draw({
		positionPx = {x = nax(2350), y = nay(2805)}
		text = "Gender"
		font = "FONT_OLD_10_WHITE.TGA"
		collection = creatorCollection
	}),
	bodyMScroll = GUI.ScrollBar({
		positionPx = {x = nax(2110), y = nay(2960)}
		sizePx = {width = nax(810), height = nay(115)}
		range = {
			file = "MENU_SLIDER_BACK.TGA"
			indicator = {file = "MENU_SLIDER_POS.TGA"}
			orientation = Orientation.Horizontal
		}
		increaseButton = {file = ""}
		decreaseButton = {file = ""}
		collection = creatorCollection
	}),
	headM = GUI.Draw({
		positionPx = {x = nax(2220), y = nay(3185)}
		text = "Head Model"
		font = "FONT_OLD_10_WHITE.TGA"
		collection = creatorCollection
	}),
	headMScroll = GUI.ScrollBar({
		positionPx = {x = nax(2110), y = nay(3415)}
		sizePx = {width = nax(810), height = nay(115)}
		range = {
			file = "MENU_SLIDER_BACK.TGA"
			indicator = {file = "MENU_SLIDER_POS.TGA"}
			orientation = Orientation.Horizontal
		}
		increaseButton = {file = ""}
		decreaseButton = {file = ""}
		collection = creatorCollection
	}),
	bodyT = GUI.Draw({
		positionPx = {x = nax(2390), y = nay(3565)}
		text = "Race"
		font = "FONT_OLD_10_WHITE.TGA"
		collection = creatorCollection
	}),
	bodyTScroll = GUI.ScrollBar({
		positionPx = {x = nax(2110), y = nay(3755)}
		sizePx = {width = nax(810), height = nay(115)}
		range = {
			file = "MENU_SLIDER_BACK.TGA"
			indicator = {file = "MENU_SLIDER_POS.TGA"}
			orientation = Orientation.Horizontal
		}
		increaseButton = {file = ""}
		decreaseButton = {file = ""}
		collection = creatorCollection
	}),
	fat = GUI.Draw({
		positionPx = {x = nax(2305), y = nay(3945)}
		text = "Fatness"
		font = "FONT_OLD_10_WHITE.TGA"
		collection = creatorCollection
	}),
	fatScroll = GUI.ScrollBar({
		positionPx = {x = nax(2110), y = nay(4135)}
		sizePx = {width = nax(810), height = nay(115)}
		range = {
			file = "MENU_SLIDER_BACK.TGA"
			indicator = {file = "MENU_SLIDER_POS.TGA"}
			orientation = Orientation.Horizontal
		}
		increaseButton = {file = ""}
		decreaseButton = {file = ""}
		collection = creatorCollection
	}),
	height = GUI.Draw({
		positionPx = {x = nax(2350), y = nay(4325)}
		text = "Height"
		font = "FONT_OLD_10_WHITE.TGA"
		collection = creatorCollection
	}),
	heightScroll = GUI.ScrollBar({
		positionPx = {x = nax(2110), y = nay(4550)}
		sizePx = {width = nax(810), height = nay(115)}
		range = {
			file = "MENU_SLIDER_BACK.TGA"
			indicator = {file = "MENU_SLIDER_POS.TGA"}
			orientation = Orientation.Horizontal
		}
		increaseButton = {file = ""}
		decreaseButton = {file = ""}
		collection = creatorCollection
	}),
	walk = GUI.Draw({
		positionPx = {x = nax(1960), y = nay(4700)}
		text = "Walking Style: Default"
		font = "FONT_OLD_10_WHITE.TGA"
		collection = creatorCollection
	}),
	walkScroll = GUI.ScrollBar({
		positionPx = {x = nax(2110), y = nay(4930)}
		sizePx = {width = nax(810), height = nay(115)}
		range = {
			file = "MENU_SLIDER_BACK.TGA"
			indicator = {file = "MENU_SLIDER_POS.TGA"}
			orientation = Orientation.Horizontal
		}
		increaseButton = {file = ""}
		decreaseButton = {file = ""}
		collection = creatorCollection
	}),

	hp = GUI.Draw({
		positionPx = {x = nax(5035), y = nay(2390)}
		text = "Health: 40"
		font = "FONT_OLD_10_WHITE.TGA"
		collection = creatorCollection
	}),
	hpamU = GUI.Button({
		positionPx = {x = nax(4910), y = nay(2390)}
		sizePx = {width = nax(65), height = nay(115)}
		file = "INV_SLOT.TGA"
		draw = {text = "+"}
		collection = creatorCollection
	}),
	hpamD = GUI.Button({
		positionPx = {x = nax(4910), y = nay(2500)}
		sizePx = {width = nax(65), height = nay(115)}
		file = "INV_SLOT.TGA"
		draw = {text = "-"}
		collection = creatorCollection
	}),
	mp = GUI.Draw({
		positionPx = {x = nax(5035), y = nay(2805)}
		text = "Mana: 10"
		font = "FONT_OLD_10_WHITE.TGA"
		collection = creatorCollection
	}),
	mpamU = GUI.Button({
		positionPx = {x = nax(4910), y = nay(2805)}
		sizePx = {width = nax(65), height = nay(115)}
		file = "INV_SLOT.TGA"
		draw = {text = "+"}
		collection = creatorCollection
	}),
	mpamD = GUI.Button({
		positionPx = {x = nax(4910), y = nay(2920)}
		sizePx = {width = nax(65), height = nay(115)}
		file = "INV_SLOT.TGA"
		draw = {text = "-"}
		collection = creatorCollection
	}),
	str = GUI.Draw({
		positionPx = {x = nax(5035), y = nay(3225)}
		text = "Strength: 10"
		font = "FONT_OLD_10_WHITE.TGA"
		collection = creatorCollection
	}),
	stramU = GUI.Button({
		positionPx = {x = nax(4910), y = nay(3225)}
		sizePx = {width = nax(65), height = nay(115)}
		file = "INV_SLOT.TGA"
		draw = {text = "+"}
		collection = creatorCollection
	}),
	stramD = GUI.Button({
		positionPx = {x = nax(4910), y = nay(3340)}
		sizePx = {width = nax(65), height = nay(115)}
		file = "INV_SLOT.TGA"
		draw = {text = "-"}
		collection = creatorCollection
	}),
	dex = GUI.Draw({
		positionPx = {x = nax(5035), y = nay(3640)}
		text = "Dexterity: 10"
		font = "FONT_OLD_10_WHITE.TGA"
		collection = creatorCollection
	}),
	dexamU = GUI.Button({
		positionPx = {x = nax(4910), y = nay(3640)}
		sizePx = {width = nax(65), height = nay(115)}
		file = "INV_SLOT.TGA"
		draw = {text = "+"}
		collection = creatorCollection
	}),
	dexamD = GUI.Button({
		positionPx = {x = nax(4910), y = nay(3755)}
		sizePx = {width = nax(65), height = nay(115)}
		file = "INV_SLOT.TGA"
		draw = {text = "-"}
		collection = creatorCollection
	}),
	mlv = GUI.Draw({
		positionPx = {x = nax(5035), y = nay(4060)}
		text = "Magic Circle: 0"
		font = "FONT_OLD_10_WHITE.TGA"
		collection = creatorCollection
	}),
	mlvamU = GUI.Button({
		positionPx = {x = nax(4910), y = nay(4060)}
		sizePx = {width = nax(65), height = nay(115)}
		file = "INV_SLOT.TGA"
		draw = {text = "+"}
		collection = creatorCollection
	}),
	mlvamD = GUI.Button({
		positionPx = {x = nax(4910), y = nay(4170)}
		sizePx = {width = nax(65), height = nay(115)}
		file = "INV_SLOT.TGA"
		draw = {text = "-"}
		collection = creatorCollection
	}),
	oneh = GUI.Draw({
		positionPx = {x = nax(6655), y = nay(2390)}
		text = "One-hand Skill: 10%"
		font = "FONT_OLD_10_WHITE.TGA"
		collection = creatorCollection
	}),
	onehamU = GUI.Button({
		positionPx = {x = nax(6530), y = nay(2390)}
		sizePx = {width = nax(65), height = nay(115)}
		file = "INV_SLOT.TGA"
		draw = {text = "+"}
		collection = creatorCollection
	}),
	onehamD = GUI.Button({
		positionPx = {x = nax(6530), y = nay(2500)}
		sizePx = {width = nax(65), height = nay(115)}
		file = "INV_SLOT.TGA"
		draw = {text = "-"}
		collection = creatorCollection
	}),
	twoh = GUI.Draw({
		positionPx = {x = nax(6655), y = nay(2805)}
		text = "Two-hand Skill: 10%"
		font = "FONT_OLD_10_WHITE.TGA"
		collection = creatorCollection
	}),
	twohamU = GUI.Button({
		positionPx = {x = nax(6530), y = nay(2805)}
		sizePx = {width = nax(65), height = nay(115)}
		file = "INV_SLOT.TGA"
		draw = {text = "+"}
		collection = creatorCollection
	}),
	twohamD = GUI.Button({
		positionPx = {x = nax(6530), y = nay(2920)}
		sizePx = {width = nax(65), height = nay(115)}
		file = "INV_SLOT.TGA"
		draw = {text = "-"}
		collection = creatorCollection
	}),
	bow = GUI.Draw({
		positionPx = {x = nax(6655), y = nay(3225)}
		text = "Bow Skill: 10%"
		font = "FONT_OLD_10_WHITE.TGA"
		collection = creatorCollection
	}),
	bowamU = GUI.Button({
		positionPx = {x = nax(6530), y = nay(3225)}
		sizePx = {width = nax(65), height = nay(115)}
		file = "INV_SLOT.TGA"
		draw = {text = "+"}
		collection = creatorCollection
	}),
	bowamD = GUI.Button({
		positionPx = {x = nax(6530), y = nay(3340)}
		sizePx = {width = nax(65), height = nay(115)}
		file = "INV_SLOT.TGA"
		draw = {text = "-"}
		collection = creatorCollection
	}),
	cbow = GUI.Draw({
		positionPx = {x = nax(6655), y = nay(3640)}
		text = "Crossbow Skill: 10%"
		font = "FONT_OLD_10_WHITE.TGA"
		collection = creatorCollection
	}),
	cbowamU = GUI.Button({
		positionPx = {x = nax(6530), y = nay(3640)}
		sizePx = {width = nax(65), height = nay(115)}
		file = "INV_SLOT.TGA"
		draw = {text = "+"}
		collection = creatorCollection
	}),
	cbowamD = GUI.Button({
		positionPx = {x = nax(6530), y = nay(3755)}
		sizePx = {width = nax(65), height = nay(115)}
		file = "INV_SLOT.TGA"
		draw = {text = "-"}
		collection = creatorCollection
	}),
	tal = GUI.Draw({
		positionPx = {x = nax(6655), y = nay(4060)}
		text = "Talent: None"
		font = "FONT_OLD_10_WHITE.TGA"
		collection = creatorCollection
	}),
	talamU = GUI.Button({
		positionPx = {x = nax(6530), y = nay(4060)}
		sizePx = {width = nax(65), height = nay(115)}
		file = "INV_SLOT.TGA"
		draw = {text = ">"}
		collection = creatorCollection
	}),
	talamD = GUI.Button({
		positionPx = {x = nax(6530), y = nay(4170)}
		sizePx = {width = nax(65), height = nay(115)}
		file = "INV_SLOT.TGA"
		draw = {text = "<"}
		collection = creatorCollection
	})

	lpcount = GUI.Draw({
		positionPx = {x = nax(5760), y = nay(2160)}
		text = "Learning Points: 20"
		font = "FONT_OLD_10_WHITE.TGA"
		collection = creatorCollection
	}),

	charaName = GUI.Input({
		positionPx = {x = nax(5290), y = nay(4855)}
		sizePx = {width = nax(2200), height = nay(265)}
		file = "DLG_CONVERSATION.TGA"
		font = "FONT_OLD_10_WHITE.TGA"
		type = Input.Text
		align = Align.Center
		placeholderText = "Character's Name"
		paddingPx = 4
		collection = creatorCollection
	}),
	charaDesc = GUI.Input({
		positionPx = {x = nax(5290), y = nay(5160)}
		sizePx = {width = nax(2200), height = nay(265)}
		file = "DLG_CONVERSATION.TGA"
		font = "FONT_OLD_10_WHITE.TGA"
		type = Input.Text
		align = Align.Center
		placeholderText = "Character's Description"
		paddingPx = 4
		collection = creatorCollection
	}),

	btnFinish = GUI.Button({
		positionPx = {x = nax(5290), y = nay(5615)}
		sizePx = {width = nax(2200), height = nay(265)}
		file = "INV_SLOT_FOCUS.TGA"
		draw = {text = "Finish Character"}
		collection = creatorCollection
	}),
	fail = GUI.Draw({
		positionPx = {x = nax(5450), y = nay(6145)}
		text = "Character Name can't be empty!"
		font = "FONT_OLD_10_WHITE.TGA"
		collection = creatorCollection
	})
};

function toggleCreator(toggle){
	creatorCollection.setVisible(toggle);

	setCursorVisible(toggle);
	setCursorPosition(4096, 4096);
	disableControls(toggle);

	if(toggle == true){
		local pos = getPlayerPosition(heroId);
		local angle = getPlayerAngle(heroId);
		pos.x = pos.x + (sin(angle * 3.14 / 180.0) * 160);
		pos.z = pos.z + (cos(angle * 3.14 / 180.0) * 170);
		Camera.setPosition(pos.x, pos.y + 30, pos.z);
		Camera.setRotation(0, angle - 180, 0);

		updateCreatorTextures(0, 0, 0, 2);
		updateDiscordState("Creating a Character...");
	}

	Camera.movementEnabled = !toggle;

	hudBarToggle(!toggle);

	creatorGUIvisible = toggle;
	creatorGUI.fail.setVisible(false);
}

local facesTex = [];
for(local i = 0; i <= 5; i++){
	facesTex.push(GUI.Texture({
		positionPx = {x = nax(500), y = nay(2400+(i*600))}
		sizePx = {width = nax(500), height = nay(500)}
		file = ""
		scaling = true
		collection = creatorCollection
	}));
}
local facesScroll = creatorGUI.facesScroll.range;
facesScroll.setMinimum(0);
facesScroll.setMaximum(faces.len() - 1);
//facesScroll.setSmoothMotion(true);

local bodiesTex = [];
for(local i = 0; i <= 5; i++){
	bodiesTex.push(GUI.Texture({
		positionPx = {x = nax(1100), y = nay(2400+(i*600))}
		sizePx = {width = nax(500), height = nay(500)}
		file = ""
		scaling = true
		collection = creatorCollection
	}));
}
local bodiesScroll = creatorGUI.bodiesScroll.range;
bodiesScroll.setMinimum(0);
bodiesScroll.setMaximum(bodies.len() - 1);
//bodiesScroll.setSmoothMotion(true);

local bodyMScroll = creatorGUI.bodyMScroll.range;
//creatorGUI.bodyM.setFont("FONT_OLD_20_WHITE.TGA");
bodyMScroll.setMinimum(0);
bodyMScroll.setMaximum(1);
//bodyMScroll.setSmoothMotion(true);

local bodyTScroll = creatorGUI.bodyTScroll.range;
//creatorGUI.bodyT.setFont("FONT_OLD_20_WHITE.TGA");
bodyTScroll.setMinimum(0);
bodyTScroll.setMaximum(3);
//bodyTScroll.setSmoothMotion(true);

local headMScroll = creatorGUI.headMScroll.range;
//creatorGUI.headM.setFont("FONT_OLD_20_WHITE.TGA");
headMScroll.setMinimum(0);
headMScroll.setMaximum(heads.len() - 1);
//headMScroll.setSmoothMotion(true);

local fatScroll = creatorGUI.fatScroll.range;
//creatorGUI.fat.setFont("FONT_OLD_20_WHITE.TGA");
fatScroll.setMinimum(-0.90);
fatScroll.setMaximum(2.00);
fatScroll.setValue(1.00);
fatScroll.setStep(0.10);
//fatScroll.setSmoothMotion(true);

local heightScroll = creatorGUI.heightScroll.range;
//creatorGUI.height.setFont("FONT_OLD_20_WHITE.TGA");
heightScroll.setMinimum(0.75);
heightScroll.setMaximum(1.15);
heightScroll.setValue(1.00);
heightScroll.setStep(0.01);
//heightScroll.setSmoothMotion(true);

local walkScroll = creatorGUI.walkScroll.range;
//creatorGUI.walk.setFont("FONT_OLD_10_WHITE.TGA")
walkScroll.setMinimum(0);
walkScroll.setMaximum(walking.len() - 1);
//walkScroll.setSmoothMotion(true);

creatorGUI.charaName.maxLetters = 32;
creatorGUI.charaDesc.maxLetters = 64;

local MALE = creator_gender.MALE;
local FEMALE = creator_gender.FEMALE;
local PALE = creator_race.PALE;
local WHITE = creator_race.WHITE;
local LATINO = creator_race.LATINO;
local BLACK = creator_race.BLACK;

local visSetting = {
	[MALE] = {
		[PALE] = ["HUM_BODY_NAKED0", 0, "HUM_HEAD_BALD", 19],
		[WHITE] = ["HUM_BODY_NAKED0", 1, "HUM_HEAD_BALD", 0],
		[LATINO] = ["HUM_BODY_NAKED0", 2, "HUM_HEAD_BALD", 8],
		[BLACK] = ["HUM_BODY_NAKED0", 3, "HUM_HEAD_BALD", 4]
	},
	[FEMALE] = {
		[PALE] = ["HUM_BODY_BABE0", 4, "HUM_HEAD_BABE", 151],
		[WHITE] = ["HUM_BODY_BABE0", 5, "HUM_HEAD_BABE", 137],
		[LATINO] = ["HUM_BODY_BABE0", 6, "HUM_HEAD_BABE", 141],
		[BLACK] = ["HUM_BODY_BABE0", 7, "HUM_HEAD_BABE", 142]
	}
};

local visValue = {
	[MALE] = {
		[PALE] = [0, 0, 0],
		[WHITE] = [0, 0, 0],
		[LATINO] = [0, 0, 0],
		[BLACK] = [0, 0, 0]
	},
	[FEMALE] = {
		[PALE] = [0, 0, 0],
		[WHITE] = [0, 0, 0],
		[LATINO] = [0, 0, 0],
		[BLACK] = [0, 0, 0]
	}
};

local walkvs = "HUMANS.MDS";

function updateCreatorTextures(sex, race, val, category){
	switch(category){
		case 0:
			for(local i = val, texture = 0; i < val + 6; ++i, ++texture){
				if(i in faces[sex][race]){
					facesTex[texture].setFile(faces[sex][race][i]);
				} else {
					facesTex[texture].setFile("");
				}
			}
		break;

		case 1:
			for(local i = val, texture = 0; i < val + 6; ++i, ++texture){
				if(i in bodies[sex][race]){
					bodiesTex[texture].setFile(bodies[sex][race][i]);
				} else {
					bodiesTex[texture].setFile("");
				}
			}
		break;

		case 2:
			for(local i = val, texture = 0; i < val + 6; ++i, ++texture){
				if(i in faces[sex][race]){
					facesTex[texture].setFile(faces[sex][race][i]);
				} else {
					facesTex[texture].setFile("");
				}
				if(i in bodies[sex][race]){
					bodiesTex[texture].setFile(bodies[sex][race][i]);
				} else {
					bodiesTex[texture].setFile("");
				}
			}
		break;
	}

	local vis = visSetting[sex][race];
		setPlayerVisual(heroId, vis[0], vis[1], vis[2], vis[3]);

	facesScroll.setMaximum(faces[sex][race].len()-6 < 0 ? 0 : faces[sex][race].len()-6);
	bodiesScroll.setMaximum(bodies[sex][race].len()-6 < 0 ? 0 : bodies[sex][race].len()-6);
	headMScroll.setMaximum(heads[sex].len() - 1);

	bodiesScroll.setValue(visValue[sex][race][0]);
	headMScroll.setValue(visValue[sex][race][1]);
	facesScroll.setValue(visValue[sex][race][2]);
}

addEventHandler("GUI.onChange", function(object){
	if(creatorGUIvisible){
		local sex = bodyMScroll.getValue().tointeger();
		local race = bodyTScroll.getValue().tointeger();
		local vis = visSetting[sex][race];
		local faceval = facesScroll.getValue();
		local bodyval = bodiesScroll.getValue();
		local headval = headMScroll.getValue();
		local fatness = fatScroll.getValue();
		local height = heightScroll.getValue();
		local walk = walkScroll.getValue();

		switch(object){
			case facesScroll:
				updateCreatorTextures(sex, race, faceval, 0);
			break;
			case bodiesScroll:
				vis[2] = heads[sex][headval];

				updateCreatorTextures(sex, race, bodyval, 1);
			break;
			case bodyTScroll:
				updateCreatorTextures(sex, race, bodyval, 2);
			break;
			case headMScroll:
				setPlayerVisual(heroId, vis[0], vis[1], heads[sex][headval], vis[3]);
				vis[2] = heads[sex][headval];
			break;
			case bodyMScroll:
				vis[0] = body[sex];

				updateCreatorTextures(sex, race, bodyval, 2);
			break;
			case fatScroll:
				setPlayerFatness(heroId, fatness);
			break;
			case heightScroll:
				local heightPacket = PlayerHeightMessage(heroId,
					height
					).serialize();
				heightPacket.send(RELIABLE_ORDERED);
			break;
			case walkScroll:
				creatorGUI.walk.setText(format("Walking Style: %s", walking[walk].name));
				walkvs = walking[walk].style;
			break;
		}

		visValue[sex][race] = [bodyval, headval, faceval];
	}
});

local creatorStats = {
	hp = 40,
	mp = 10,
	str = 10,
	dex = 10,
	mlv = 0,
	oneh = 10,
	twoh = 10,
	bow = 10,
	cbow = 10,
	mcircle = 0,
	tal = 0,
	lp = 20
};
local creatorStatsDefault = {
	hp = 40,
	mp = 10,
	str = 10,
	dex = 10,
	mlv = 0,
	oneh = 10,
	twoh = 10,
	bow = 10,
	cbow = 10,
	mcircle = 0
};

local creatorTalents = [
	"None",
	"Sneaking",
	"Pick Locks",
	"Pickpocket",
	"Runemaking",
	"Alchemy",
	"Smithing",
	"Collecting Trophies",
	"Agility"
];

function updateCreatorStats(attribute, cost, change, guiElement, stringFormat){
	if(change > 0 && creatorStats.lp >= cost){
		creatorStats[attribute] += change;
		creatorStats.lp -= cost;
	} else if(change < 0){
		local newValue = creatorStats[attribute] + change;
		local defaultValue = creatorStatsDefault[attribute];

		if(newValue >= defaultValue){
			creatorStats[attribute] += change;
			creatorStats.lp += cost;
		}
	}

	switch(attribute){
		case "oneh":
		case "twoh":
		case "bow":
		case "cbow":
			guiElement.setText(format("%s: %d%%", stringFormat, creatorStats[attribute]));
		break;
		default:
			guiElement.setText(format("%s: %d", stringFormat, creatorStats[attribute]));
		break;
	}

	creatorGUI.lpcount.setText(format("Learning Points: %d", creatorStats.lp));
}

addEventHandler("GUI.onClick", function(self){
	if(creatorGUIvisible){
		local sex = bodyMScroll.getValue().tointeger();
		local race = bodyTScroll.getValue().tointeger();
		local vis = visSetting[sex][race];

		local index = 999;
		local findHead = "HUM_HEAD_V";
		local findBody = "HUM_BODY_NAKED_V";

		foreach(id, tex in facesTex){
			if(tex == self){
				local name = facesTex[id].getFile();
				do {
					index = name.find(findHead);

					if(index != null){
						name = name.slice(index + findHead.len());
					}
				} while(index != null);
				setPlayerVisual(heroId, vis[0], vis[1], vis[2], name.tointeger());
				vis[3] = name.tointeger();
			}
		}
		foreach(id, tex in bodiesTex){
			if(tex == self){
				local name = bodiesTex[id].getFile();
				do {
					index = name.find(findBody);

					if(index != null){
						name = name.slice(index + findBody.len());
					}
				} while(index != null);
				setPlayerVisual(heroId, vis[0], name.tointeger(), vis[2], vis[3]);
				vis[1] = name.tointeger();
			}
		}

		switch(self){
			case creatorGUI.hpamU:
				updateCreatorStats("hp", 1, 1, creatorGUI.hp, "Health");
			break;
			case creatorGUI.hpamD:
				updateCreatorStats("hp", 1, -1, creatorGUI.hp, "Health");
			break;
			case creatorGUI.mpamU:
				updateCreatorStats("mp", 1, 1, creatorGUI.mp, "Mana");
			break;
			case creatorGUI.mpamD:
				updateCreatorStats("mp", 1, -1, creatorGUI.mp, "Mana");
			break;
			case creatorGUI.stramU:
				updateCreatorStats("str", 2, 1, creatorGUI.str, "Strength");
			break;
			case creatorGUI.stramD:
				updateCreatorStats("str", 2, -1, creatorGUI.str, "Strength");
			break;
			case creatorGUI.dexamU:
				updateCreatorStats("dex", 2, 1, creatorGUI.dex, "Dexterity");
			break;
			case creatorGUI.dexamD:
				updateCreatorStats("dex", 2, -1, creatorGUI.dex, "Dexterity");
			break;
			case creatorGUI.onehamU:
				updateCreatorStats("oneh", 5, 5, creatorGUI.oneh, "One-hand Skill");
			break;
			case creatorGUI.onehamD:
				updateCreatorStats("oneh", 5, -5, creatorGUI.oneh, "One-hand Skill");
			break;
			case creatorGUI.twohamU:
				updateCreatorStats("twoh", 5, 5, creatorGUI.twoh, "Two-hand Skill");
			break;
			case creatorGUI.twohamD:
				updateCreatorStats("twoh", 5, -5, creatorGUI.twoh, "Two-hand Skill");
			break;
			case creatorGUI.bowamU:
				updateCreatorStats("bow", 5, 5, creatorGUI.bow, "Bow Skill");
			break;
			case creatorGUI.bowamD:
				updateCreatorStats("bow", 5, -5, creatorGUI.bow, "Bow Skill");
			break;
			case creatorGUI.cbowamU:
				updateCreatorStats("cbow", 5, 5, creatorGUI.cbow, "Crossbow Skill");
			break;
			case creatorGUI.cbowamD:
				updateCreatorStats("cbow", 5, -5, creatorGUI.cbow, "Crossbow Skill");
			break;
			case creatorGUI.mlvamU:
				updateCreatorStats("mcircle", 10, 1, creatorGUI.mlv, "Magic Circle");
			break;
			case creatorGUI.mlvamD:
				updateCreatorStats("mcircle", 10, -1, creatorGUI.mlv, "Magic Circle");
			break;
			case creatorGUI.talamU:
				if(creatorStats.tal + 1 > creatorTalents.len() - 1){
					creatorStats.tal = 0;
				} else {
					creatorStats.tal += 1;
				}
				creatorGUI.tal.setText(format("Talent: %s", creatorTalents[creatorStats.tal]));
			break;
			case creatorGUI.talamD:
				if(creatorStats.tal - 1 < 0){
					creatorStats.tal = creatorTalents.len() - 1;
				} else {
					creatorStats.tal -= 1;
				}
				creatorGUI.tal.setText(format("Talent: %s", creatorTalents[creatorStats.tal]));
			break;

			case creatorGUI.btnFinish:
				if(creatorGUI.charaName.getText() != ""){
					local creatorFinish = PlayerCreatorMessage(heroId,
						creatorGUI.charaName.getText(),
						creatorGUI.charaDesc.getText(),
						vis[0],
						vis[1],
						vis[2],
						vis[3],
						walkvs,
						heightScroll.getValue(),
						fatScroll.getValue(),
						creatorStats.hp,
						creatorStats.mp,
						creatorStats.str,
						creatorStats.dex,
						creatorStats.oneh,
						creatorStats.twoh,
						creatorStats.bow,
						creatorStats.cbow,
						creatorStats.mcircle,
						creatorTalents[creatorStats.tal]
						).serialize();
					creatorFinish.send(RELIABLE_ORDERED);
					toggleCreator(false);
				} else {
					creatorGUI.fail.setVisible(true);
					setTimer(function(){
						creatorGUI.fail.setVisible(false);
					}, 5000, 1);
				}
			break;
		}
	}
});