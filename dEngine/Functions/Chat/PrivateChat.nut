function sendPrivateMessage(from_id, to_id, text){
	if(from_id != to_id){
		if(Players.rawin(to_id)){
			if(Players[to_id].isLogged()){
				sendMessageToPlayer(from_id, 244, 144, 24, format("(%s || %d) >> %s", Players[to_id].getName(), to_id, text));
				sendMessageToPlayer(to_id, 244, 144, 24, format("(%s || %d) << %s", Players[from_id].getName(), from_id, text));

				sendMessageToAdmin(from_id, 244, 144, 24, format("(%s >> %s) %s", Players[from_id].getName(), Players[to_id].getName(), text));
			} else sendServerMessage(from_id, "PANEL", format("Player of ID %d is not logged.", to_id));
		} else sendServerMessage(from_id, "PANEL", format("Player of ID %d is not connected.", to_id));
	} else sendServerMessage(from_id, "PANEL", "You can't send private messages to yourself.");
}