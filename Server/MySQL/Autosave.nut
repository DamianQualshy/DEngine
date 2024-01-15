local autosaveTimer;
local autosaveInterval = 600000; //10 minutes

addEventHandler("onInit", function(){
	autosaveTimer = setTimer(function(){
		for(local i = 0, end = getMaxSlots(); i < end; ++i){
			if(!Players.rawin(i)) continue;
			if(!Players[i].isLogged()) continue;
			if(!Players[i].isSpawned()) continue;

			Players[i].save();
			sendServerMessage(i, "PANEL", "Autosave!");
		}
		foreach(npc in NPCs){
			NPCs[npc.id].save();
		}
	}, autosaveInterval, 0);
});

addEventHandler("onExit", function(){
	killTimer(autosaveTimer);
});