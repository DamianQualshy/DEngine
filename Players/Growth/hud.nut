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
		visible = true
		maximum = 10
		collection = hudCollection
	}),
	mpBar = GUI.Bar({
		positionPx = {x = nax(50), y = nay(7700)}
		sizePx = {width = nax(1000), height = nay(180)}
		marginPx = [3, 7]
		file = "BAR_BACK.TGA"
		progress = {file = "BAR_MANA.TGA"}
		stretching = true
		visible = true
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
		visible = true
		maximum = 100
		collection = hudCollection
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

addEventHandler("onInit", function(){
	setHudMode(HUD_ALL, HUD_MODE_HIDDEN);
});