local hudCollection = GUI.Collection({
	position = {x = 0, y = 0}
});
local hudGUI = {
	hpBar = GUI.Bar({
		positionPx = {x = nax(50), y = nay(7500)}
		sizePx = {width = nax(1000), height = nay(180)}
		marginPx = [3, 7]
		file = "BAR_BACK.TGA"
		progress = {file = "BAR_HEALTH.TGA"}
		stretching = true
		visible = false
		maximum = 40
		collection = hudCollection
	}),
	mpBar = GUI.Bar({
		positionPx = {x = nax(50), y = nay(7700)}
		sizePx = {width = nax(1000), height = nay(180)}
		marginPx = [3, 7]
		file = "BAR_BACK.TGA"
		progress = {file = "BAR_MANA.TGA"}
		stretching = true
		visible = false
		maximum = 40
		collection = hudCollection
	}),
	staminaBar = GUI.Bar({
		positionPx = {x = nax(50), y = nay(7900)}
		sizePx = {width = nax(1000), height = nay(180)}
		marginPx = [3, 7]
		file = "BAR_BACK.TGA"
		progress = {file = "BAR_MISC.TGA"}
		stretching = true
		visible = false
		maximum = 100
		collection = hudCollection
	}),
	focusBar = GUI.Bar({
		positionPx = {x = nax(3596), y = nay(100)}
		sizePx = {width = nax(1000), height = nay(180)}
		marginPx = [3, 7]
		file = "BAR_BACK.TGA"
		progress = {file = "BAR_HEALTH.TGA"}
		stretching = true
		visible = false
		maximum = 10
	})
};

function hudBarToggle(toggle){
	hudCollection.setVisible(toggle);
}

PlayerStatsMessage.bind(function(message){
	hudGUI.hpBar.setMaximum(message.max_health);
	hudGUI.hpBar.setValue(message.health);

	hudGUI.mpBar.setMaximum(message.max_mana);
	hudGUI.mpBar.setValue(message.mana);

	hudGUI.staminaBar.setValue(message.stamina);
});

PlayerHealthMessage.bind(function(message){
	hudGUI.hpBar.setMaximum(message.max_health);
	hudGUI.hpBar.setValue(message.health);
});

PlayerManaMessage.bind(function(message){
	hudGUI.mpBar.setMaximum(message.max_mana);
	hudGUI.mpBar.setValue(message.mana);
});

PlayerStaminaMessage.bind(function(message){
	hudGUI.staminaBar.setValue(message.stamina);
});

addEventHandler("onFocus", function(currentId, previousId){
	local updateFocus = CollectFocusMessage(heroId,
		currentId
		).serialize();
	updateFocus.send(RELIABLE_ORDERED);
});

FocusHealthMessage.bind(function(message){
	if(message.focusId != -1){
		hudGUI.focusBar.setVisible(true);

		hudGUI.focusBar.setMaximum(message.max_health);
		hudGUI.focusBar.setValue(message.health);
	} else {
		hudGUI.focusBar.setVisible(false);

		hudGUI.focusBar.setMaximum(0);
		hudGUI.focusBar.setValue(0);
	}
});

addEventHandler("onInit", function(){
	setHudMode(HUD_HEALTH_BAR, HUD_MODE_HIDDEN);
	setHudMode(HUD_MANA_BAR, HUD_MODE_HIDDEN);
	setHudMode(HUD_SWIM_BAR, HUD_MODE_HIDDEN);
	setHudMode(HUD_FOCUS_BAR, HUD_MODE_HIDDEN);
});