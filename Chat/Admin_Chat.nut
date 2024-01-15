function sendMessageToAdmin(id, r, g, b, message){
	for(local i = 0, end = getMaxSlots(); i < end; ++i){

		if(!Players.rawin(i)) continue;
		if(!Players[i].isLogged()) continue;
		if(i == id) continue;

		if(Players[i].getPermissions() >= perm.ADMIN){
			sendMessageToPlayer(i, r, g, b, message);
		}
	}
}