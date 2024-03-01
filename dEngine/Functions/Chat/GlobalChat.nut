addEventHandler("onPlayerMessage", function(id, text){
	sendMessageToAll(255, 255, 255, format("%s: %s", Players[id].getName(), text));
});