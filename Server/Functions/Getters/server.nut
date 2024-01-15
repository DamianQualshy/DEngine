function getServerName(){
	return SERVER_NAME;
}

function getNPCCount(){
	local totalNPCs = 0;
	foreach(npc in NPCs){
		++totalNPCs;
	}
	return totalNPCs;
}

function getTotalPlayers(){
	local totalPlayers = 0;
	for(local i = 0, end = getMaxSlots(); i < end; ++i){
		if(!Players.rawin(i)) continue;
		if(!Players[i].isLogged) continue;

		++totalPlayers;
	}
	return totalPlayers;
}

function getDistanceBetweenPlayers(centre_id, distance_id){
	if(centre_id != distance_id){
		local center = Players[centre_id].getPosition();
		local distance = Players[distance_id].getPosition();

		if(Players[distance_id].getWorld() == Players[centre_id].getWorld()){
			return getDistance3d(center.x, center.y, center.z, distance.x, distance.y, distance.z);
		} else return false;
	}
}

function getDistanceBetweenNPCs(centre_id, distance_id){
	if(centre_id != distance_id){
		local center = NPCs[centre_id].getPosition();
		local distance = NPCs[distance_id].getPosition();

		if(NPCs[distance_id].getWorld() == NPCs[centre_id].getWorld()){
			return getDistance3d(center.x, center.y, center.z, distance.x, distance.y, distance.z);
		} else return false;
	}
}

function getPlayerDistanceToNpc(centre_id, distance_id){
	local center = Players[centre_id].getPosition();
	local distance = NPCs[distance_id].getPosition();

	if(NPCs[distance_id].getWorld() == Players[centre_id].getWorld()){
		return getDistance3d(center.x, center.y, center.z, distance.x, distance.y, distance.z);
	} else return false;
}