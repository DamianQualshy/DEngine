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

	facesScroll = GUI.ScrollBar({
		positionPx = {x = nax(1000), y = nay(2580)}
		sizePx = {width = nax(85), height = nay(3185)}
		range = {
			file = "MENU_SLIDER_BACK.TGA"
			indicator = {file = "MENU_SLIDER_POS.TGA"}
			orientation = Orientation.Vertical
			minimum = 0
			maximum = faces.len() - 1
		}
		keysEnabled = false
		collection = creatorCollection
	}),
	bodiesScroll = GUI.ScrollBar({
		positionPx = {x = nax(1600), y = nay(2580)}
		sizePx = {width = nax(85), height = nay(3185)}
		range = {
			file = "MENU_SLIDER_BACK.TGA"
			indicator = {file = "MENU_SLIDER_POS.TGA"}
			orientation = Orientation.Vertical
			minimum = 0
			maximum = bodies.len() - 1
		}
		keysEnabled = false
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
			minimum = 0
			maximum = body.len() - 1
		}
		keysEnabled = false
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
			minimum = 0
			maximum = heads.len() - 1
		}
		keysEnabled = false
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
			minimum = 0
			maximum = creator_race.len() - 1
		}
		keysEnabled = false
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
			minimum = -0.90
			maximum = 2.00
			value = 1.00
			step = 0.10
		}
		keysEnabled = false
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
			minimum = 0.75
			maximum = 1.15
			value = 1.00
			step = 0.01
		}
		keysEnabled = false
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
			minimum = 0
			maximum = walking.len() - 1
		}
		keysEnabled = false
		collection = creatorCollection
	}),

	btnFinish = GUI.Button({
		positionPx = {x = nax(5290), y = nay(5615)}
		sizePx = {width = nax(2200), height = nay(265)}
		file = "INV_SLOT_FOCUS.TGA"
		draw = {text = "Finish Character"}
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
		Camera.setPosition(pos.x, pos.y + 40, pos.z);
		Camera.setRotation(0, angle - 180, 0);

		updateCreatorTextures(0, 0, 0, 2);
		updateDiscordState("Creating a Character...");
	}

	Camera.movementEnabled = !toggle;
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

local facesScroll = creatorGUI.facesScroll.range;
local bodiesScroll = creatorGUI.bodiesScroll.range;
local bodyMScroll = creatorGUI.bodyMScroll.range;
local bodyTScroll = creatorGUI.bodyTScroll.range;
local headMScroll = creatorGUI.headMScroll.range;
local fatScroll = creatorGUI.fatScroll.range;
local heightScroll = creatorGUI.heightScroll.range;
local walkScroll = creatorGUI.walkScroll.range;

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
				heroUpdateHeight(height);
			break;
			case walkScroll:
				creatorGUI.walk.setText(format("Walking Style: %s", walking[walk].name));
				walkvs = walking[walk].style;
			break;
		}

		visValue[sex][race] = [bodyval, headval, faceval];
});

addEventHandler("GUI.onClick", function(self){
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
			case creatorGUI.btnFinish:
					heroCreate({
						bodyModel = vis[0],
						bodyTex = vis[1],
						headModel = vis[2],
						headTex = vis[3],
						walkAni = walkvs,
						height = heightScroll.getValue(),
						fatness = fatScroll.getValue()
					});
					toggleCreator(false);
			break;
		}
});