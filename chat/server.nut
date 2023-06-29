local chatTypes = {
	"OOC" : {distance = 1500, color = {r = 64, g = 178, b = 225},
		parseFormat = function(id, text){
			return format("(%s || %d) %s", Players[id].getUsername(), id, text);
		}
	},
	"ME" : {distance = 1500, color = {r = 232, g = 116, b = 8},
		parseFormat = function(id, text){
			return format("#%s %s#", Players[id].getUsername(), text);
		}
	},
	"DO" : {distance = 1500, color = {r = 32, g = 225, b = 127},
		parseFormat = function(id, text){
			return format("(%s) #%s#", Players[id].getUsername(), text);
		}
	},
	"SH" : {distance = 2300, color = {r = 200, g = 32, b = 32},
		parseFormat = function(id, text){
			return format("%s krzyczy %s", Players[id].getUsername(), text);
		}
	},
	"WH" : {distance = 500, color = {r = 200, g = 200, b = 200},
		parseFormat = function(id, text){
			return format("%s szepcze %s", Players[id].getUsername(), text);
		}
	},
	"PM" : {distance = -1, color = {r = 244, g = 144, b = 24},
		parseFormat = function(id, text){
			return;
		}
	},
	"IC" : {distance = 1300, color = {r = 255, g = 255, b = 255},
		parseFormat = function(id, text){
			return format("%s mówi %s", Players[id].getUsername(), text);
		}
	},
	"GOOC" : {distance = -1, color = {r = 32, g = 255, b = 107},
		parseFormat = function(id, text){
			return format("(%s || %d) %s", Players[id].getUsername(), id, text);
		}
	},
	"GDO" : {distance = -1, color = {r = 64, g = 148, b = 255},
		parseFormat = function(id, text){
			return format("#%s#", text);
		}
	},
	"GMSG" : {distance = -1, color = {r = 0, g = 205, b = 186},
		parseFormat = function(id, text){
			return format("(%s) %s", Players[id].getUsername(), text);
		}
	},
	"PANEL" : {distance = -1, color = {r = 186, g = 0, b = 0},
		parseFormat = function(id, text){
			return format("(SERVER) %s", text);
		}
	},
	"SERVER" : {distance = -1, color = {r = 186, g = 0, b = 0},
		parseFormat = function(id, text){
			return format("(SERVER) %s", text);
		}
	}
}

function sendChatMessage(id, type, text){
	if(chatTypes.rawin(type)){
		local message = chatTypes[type].parseFormat(id, text);

		if(chatTypes[type].distance > -1){
			local center = Players[id].getPosition();
			for(local i = 0, end = getMaxSlots(); i < end; ++i){
					if(!Players.rawin(i)) break;
					if(!Players[i].isLogged()) continue;
				local distance = Players[i].getPosition();
				if(getDistance3d(center.x, center.y, center.z, distance.x, distance.y, distance.z) <= chatTypes[type].distance){
					sendMessageToPlayer(i, chatTypes[type].color.r, chatTypes[type].color.g, chatTypes[type].color.b, message);
				}
			}
		} else {
			if(type == "PANEL"){
				sendMessageToPlayer(id, chatTypes[type].color.r, chatTypes[type].color.g, chatTypes[type].color.b, message);
			}
			if(type == "GOOC" || type == "GDO" || type == "SERVER"){
				sendMessageToAll(chatTypes[type].color.r, chatTypes[type].color.g, chatTypes[type].color.b, message);
			}
			if(type == "PM"){
				strip(text);
				local pm_to = text.slice(0, 1).tointeger();
				local pm_message = text.slice(2);
					if(id != pm_to){
						if(isPlayerConnected(pm_to)){
							if(Players[pm_to].isLogged()){
								sendMessageToPlayer(id, chatTypes[type].color.r, chatTypes[type].color.g, chatTypes[type].color.b, format("(%s || %d) >> %s", Players[pm_to].getUsername(), pm_to, pm_message));
								sendMessageToPlayer(pm_to, chatTypes[type].color.r, chatTypes[type].color.g, chatTypes[type].color.b, format("(%s || %d) << %s", Players[id].getUsername(), id, pm_message));
							} else sendMessageToPlayer(id, 186, 0, 0, "(SERVER) Gracz o ID " + pm_to + " nie jest zalogowany.");
						} else sendMessageToPlayer(id, 186, 0, 0, "(SERVER) Gracz o ID " + pm_to + " nie jest po³¹czony.");
					} else sendMessageToPlayer(id, 186, 0, 0, "(SERVER) Nie mo¿esz wys³aæ wiadomoœci prywatnej do siebie.");
			}
			if(type == "GMSG"){
				for(local i = 0, end = getMaxSlots(); i < end; ++i){
						if(!Players.rawin(i)) break;
						if(!Players[i].isLogged()) continue;

					if(Players[i].getPermissions() >= perm.MODERATOR){
						sendMessageToPlayer(i, chatTypes[type].color.r, chatTypes[type].color.g, chatTypes[type].color.b, message);
					}
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
	if(msgType == "@"){
		sendChatMessage(id, "OOC", params);
	}
	else if(msgType == "#"){
		sendChatMessage(id, "ME", params);
	}
	else if(msgType == "."){
		sendChatMessage(id, "DO", params);
	}
	else if(msgType == ","){
		sendChatMessage(id, "WH", params);
	}
	else if(msgType == "!"){
		sendChatMessage(id, "SH", params);
	}
	else
		sendChatMessage(id, "IC", text);
});

addEventHandler("onPlayerCommand", function(id, cmd, params){
	if(!Players[id].isLogged()) return;

	cmd = cmd.tolower();
	if(cmd == "b"){
		sendChatMessage(id, "OOC", params);
	}
	else if(cmd == "me" || cmd == "ja"){
		sendChatMessage(id, "ME", params);
	}
	else if(cmd == "do"){
		sendChatMessage(id, "DO", params);
	}
	else if(cmd == "sz"){
		sendChatMessage(id, "WH", params);
	}
	else if(cmd == "k"){
		sendChatMessage(id, "SH", params);
	}
	else if(cmd == "pw" || cmd == "pm" || cmd == "msg"){
		sendChatMessage(id, "PM", params);
	}
	else if(cmd == "g"){
		if(checkPermissions(id, perm.LEADER)) sendChatMessage(id, "GOOC", params);
	}
	else if(cmd == "p" || cmd == "gdo"){
		if(checkPermissions(id, perm.MODERATOR)) sendChatMessage(id, "GDO", params);
	}
	else if(cmd == "gmsg"){
		if(checkPermissions(id, perm.MODERATOR)) sendChatMessage(id, "GMSG", params);
	}
});