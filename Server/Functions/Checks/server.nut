function isValidTarget(target){
	switch(isNpc(target)){
		case true:
			if(!NPCs.rawin(target)) return false;
		break;
		case false:
			if(!Players.rawin(target)) return false;
		break;
	}

	return true;
}