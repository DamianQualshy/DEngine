local serverChatTypes = {
	"PANEL" : {color = {r = 186, g = 0, b = 0},
		parseFormat = function(id, text){
			return format("(PANEL) %s", text);
		}
	},
	"SERVER" : {color = {r = 255, g = 0, b = 0},
		parseFormat = function(id, text){
			return format("(SERVER) %s", text);
		}
	}
}

function sendServerMessage(id, type, text){
	if(serverChatTypes.rawin(type)){
		local message = serverChatTypes[type].parseFormat(id, text);

		switch(_type){
			case "PANEL":
				sendMessageToPlayer(id, serverChatTypes[type].color.r, serverChatTypes[type].color.g, serverChatTypes[type].color.b, message);
			break;
			case "SERVER":
				sendMessageToAll(serverChatTypes[type].color.r, serverChatTypes[type].color.g, serverChatTypes[type].color.b, message);
			break;
		}
	}
}