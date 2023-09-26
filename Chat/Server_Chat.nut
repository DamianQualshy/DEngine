local serverChatTypes = {
	"GOOC" : {color = {r = 32, g = 255, b = 107},
		parseFormat = function(id, text){
			return format("(%s || %d) %s", Players[id].getName(), id, text);
		}
	},
	"GDO" : {color = {r = 64, g = 148, b = 255},
		parseFormat = function(id, text){
			return format("#%s#", text);
		}
	},
	"GMSG" : {color = {r = 0, g = 205, b = 186},
		parseFormat = function(id, text){
			return format("(%s) %s", Players[id].getName(), text);
		}
	},
	"PANEL" : {color = {r = 186, g = 0, b = 0},
		parseFormat = function(id, text){
			return format("(SERVER) %s", text);
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

		if(type == "PANEL"){
			sendMessageToPlayer(id, serverChatTypes[type].color.r, serverChatTypes[type].color.g, serverChatTypes[type].color.b, message);
		}
		if(type == "GOOC" || type == "GDO" || type == "SERVER"){
			sendMessageToAll(serverChatTypes[type].color.r, serverChatTypes[type].color.g, serverChatTypes[type].color.b, message);
		}
		if(type == "GMSG"){
			for(local i = 0, end = getMaxSlots(); i < end; ++i){
				if(!Players.rawin(i)) break;
				if(!Players[i].isLogged()) continue;

				if(Players[i].getPermissions() >= perm.MODERATOR){
					sendMessageToPlayer(i, serverChatTypes[type].color.r, serverChatTypes[type].color.g, serverChatTypes[type].color.b, message);
				}
			}
		}
	}
}

addEventHandler("onPlayerMessage", function(id, text){
	if(!Players[id].isLogged()) return;

	strip(text);
		local msgType = text.slice(0, 1);
		local params = text.slice(1);

	switch(msgType){
		case ":":
				if(params == "") break;
			sendServerMessage(id, "GOOC", params);
		break;
	}
});

addEventHandler("onPlayerCommand", function(id, cmd, params){
	if(!Players[id].isLogged()) return;

	cmd = cmd.tolower();
	switch(cmd){
		case "g":
		case "gooc":
				if(params == "") break;
			sendServerMessage(id, "GOOC", params);
		break;

		case "p":
		case "post":
		case "gdo":
				if(params == "") break;
			if(checkPermissions(id, perm.MODERATOR)) sendServerMessage(id, "GDO", params);
		break;

		case "msg":
				if(params == "") break;
			if(checkPermissions(id, perm.MODERATOR)) sendServerMessage(id, "GMSG", params);
		break;
	}
});