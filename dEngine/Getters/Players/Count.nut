function getNPCCount(){
	local totalNPCs = 0;
	foreach(npc in NPCs){
		++totalNPCs;
	}
	return totalNPCs;
}

function getNPCCountOnMap(world_name){
	local totalNPCs = 0;
	foreach(npc in NPCs){
		if(npc.getWorld() == world_name) ++totalNPCs;
	}
	return totalNPCs;
}

function getPlayerCountOnMap(world_name){
	local totalPlayers = 0;
	foreach(player in Players){
		if(player.getWorld() == world_name) ++totalPlayers;
	}
	return totalPlayers;
}