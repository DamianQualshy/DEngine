function doesPlayerExist(pid){
	if(!isPlayerConnected(pid)){
		print("Player is not Connected!");
		return false;
	}

	if(!isPlayerSpawned(pid)){
		print("Player is not Spawned!");
		return false;
	}

	return true;
}

