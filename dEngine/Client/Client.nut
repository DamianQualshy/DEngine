addEvent("onPlayerEnterArea");
addEvent("onPlayerExitArea");

addEventHandler("onInit", function(){
	clearMultiplayerMessages();

	LocalPlayer(heroId);
});