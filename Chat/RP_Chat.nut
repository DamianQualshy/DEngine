local rpChatTypes = {
	"OOC" : {distance = 2500, color = {r = 64, g = 178, b = 225},
		parseFormat = function(id, text){
			return format("(%s || %d) %s", Players[id].getName(), id, text);
		}
	},
	"ME" : {distance = 2500, color = {r = 232, g = 116, b = 8},
		parseFormat = function(id, text){
			return format("#%s %s#", Players[id].getName(), text);
		}
	},
	"DO" : {distance = 2500, color = {r = 32, g = 225, b = 127},
		parseFormat = function(id, text){
			return format("(%s) #%s#", Players[id].getName(), text);
		}
	},
	"SH" : {distance = 3500, color = {r = 225, g = 40, b = 40},
		parseFormat = function(id, text){
			return format("%s shouts %s", Players[id].getName(), text);
		}
	},
	"WH" : {distance = 350, color = {r = 200, g = 200, b = 200},
		parseFormat = function(id, text){
			return format("%s whispers %s", Players[id].getName(), text);
		}
	},
	"IC" : {distance = 1800, color = {r = 255, g = 255, b = 255},
		parseFormat = function(id, text){
			return format("%s says %s", Players[id].getName(), text);
		}
	}
}

function sendChatMessage(id, type, text){
	if(rpChatTypes.rawin(type)){
		local message = rpChatTypes[type].parseFormat(id, text);
		for(local i = 0, end = getMaxSlots(); i < end; ++i){

				if(!Players.rawin(i)) break;
				if(!Players[i].isLogged()) continue;
				if(Players[i].getWorld() != Players[id].getWorld()) continue;

			if(getDistanceBetweenPlayers(id, i) <= rpChatTypes[type].distance){
				sendMessageToPlayer(i, rpChatTypes[type].color.r, rpChatTypes[type].color.g, rpChatTypes[type].color.b, message);
			} else if(type == "IC" && getDistanceBetweenPlayers(id, i) <= rpChatTypes[type].distance + 200){
				sendMessageToPlayer(i, rpChatTypes[type].color.r, rpChatTypes[type].color.g, rpChatTypes[type].color.b, format("Someone says %s", text));
			} else {
				sendMessageToAdmin(id, serverChatTypes[type].color.r, serverChatTypes[type].color.g, serverChatTypes[type].color.b, message);
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
		case "@":
				if(params == "") break;
			sendChatMessage(id, "OOC", params);
		break;

		case "#":
				if(params == "") break;
			sendChatMessage(id, "ME", params);
		break;

		case ".":
		case "-":
				if(params == "") break;
			sendChatMessage(id, "DO", params);
		break;

		case ",":
		case ";":
				if(params == "") break;
			sendChatMessage(id, "WH", params);
		break;

		case "!":
				if(params == "") break;
			sendChatMessage(id, "SH", params);
		break;

		case ":":
		break;

		default:
				if(text == "") break;
			sendChatMessage(id, "IC", text);
		break;
	}
});

addEventHandler("onPlayerCommand", function(id, cmd, params){
	if(!Players[id].isLogged()) return;

	cmd = cmd.tolower();
	switch(cmd){
		case "b":
		case "ooc":
				if(params == "") break;
			sendChatMessage(id, "OOC", params);
		break;

		case "me":
		case "ja":
				if(params == "") break;
			sendChatMessage(id, "ME", params);
		break;

		case "do":
				if(params == "") break;
			sendChatMessage(id, "DO", params);
		break;

		case "sz":
		case "wh":
				if(params == "") break;
			sendChatMessage(id, "WH", params);
		break;

		case "k":
		case "sh":
				if(params == "") break;
			sendChatMessage(id, "SH", params);
		break;
	}
});