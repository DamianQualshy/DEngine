function sendPrivateMessage(from_id, to_id, text){
	if(from_id != to_id){
		if(Players.rawin(to_id)){
			if(Players[to_id].isLogged()){
				sendMessageToPlayer(from_id, 244, 144, 24, format("(%s || %d) >> %s", Players[to_id].getName(), to_id, text));
				sendMessageToPlayer(to_id, 244, 144, 24, format("(%s || %d) << %s", Players[from_id].getName(), from_id, text));

				sendMessageToAdmin(from_id, 244, 144, 24, format("(%s >> %s) %s", Players[from_id].getName(), Players[to_id].getName(), text));
				callEvent("onPlayerSendsMessage", from_id);
			} else sendServerMessage(from_id, "PANEL", format("Player of ID %d is not logged.", to_id));
		} else sendServerMessage(from_id, "PANEL", format("Player of ID %d is not connected.", to_id));
	} else sendServerMessage(from_id, "PANEL", "You can't send private messages to yourself.");
}

addEventHandler("onPlayerCommand", function(id, cmd, params){
	if(!Players[id].isLogged()) return;

	cmd = cmd.tolower();
	switch(cmd){
		case "dm":
		case "pm":
		case "pw":
				strip(params);
					if(params == "") break;
				local id_to = params.slice(0, 1).tointeger();
					if(id_to == "") break;
				local message = params.slice(2);
					if(message == "") break;
			sendPrivateMessage(id, id_to, message);
		break;
		default:
			return;
		break;
	}
});