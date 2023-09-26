local statsCollection = GUI.Collection({
	position = {x = anx(400), y = 0}
});
local statsGUI = {
	bg = GUI.Texture({
		positionPx = {x = nax(3670), y = nay(1100)},
		sizePx = {width = nax(4200), height = nay(5915)},
		file = "STATUS_BACK.TGA",
		collection = statsCollection
	}),

	class_name = GUI.Draw({
		positionPx = {x = nax(3925), y = nay(6400)},
		text = "null",
		font = "FONT_OLD_20_WHITE_HI.TGA",
		collection = statsCollection
	}),

	header_char = GUI.Draw({
		positionPx = {x = nax(4415), y = nay(1835)}
		text = "Character"
		collection = statsCollection
	}),
		guild_name = GUI.Draw({
			positionPx = {x = nax(3925), y = nay(2125)}
			text = "Guild null"
			collection = statsCollection
		}),
		level = GUI.Draw({
			positionPx = {x = nax(4930), y = nay(2125)}
			text = "Level null"
			collection = statsCollection
		}),
		experience = GUI.Draw({
			positionPx = {x = nax(3925), y = nay(2350)}
			text = "Experience"
			collection = statsCollection
		}),
		experience_am = GUI.Draw({
			positionPx = {x = nax(4930), y = nay(2350)}
			text = "null"
			collection = statsCollection
		}),
		experience_next = GUI.Draw({
			positionPx = {x = nax(3925), y = nay(2580)}
			text = "Next Level"
			collection = statsCollection
		}),
		experience_next_am = GUI.Draw({
			positionPx = {x = nax(4930), y = nay(2580)}
			text = "null"
			collection = statsCollection
		}),
		learnpoints = GUI.Draw({
			positionPx = {x = nax(3925), y = nay(2805)}
			text = "Learning Points"
			collection = statsCollection
		}),
		learnpoints_am = GUI.Draw({
			positionPx = {x = nax(4930), y = nay(2805)}
			text = "null"
			collection = statsCollection
		}),
		stamina = GUI.Draw({
			positionPx = {x = nax(3925), y = nay(3035)}
			text = "Stamina"
			collection = statsCollection
		}),
		stamina_am = GUI.Draw({
			positionPx = {x = nax(4930), y = nay(3035)}
			text = "null/null"
			collection = statsCollection
		}),

	header_stats = GUI.Draw({
		positionPx = {x = nax(4415), y = nay(3435)}
		text = "Statistics"
		collection = statsCollection
	}),
		strength = GUI.Draw({
			positionPx = {x = nax(3925), y = nay(3720)}
			text = "Strength"
			collection = statsCollection
		}),
		strength_am = GUI.Draw({
			positionPx = {x = nax(4930), y = nay(3720)}
			text = "null"
			collection = statsCollection
		}),
		dexterity = GUI.Draw({
			positionPx = {x = nax(3925), y = nay(3945)}
			text = "Dexterity"
			collection = statsCollection
		}),
		dexterity_am = GUI.Draw({
			positionPx = {x = nax(4930), y = nay(3945)}
			text = "null"
			collection = statsCollection
		}),
		mana = GUI.Draw({
			positionPx = {x = nax(3925), y = nay(4170)}
			text = "Mana"
			collection = statsCollection
		}),
		mana_am = GUI.Draw({
			positionPx = {x = nax(4930), y = nay(4170)}
			text = "null/null"
			collection = statsCollection
		}),
		health = GUI.Draw({
			positionPx = {x = nax(3925), y = nay(4400)}
			text = "Health"
			collection = statsCollection
		}),
		health_am = GUI.Draw({
			positionPx = {x = nax(4930), y = nay(4400)}
			text = "null/null"
			collection = statsCollection
		}),

	header_weapon = GUI.Draw({
		positionPx = {x = nax(4315), y = nay(4855)}
		text = "Weapon Skills"
		collection = statsCollection
	}),
		onehand = GUI.Draw({
			positionPx = {x = nax(3925), y = nay(5160)}
			text = "One-Handed"
			collection = statsCollection
		}),
		onehand_am = GUI.Draw({
			positionPx = {x = nax(4780), y = nay(5160)}
			text = "null"
			collection = statsCollection
		}),
		twohand = GUI.Draw({
			positionPx = {x = nax(3925), y = nay(5385)}
			text = "Two-Handed"
			collection = statsCollection
		}),
		twohand_am = GUI.Draw({
			positionPx = {x = nax(4780), y = nay(5385)}
			text = "null"
			collection = statsCollection
		}),
		bow = GUI.Draw({
			positionPx = {x = nax(3925), y = nay(5615)}
			text = "Bow"
			collection = statsCollection
		}),
		bow_am = GUI.Draw({
			positionPx = {x = nax(4780), y = nay(5615)}
			text = "null"
			collection = statsCollection
		}),
		cbow = GUI.Draw({
			positionPx = {x = nax(3925), y = nay(5840)}
			text = "Crossbow"
			collection = statsCollection
		}),
		cbow_am = GUI.Draw({
			positionPx = {x = nax(4780), y = nay(5840)}
			text = "null"
			collection = statsCollection
		}),

	header_skills = GUI.Draw({
		positionPx = {x = nax(6485), y = nay(1835)}
		text = "Skills"
		collection = statsCollection
	}),
		profession_name = GUI.Draw({
			positionPx = {x = nax(5630), y = nay(2125)}
			text = "Profession Name"
			collection = statsCollection
		}),
		profession_level = GUI.Draw({
			positionPx = {x = nax(6910), y = nay(2125)}
			text = "Level null"
			collection = statsCollection
		}),
		profession_exp = GUI.Draw({
			positionPx = {x = nax(5630), y = nay(2350)}
			text = "Experience"
			collection = statsCollection
		}),
		profession_exp_am = GUI.Draw({
			positionPx = {x = nax(6910), y = nay(2350)}
			text = "null"
			collection = statsCollection
		}),
		profession_next = GUI.Draw({
			positionPx = {x = nax(5630), y = nay(2580)}
			text = "Next Level"
			collection = statsCollection
		}),
		profession_next_am = GUI.Draw({
			positionPx = {x = nax(6910), y = nay(2580)}
			text = "null"
			collection = statsCollection
		}),
		mining = GUI.Draw({
			positionPx = {x = nax(5630), y = nay(2905)}
			text = "Mining"
			collection = statsCollection
		}),
		mining_am = GUI.Draw({
			positionPx = {x = nax(6610), y = nay(2905)}
			text = "null"
			collection = statsCollection
		}),
		hunting = GUI.Draw({
			positionPx = {x = nax(5630), y = nay(3135)}
			text = "Hunting"
			collection = statsCollection
		}),
		hunting_am = GUI.Draw({
			positionPx = {x = nax(6610), y = nay(3135)}
			text = "null"
			collection = statsCollection
		}),/*
		herbalism = GUI.Draw({
			positionPx = {x = nax(5630), y = any(430)}
			text = "Herbalism"
			collection = statsCollection
		}),
		herbalism_am = GUI.Draw({
			positionPx = {x = nax(6610), y = any(430)}
			text = "null"
			collection = statsCollection
		}), */
		sneaking = GUI.Draw({
			positionPx = {x = nax(5630), y = nay(3490)}
			text = "Sneaking"
			collection = statsCollection
		}),
		sneaking_lvl = GUI.Draw({
			positionPx = {x = nax(6610), y = nay(3490)}
			text = "null"
			collection = statsCollection
		}),
		picklock = GUI.Draw({
			positionPx = {x = nax(5630), y = nay(3715)}
			text = "Pick Locks"
			collection = statsCollection
		}),
		picklock_lvl = GUI.Draw({
			positionPx = {x = nax(6610), y = nay(3715)}
			text = "null"
			collection = statsCollection
		}),
		pickpocket = GUI.Draw({
			positionPx = {x = nax(5630), y = nay(3945)}
			text = "Pick Pockets"
			collection = statsCollection
		}),
		pickpocket_lvl = GUI.Draw({
			positionPx = {x = nax(6610), y = nay(3945)}
			text = "null"
			collection = statsCollection
		}),
		alchemy = GUI.Draw({
			positionPx = {x = nax(5630), y = nay(4172)}
			text = "Alchemy"
			collection = statsCollection
		}),
		alchemy_lvl = GUI.Draw({
			positionPx = {x = nax(6610), y = nay(4172)}
			text = "null"
			collection = statsCollection
		}),
		smithing = GUI.Draw({
			positionPx = {x = nax(5630), y = nay(4400)}
			text = "Smithing"
			collection = statsCollection
		}),
		smithing_lvl = GUI.Draw({
			positionPx = {x = nax(6610), y = nay(4400)}
			text = "null"
			collection = statsCollection
		}),
		trophies = GUI.Draw({
			positionPx = {x = nax(5630), y = nay(4625)}
			text = "Take Trophies"
			collection = statsCollection
		}),
		trophies_lvl = GUI.Draw({
			positionPx = {x = nax(6610), y = nay(4625)}
			text = "null"
			collection = statsCollection
		}),
		acrobatic = GUI.Draw({
			positionPx = {x = nax(5630), y = nay(4855)}
			text = "Agility"
			collection = statsCollection
		}),
		acrobatic_lvl = GUI.Draw({
			positionPx = {x = nax(6610), y = nay(4855)}
			text = "null"
			collection = statsCollection
		}),
		magiccircle = GUI.Draw({
			positionPx = {x = nax(5630), y = nay(5080)}
			text = "Magic Circle"
			collection = statsCollection
		}),
		magiccircle_lvl = GUI.Draw({
			positionPx = {x = nax(6610), y = nay(5080)}
			text = "Circle null"
			collection = statsCollection
		}),

	switch_stats = GUI.Button({
		positionPx = {x = nax(6100), y = nay(5690)}
		sizePx = {width = nax(980), height = nay(530)}
		file = "INV_SLOT_FOCUS.TGA"
		draw = {text = "Switch Stats"}
		collection = statsCollection
	})
}

local statsVal = {
	guildname = "",
	classname = "",
	health = -1,
	max_health = -1,
	mana = -1,
	max_mana = -1,
	stamina = -1,
	level = -1,
	experience = -1,
	experience_next = -1,
	learnpoints = -1,
	profession_name = "",
	profession_lvl = -1,
	profession_exp = -1,
	profession_exp_next = -1,
	mining = -1,
	hunting = -1,
	herbalism = -1,
	strength = -1,
	dexterity = -1,
	onehand = -1,
	twohand = -1,
	bow = -1,
	cbow = -1,
	magiccircle = -1,
	sneaking = -1,
	picklocks = -1,
	pickpocket = -1,
	runes = -1,
	alchemy = -1,
	smithing = -1,
	trophies = -1,
	acrobatic = -1
};

function toggleStats(toggle){
	if(!isGUIOpened(guiCheck.stats) && !isPlayerBusy() && !chatInputIsOpen()){
		statsCollection.setVisible(toggle);
		disableControls(toggle);
		setCursorVisible(toggle);

		if(toggle == true){
			local playerPos = getPlayerPosition(heroId);
			local playerAngle = getPlayerAngle(heroId);

			local forwardVector = Vec3(
				sin(playerAngle * 3.14 / 180.0),
				0,
				cos(playerAngle * 3.14 / 180.0)
			);

			local rightVector = Vec3(
				cos(playerAngle * 3.14 / 180.0),
				0,
				-sin(playerAngle * 3.14 / 180.0)
			);

			local xOffset = 110.0;
			local zOffset = 110.0;

			local initialCameraPos = Vec3(
				playerPos.x + (forwardVector.x * 180),
				playerPos.y,
				playerPos.z + (forwardVector.z * 180)
			);

			Camera.setPosition(initialCameraPos.x, initialCameraPos.y, initialCameraPos.z);
			Camera.setRotation(0, playerAngle - 180, 0);

			local targetCameraPos = Vec3(
				initialCameraPos.x - xOffset * rightVector.x,
				initialCameraPos.y,
				initialCameraPos.z - zOffset * rightVector.z
			);

			Camera.setPosition(targetCameraPos.x, targetCameraPos.y, targetCameraPos.z);

			stopAni(heroId);
			playAni(heroId, "S_FIRE_VICTIM");

				updateStats();
		} else {
			playAni(heroId, "S_RUN");
		}

		hudBarToggle(!toggle);
		Camera.movementEnabled = !toggle;

		statsGUIvisible = toggle;
	}
}

addEventHandler("GUI.onClick", function(self){
	switch(self){
		case statsGUI.switch_stats:
			statsGUIswitch_num = !statsGUIswitch_num;
			updateStats();
		break;
	}
});

function getExperienceNextName(value){
	if(statsGUIswitch_num){
		if(value == statsGUI.experience_am.getText().tointeger()) return "(Capped)";
		return format("%d", value);
	} else return format("%d", value);
}

function getWeaponMeleeName(value){
	if(statsGUIswitch_num){
		if (value <= 29) return "Rookie";
		if (value <= 59) return "Warrior";
		return "Master";
	} else return format("%d%% Chance", value);
}

function getWeaponRangedName(value){
	if(statsGUIswitch_num){
		if (value <= 29) return "Rookie";
		if (value <= 59) return "Marksman";
		return "Master";
	} else return format("%d%% Chance", value);
}

function getGatheringName(value){
	if(statsGUIswitch_num){
		if (value <= 14) return "Amateur";
		if (value <= 29) return "Skilled";
		if (value <= 49) return "Proficient";
		if (value <= 79) return "Born Gatherer";
		return "Masterful";
	} else return format("%d/1000000", value);
}

function getTalentName(value){
	if(value == 0){
		return "Not learned"
	} else return format("Level %d", value);
}

function updateStats(){
	statsGUI.guild_name.setText(statsVal.guildname);
	statsGUI.class_name.setText(statsVal.classname);

	statsGUI.level.setText(format("Level %d", statsVal.level));
	statsGUI.experience_am.setText(statsVal.experience);
	statsGUI.experience_next_am.setText(getExperienceNextName(statsVal.experience_next));
	statsGUI.learnpoints_am.setText(statsVal.learnpoints);
	statsGUI.stamina_am.setText(format("%d/100", statsVal.stamina));

	statsGUI.strength_am.setText(statsVal.strength);
	statsGUI.dexterity_am.setText(statsVal.dexterity);
	statsGUI.mana_am.setText(format("%d/%d", statsVal.mana, statsVal.max_mana));
	statsGUI.health_am.setText(format("%d/%d", statsVal.health, statsVal.max_health));

	statsGUI.onehand_am.setText(getWeaponMeleeName(statsVal.onehand));
	statsGUI.twohand_am.setText(getWeaponMeleeName(statsVal.twohand));
	statsGUI.bow_am.setText(getWeaponRangedName(statsVal.bow));
	statsGUI.cbow_am.setText(getWeaponRangedName(statsVal.cbow));

	statsGUI.profession_name.setText(statsVal.profession_name);
	statsGUI.profession_level.setText(format("Level %d", statsVal.profession_lvl));
	statsGUI.profession_exp_am.setText(statsVal.profession_exp);
	statsGUI.profession_next_am.setText(statsVal.profession_exp_next);

	statsGUI.mining_am.setText(getGatheringName(statsVal.mining));
	statsGUI.hunting_am.setText(getGatheringName(statsVal.hunting));
	//statsGUI.herbalism_am.setText(getGatheringName(statsVal.herbalism));

	statsGUI.sneaking_lvl.setText(getTalentName(statsVal.sneaking));
	statsGUI.picklock_lvl.setText(getTalentName(statsVal.picklocks));
	statsGUI.pickpocket_lvl.setText(getTalentName(statsVal.pickpocket));
	//statsGUI.runes_lvl.setText(getTalentName(statsVal.runes));
	statsGUI.alchemy_lvl.setText(getTalentName(statsVal.alchemy));
	statsGUI.smithing_lvl.setText(getTalentName(statsVal.smithing));
	statsGUI.trophies_lvl.setText(getTalentName(statsVal.trophies));
	statsGUI.acrobatic_lvl.setText(getTalentName(statsVal.acrobatic));
	statsGUI.magiccircle_lvl.setText(format("Circle %d", statsVal.magiccircle));
}

PlayerStatsMessage.bind(function(message){
	statsVal = message;

	updateStats();
});

PlayerClassMessage.bind(function(message){
	statsVal.guildname = message.guildname;
	statsVal.classname = message.classname;

	updateStats();
});

PlayerHealthMessage.bind(function(message){
	statsVal.health = message.health;
	statsVal.max_health = message.max_health;

	updateStats();
	updateBarStats(message.health, message.max_health);
});

PlayerManaMessage.bind(function(message){
	statsVal.mana = message.mana;
	statsVal.max_mana = message.max_mana;

	updateStats();
});

PlayerStrengthMessage.bind(function(message){
	statsVal.strength = message.strength;

	updateStats();
});

PlayerDexterityMessage.bind(function(message){
	statsVal.dexterity = message.dexterity;

	updateStats();
});

PlayerStaminaMessage.bind(function(message){
	statsVal.stamina = message.stamina;

	updateStats();
});

PlayerExpMessage.bind(function(message){
	statsVal.level = message.level;
	statsVal.experience = message.experience;
	statsVal.experience_next = message.experience_next;
	statsVal.learnpoints = message.learnpoints;

	updateStats();
});

PlayerProfessionMessage.bind(function(message){
	statsVal.profession_name = message.profession_name;

	updateStats();
});

PlayerProfessionExpMessage.bind(function(message){
	statsVal.profession_lvl = message.profession_lvl;
	statsVal.profession_exp = message.profession_exp;
	statsVal.profession_exp_next = message.profession_exp_next;

	updateStats();
});

PlayerOneHandMessage.bind(function(message){
	statsVal.onehand = message.onehand;

	updateStats();
});

PlayerTwoHandMessage.bind(function(message){
	statsVal.twohand = message.twohand;

	updateStats();
});

PlayerBowMessage.bind(function(message){
	statsVal.bow = message.bow;

	updateStats();
});

PlayerCBowMessage.bind(function(message){
	statsVal.cbow = message.cbow;

	updateStats();
});

PlayerMCircleMessage.bind(function(message){
	statsVal.magiccircle = message.magiccircle;

	updateStats();
});

PlayerMiningMessage.bind(function(message){
	statsVal.mining = message.mining;

	updateStats();
});

PlayerHuntingMessage.bind(function(message){
	statsVal.hunting = message.hunting;

	updateStats();
});

PlayerHerbalismMessage.bind(function(message){
	statsVal.herbalism = message.herbalism;

	updateStats();
});

PlayerSneakingMessage.bind(function(message){
	statsVal.sneaking = message.sneaking;

	updateStats();
});

PlayerPicklockMessage.bind(function(message){
	statsVal.picklocks = message.picklocks;

	updateStats();
});

PlayerPickpocketMessage.bind(function(message){
	statsVal.pickpocket = message.pickpocket;

	updateStats();
});

PlayerRunemakingMessage.bind(function(message){
	statsVal.runes = message.runes;

	updateStats();
});

PlayerAlchemyMessage.bind(function(message){
	statsVal.alchemy = message.alchemy;

	updateStats();
});

PlayerSmithingMessage.bind(function(message){
	statsVal.smithing = message.smithing;

	updateStats();
});

PlayerTrophiesMessage.bind(function(message){
	statsVal.trophies = message.trophies;

	updateStats();
});

PlayerAcrobaticMessage.bind(function(message){
	statsVal.acrobatic = message.acrobatic;

	updateStats();
});


addEventHandler("onKey", function(key){
	switch(key){
		case KEY_B:
		case KEY_C:
			toggleStats(!statsGUIvisible);
		break;
	}
});