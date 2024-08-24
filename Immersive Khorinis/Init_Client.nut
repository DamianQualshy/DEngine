addEventHandler("onKeyDown", function(key){
	if(key == KEY_LCONTROL){
		initDialogue(getFocusNpc());
	}
})

addEventHandler("onEnterArea", function(area){
	local areaFunction = AreaManager.enterCallbacks[area];
	if(areaFunction != null) AreaManager.enterCallbacks[area]();

	print("testu testu 1")
});

addEventHandler("onExitArea", function(area){
	local areaFunction = AreaManager.exitCallbacks[area];
	if(areaFunction != null) AreaManager.exitCallbacks[area]();
	print("testu testu 2")
});

/* NPCs <- {};

NPCIdentificationMessage.bind(function(message){
	NPCs.rawset(message.id);
}); */