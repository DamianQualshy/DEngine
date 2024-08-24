addEvent("onPlayerEnterArea");
addEvent("onPlayerExitArea");

addEventHandler("onPlayerHit", function(id, kid, desc){
	if(!isNpc(id)){
		local prevHP = Players[id].getHealth();
		Players[id].setHealth(prevHP-desc.damage);
	} else {
		local prevHP = NPCs[id].getHealth();
		NPCs[id].setHealth(prevHP-desc.damage);
	}
})