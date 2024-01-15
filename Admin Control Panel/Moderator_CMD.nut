function CMD_COLOR(pid, params){
	local args = sscanf("dddd", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /color id r g b");
		return;
	}

	local id = args[0];
		if(!Players.rawin(id)) {
			sendServerMessage(pid, "PANEL", format("Player of ID %d does not exist.", id));
			return;
		}
	local r = args[1];
	local g = args[2];
	local b = args[3];

	if(isNpc(id)) {
		sendServerMessage(pid, "PANEL", "You can't change the color of an NPC.");
		return;
	}

	if(!isPlayerConnected(id)) sendServerMessage(pid, "PANEL", format("Player of ID %d is not connected to the server.", id));
	if(!Players[id].isLogged()) sendServerMessage(pid, "PANEL", format("Player of ID %d is not logged in.", id));

	if(r > 255 || g > 255 || b > 255) sendServerMessage(pid, "PANEL", "Max. allowed value is 255.");
	if(r < 0 || g < 0 || b < 0) sendServerMessage(pid, "PANEL", "Min. allowed value is 0.");

	Players[id].setColor(r, g, b);
	sendServerMessage(id, "PANEL", format("Moderator %s changed your color (%d %d %d).", Players[pid].getName(), r, g, b));
}
registerCommand("color", CMD_COLOR, "Change player name's color using RGB.", perm.MODERATOR);

function CMD_COLORHEX(pid, params){
	local args = sscanf("ds", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /color id hex");
		return;
	}

	local id = args[0];
		if(!Players.rawin(id)) {
			sendServerMessage(pid, "PANEL", format("Player of ID %d does not exist.", id));
			return;
		}
	local hex = args[1];

	if(isNpc(id)) {
		sendServerMessage(pid, "PANEL", "You can't change the color of an NPC.");
		return;
	}

	if(!isPlayerConnected(id)) sendServerMessage(pid, "PANEL", format("Player of ID %d is not connected to the server.", id));
	if(!Players[id].isLogged()) sendServerMessage(pid, "PANEL", format("Player of ID %d is not logged in.", id));

	Players[id].setColorHex(hex);
	sendServerMessage(id, "PANEL", format("Moderator %s changed your color (%s).", Players[pid].getName(), hex));
}
registerCommand("color_hex", CMD_COLORHEX, "Change player name's color using HEX.", perm.MODERATOR);

function CMD_NAMETEMP(pid, params){
	local args = sscanf("ds", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /nick id new_name");
		return;
	}

	local id = args[0];
		if(!Players.rawin(id)) {
			sendServerMessage(pid, "PANEL", format("Player of ID %d does not exist.", id));
			return;
		}
	local name = args[1];

	if(isNpc(id)) {
		sendServerMessage(pid, "PANEL", "You can't change the name of an NPC.");
		return;
	}

	if(!isPlayerConnected(id)) sendServerMessage(pid, "PANEL", format("Player of ID %d is not connected to the server.", id));
	if(!Players[id].isLogged()) sendServerMessage(pid, "PANEL", format("Player of ID %d is not logged in.", id));

	setPlayerName(id, name);
	sendServerMessage(id, "PANEL", format("Moderator %s changed your name to %s.", Players[pid].getName(), name));
}
registerCommand("nick", CMD_NAMETEMP, "Change player's name temporarily.", perm.MODERATOR);

function CMD_TP(pid, params){
	local args = sscanf("dd", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /tp id id_to");
		return;
	}

	local id = args[0];
		if(isNpc(id)){
			sendServerMessage(pid, "PANEL", "You can't teleport an NPC.");
			return;
		}
		if(!Players.rawin(id)) {
			sendServerMessage(pid, "PANEL", format("Player of ID %d does not exist.", id));
			return;
		}
	local id_to = args[1];

	if(isNpc(id_to)) {
		if(!NPCs.rawin(id_to)){ sendServerMessage(pid, "PANEL", format("NPC of ID %d does not exist.", id_to)); return;}

		local pos = NPCs[id_to].getPosition();
		local world = NPCs[id_to].getWorld();

		if(Players[id].getWorld() != NPCs[id_to].getWorld()) Players[id].setWorld(world);
			Players[id].setPosition(pos.x, pos.y, pos.z, pos.a);
			sendServerMessage(id, "PANEL", format("Moderator %s teleported you to NPC %s.", Players[pid].getName(), NPCs[id_to].getName()));
	} else {
		if(!Players.rawin(id_to)){ sendServerMessage(pid, "PANEL", format("Player of ID %d does not exist.", id_to)); return;}

		if(!isPlayerConnected(id) || !isPlayerConnected(id_to)){ sendServerMessage(pid, "PANEL", "One of the Players is not connected to the server."); return;}
		if(!Players[id].isLogged() || !Players[id_to].isLogged()){ sendServerMessage(pid, "PANEL", "One of the Players is not logged in."); return;}
		if(id == id_to){ sendServerMessage(pid, "PANEL", "You can't teleport the same player to himself."); return;}

		local pos = Players[id_to].getPosition();
		local world = Players[id_to].getWorld();

		if(Players[id].getWorld() != Players[id_to].getWorld()) Players[id].setWorld(world);
			Players[id].setPosition(pos.x, pos.y, pos.z, pos.a);
			sendServerMessage(id, "PANEL", format("Moderator %s teleported you to Player %s.", Players[pid].getName(), Players[id_to].getName()));
	}
}
registerCommand("tp", CMD_TP, "Teleport one player to another.", perm.MODERATOR);

function CMD_TPALL(pid, params){
	local args = sscanf("d", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /tpall id");
		return;
	}

	local id = args[0];

	if(isNpc(id)) {
		if(!NPCs.rawin(id)){ sendServerMessage(pid, "PANEL", format("NPC of ID %d does not exist.", id_to)); return;}

		local pos = NPCs[id].getPosition();
		local world = NPCs[id].getWorld();

		foreach(player in Players){
			local ppid = player.id;
			if(!Players[ppid].isLogged()) continue;

			if(Players[ppid].getWorld() != NPCs[id].getWorld()) Players[ppid].setWorld(world);
				Players[ppid].setPosition(pos.x, pos.y, pos.z, pos.a);

				sendServerMessage(ppid, "PANEL", format("Moderator %s teleported you to NPC %s.", Players[pid].getName(), NPCs[id].getName()));
		}
	} else {
		if(!Players.rawin(id)){ sendServerMessage(pid, "PANEL", format("Player of ID %d does not exist.", id_to)); return;}

		if(!isPlayerConnected(id)){ sendServerMessage(pid, "PANEL", format("Player of ID %d is not connected to the server.", id)); return;}
		if(!Players[id].isLogged()){ sendServerMessage(pid, "PANEL", format("Player of ID %d is not logged in.", id)); return;}

		local pos = Players[id].getPosition();
		local world = Players[id].getWorld();
		foreach(player in Players){
			local ppid = player.id;
			if(!Players[ppid].isLogged()) continue;

			if(Players[ppid].getWorld() != Players[id].getWorld()) Players[ppid].setWorld(world);
				Players[ppid].setPosition(pos.x, pos.y, pos.z, pos.a);

				sendServerMessage(ppid, "PANEL", format("Moderator %s teleported you to Player %s.", Players[pid].getName(), Players[id].getName()));
		}
	}
}
registerCommand("tpall", CMD_TPALL, "Teleport all players to another.", perm.MODERATOR);

function CMD_TPHERE(pid, params){
	local args = sscanf("d", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /tphere id");
		return;
	}

	local id = args[0];

	if(isNpc(id)) {
		sendServerMessage(pid, "PANEL", "You can't teleport an NPC.");
		return;
	}

	if(!Players.rawin(id)) sendServerMessage(pid, "PANEL", format("Player of ID %d does not exist.", id_to)); return;

	if(!isPlayerConnected(id) || !isPlayerConnected(id_to)){ sendServerMessage(pid, "PANEL", "One of the Players is not connected to the server."); return;}
	if(!Players[id].isLogged() || !Players[id_to].isLogged()){ sendServerMessage(pid, "PANEL","One of the Players is not logged in."); return;}

	local pos = Players[id].getPosition();
	local world = Players[id].getWorld();

	if(Players[pid].getWorld() != Players[id].getWorld()) Players[id].setWorld(world);
		Players[id].setPosition(pos.x, pos.y, pos.z, pos.a);
		sendServerMessage(id, "PANEL", format("Moderator %s teleported you to himself.", Players[pid].getName()));
}
registerCommand("tphere", CMD_TPHERE, "Teleport one player to yourself.", perm.MODERATOR);

function CMD_VIRTUALWORLD(pid, params){
	local args = sscanf("d", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /virtual id");
		return;
	}

	local id = args[0];

	Players[pid].setVirtualWorld(id);
		sendServerMessage(pid, "PANEL", format("You are now in Virtual World %d.", id));
}
registerCommand("virtual", CMD_VIRTUALWORLD, "Switch virtual world.", perm.MODERATOR);

function CMD_WORLD(pid, params){
	local args = sscanf("d", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /world id");
		return;
	}

	local id = args[0];

	if(id > worlds.len()) {
		sendServerMessage(pid, "PANEL", format("Max. allowed value is %d.", worlds.len() - 1));
		return;
	}

	local world = worlds[id];
	local pos = world.position;

	if(Players[pid].getWorld() != world.path) Players[pid].setWorld(world.path);
		Players[pid].setPosition(pos.x, pos.y, pos.z, pos.a);
		sendServerMessage(pid, "PANEL", format("You switched to %s.", world.name));
}
registerCommand("world", CMD_WORLD, "Teleport to chosen world.", perm.MODERATOR);

function CMD_WORLDLIST(pid, params){
	foreach(id, wrld in worlds){
		sendServerMessage(pid, "PANEL", format("%d - %s", id, wrld.name));
	}
}
registerCommand("worlds", CMD_WORLDLIST, "Show a list of available worlds.", perm.MODERATOR);

function CMD_LOCATION(pid, params){
	local args = sscanf("d", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /location id");
		return;
	}

	local id = args[0];

	if(id > locations.len()) {
		sendServerMessage(pid, "PANEL", format("Max. allowed value is %d.", locations.len() - 1));
		return;
	}

	local location = locations[id];
	local pos = location.position;

	if(Players[pid].getWorld() != location.path) Players[pid].setWorld(location.path);
		Players[pid].setPosition(pos.x, pos.y, pos.z, pos.a);
		sendServerMessage(pid, "PANEL", format("You teleported to %s.", location.name));
}
registerCommand("location", CMD_LOCATION, "Teleport to chosen location.", perm.MODERATOR);

function CMD_LOCATIONLIST(pid, params){
	foreach(id, loc in locations){
		sendServerMessage(pid, "PANEL", format("%d - %s", id, loc.name));
	}
}
registerCommand("locations", CMD_LOCATIONLIST, "Show a list of available locations.", perm.MODERATOR);

function CMD_INSTANCE(pid, params){
	local args = sscanf("ds", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /instance id instance");
		return;
	}

	local id = args[0];
		if(!Players.rawin(id)) {
			sendServerMessage(pid, "PANEL", format("Player of ID %d does not exist.", id));
			return;
		}
	local instance = args[1].toupper();
	local vis = Players[id].getVisual();

	if(isNpc(id)){
		sendServerMessage(pid, "PANEL", "You can't change instance of an NPC.");
		return;
	}

	if(!isPlayerConnected(id)) sendServerMessage(pid, "PANEL", format("Player of ID %d is not connected to the server.", id));
	if(!Players[id].isLogged()) sendServerMessage(pid, "PANEL", format("Player of ID %d is not logged in.", id));

	if(instances.find(instance)){
		Players[id].setInstance(instance);
		if(instance == "PC_HERO"){
			Players[id].setVisual(vis.bm, vis.bt, vis.hm, vis.ht);
		}
		sendServerMessage(id, "PANEL", format("Moderator %s changed your instance to %s.", Players[pid].getName(), instance));
	} else sendServerMessage(pid, "PANEL", format("Instance %s is not allowed or doesn't exist.", instance));
}
registerCommand("instance", CMD_INSTANCE, "Change the instance of a player.", perm.MODERATOR);

function CMD_SCALE(pid, params){
	local args = sscanf("dfff", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /scale id x y z");
		return;
	}

	local id = args[0];
		if(!Players.rawin(id)) {
			sendServerMessage(pid, "PANEL", format("Player of ID %d does not exist.", id));
			return;
		}
	local x = args[1].tofloat();
	local y = args[2].tofloat();
	local z = args[3].tofloat();

	if(isNpc(id)) {
		sendServerMessage(pid, "PANEL", "You can't change the scale of an NPC.");
		return;
	}

	if(!isPlayerConnected(id)) sendServerMessage(pid, "PANEL", format("Player of ID %d is not connected to the server.", id));
	if(!Players[id].isLogged()) sendServerMessage(pid, "PANEL", format("Player of ID %d is not logged in.", id));

	if(x > 20 || y > 20 || z > 20) sendServerMessage(pid, "PANEL", "Max. allowed value is 20.");
	if(x < 0 || y < 0 || z < 0) sendServerMessage(pid, "PANEL", "Min. allowed value is 0.");

	setPlayerScale(id, x, y, z);
	sendServerMessage(id, "PANEL", format("Moderator %s changed your scale (%f %f %f).", Players[pid].getName(), x, y, z));
}
registerCommand("scale", CMD_SCALE, "Change the scale of a player.", perm.MODERATOR);

function CMD_SCALERES(pid, params){
	local args = sscanf("d", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /scale_res id");
		return;
	}

	local id = args[0];
		if(!Players.rawin(id)) {
			sendServerMessage(pid, "PANEL", format("Player of ID %d does not exist.", id));
			return;
		}
	local scale = Players[id].getScale();

	if(isNpc(id)) {
		sendServerMessage(pid, "PANEL", "You can't change the scale of an NPC.");
		return;
	}

	if(!isPlayerConnected(id)) sendServerMessage(pid, "PANEL", format("Player of ID %d is not connected to the server.", id));
	if(!Players[id].isLogged()) sendServerMessage(pid, "PANEL", format("Player of ID %d is not logged in.", id));

	Players[id].setScale(scale.x, scale.y, scale.z, scale.f);
	sendServerMessage(id, "PANEL", format("Moderator %s reset your scale.", Players[pid].getName()));
}
registerCommand("scale_res", CMD_SCALERES, "Reset the scale of a player.", perm.MODERATOR);

function CMD_POS(pid, params){
	local args = sscanf("s", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /pos nazwa");
		return;
	}

	local name = args[0];
	local pos = Players[pid].getPosition();

	sendServerMessage(pid, "PANEL", format("Position (%s: x:%f y:%f z:%f a:%f) was created.", name, pos.x, pos.y, pos.z, pos.a));
	print(format("Position %s: x:%f y:%f z:%f a:%f", name, pos.x, pos.y, pos.z, pos.a))

	local myfile = io.file("database/pos.txt", "a+");
	if(myfile.isOpen){
		myfile.write(format("%s: {x = %f, y = %f, z = %f, a = %f}", name, pos.x, pos.y, pos.z, pos.a) + "\n");
		myfile.close();
	} else print(myfile.errorMsg);
}
registerCommand("pos", CMD_POS, "Save your position.", perm.MODERATOR);

function CMD_HEAL(pid, params){
	local args = sscanf("d", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /heal id");
		return;
	}

	local id = args[0];
		if(!Players.rawin(id)) {
			sendServerMessage(pid, "PANEL", format("Player of ID %d does not exist.", id));
			return;
		}
	local hp = Players[id].getHealth();
	local mhp = Players[id].getMaxHealth();
	local mp = Players[id].getMana();
	local mmp = Players[id].getMaxMana();
	local st = Players[id].getStamina();

	if(isNpc(id)) {
		sendServerMessage(pid, "PANEL", "You can't change the stats of an NPC.");
		return;
	}

	if(!isPlayerConnected(id)) sendServerMessage(pid, "PANEL", format("Player of ID %d is not connected to the server.", id));
	if(!Players[id].isLogged()) sendServerMessage(pid, "PANEL", format("Player of ID %d is not logged in.", id));

	if(hp == mhp && mp == mmp && st == 100) {
		sendServerMessage(pid, "PANEL", format("Player of ID %d doesn't require healing.", id));
	} else {
		Players[id].setHealth(mhp);
		Players[id].setMana(mmp);
		Players[id].setStamina(100);
		sendServerMessage(id, "PANEL", format("Moderator %s healed you.", Players[pid].getName()));
	}
}
registerCommand("heal", CMD_HEAL, "Heal player.", perm.MODERATOR);

function CMD_KILL(pid, params){
	local args = sscanf("d", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /kill id");
		return;
	}

	local id = args[0];
		if(!Players.rawin(id)) {
			sendServerMessage(pid, "PANEL", format("Player of ID %d does not exist.", id));
			return;
		}

	if(isNpc(id)) {
		sendServerMessage(pid, "PANEL", "You can't change the stats of an NPC.");
		return;
	}

	if(!isPlayerConnected(id)) sendServerMessage(pid, "PANEL", format("Player of ID %d is not connected to the server.", id));
	if(!Players[id].isLogged()) sendServerMessage(pid, "PANEL", format("Player of ID %d is not logged in.", id));

	Players[id].setHealth(0);
	sendServerMessage(id, "PANEL", format("Moderator %s killed you.", Players[pid].getName()));
}
registerCommand("kill", CMD_KILL, "Kill player.", perm.MODERATOR);

function CMD_TIME(pid, params){
	local args = sscanf("dd", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /time hour minute");
		return;
	}

	local hour = args[0];
	local minute = args[1];

	if(hour > 23 || minute > 59) sendServerMessage(pid, "PANEL", "Max. allowed value is 23:59.");
	if(hour < 0 || minute < 0) sendServerMessage(pid, "PANEL", "Min. allowed value is 00:00.");

	Calendar.hour = hour;
	Calendar.minute = minute;
		sendServerMessage(pid, "SERVER", format("Time was changed to %02d:%02d.", hour, minute));
}
registerCommand("time", CMD_TIME, "Change server time.", perm.MODERATOR);

function CMD_KICK(pid, params){
	local args = sscanf("ds", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /kick id reason");
		return;
	}

	local id = args[0];
		if(!Players.rawin(id)) {
			sendServerMessage(pid, "PANEL", format("Player of ID %d does not exist.", id));
			return;
		}
	local reason = args[1];

	if(isNpc(id)) {
		sendServerMessage(pid, "PANEL", "You can't kick an NPC.");
		return;
	}

	if(!isPlayerConnected(id)) sendServerMessage(pid, "PANEL", format("Player of ID %d is not connected to the server.", id));
	if(!Players[id].isLogged()) sendServerMessage(pid, "PANEL", format("Player of ID %d is not logged in.", id));

	sendServerMessage(pid, "SERVER", format("Player %s was kicked out, for '%s'.", Players[id].getName(), reason));
	Players[id].kick(reason);
}
registerCommand("kick", CMD_KICK, "Kick player out.", perm.MODERATOR);

function CMD_BAN(pid, params){
	local args = sscanf("dds", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /ban id time reason");
		return;
	}

	local id = args[0];
		if(!Players.rawin(id)) {
			sendServerMessage(pid, "PANEL", format("Player of ID %d does not exist.", id));
			return;
		}
	local duration = args[1];
	local reason = args[2];

	if(isNpc(id)) {
		sendServerMessage(pid, "PANEL", "You can't ban an NPC.");
		return;
	}

	if(!isPlayerConnected(id)) sendServerMessage(pid, "PANEL", format("Player of ID %d is not connected to the server.", id));
	if(!Players[id].isLogged()) sendServerMessage(pid, "PANEL", format("Player of ID %d is not logged in.", id));

	sendServerMessage(pid, "SERVER", format("Player %s was banned, for '%s', for %d minutes.", Players[id].getName(), reason, duration));
	Players[id].ban(duration, reason);
}
registerCommand("ban", CMD_BAN, "Ban player.", perm.MODERATOR);

function CMD_JAIL(pid, params){
	local args = sscanf("dds", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /jail id time reason");
		return;
	}

	local id = args[0];
		if(!Players.rawin(id)) {
			sendServerMessage(pid, "PANEL", format("Player of ID %d does not exist.", id));
			return;
		}
	local duration = args[1];
	local reason = args[2];

	if(isNpc(id)) {
		sendServerMessage(pid, "PANEL", "You can't jail an NPC.");
		return;
	}

	if(!isPlayerConnected(id)) sendServerMessage(pid, "PANEL", format("Player of ID %d is not connected to the server.", id));
	if(!Players[id].isLogged()) sendServerMessage(pid, "PANEL", format("Player of ID %d is not logged in.", id));

	sendServerMessage(pid, "SERVER", format("Player %s was thrown in jail, for '%s', for %d minutes.", Players[id].getName(), reason, duration));
	Players[id].jail(duration, reason);
}
registerCommand("jail", CMD_JAIL, "Temporarily jail a player.", perm.MODERATOR);