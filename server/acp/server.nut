function checkPermissions(pid, level){
	if(Players[pid].getPermissions() < level){
		sendChatMessage(pid, "PANEL", "Nie posiadasz wystarczaj�cych uprawnie�.");
		return false;
	} else
	return true;
}

local rankColors = [
	{r = 255, g = 255, b = 255},
	{r = 0, g = 50, b = 100},
	{r = 50, g = 100, b = 0},
	{r = 100, g = 0, b = 0}
];
function returnColor(pid, level){
	Players[pid].setColor(rankColors[level].r, rankColors[level].g, rankColors[level].b);
}

local Commands = {};
function registerCommand(cmd, func, use, perm){
	Commands[cmd] <- {func = func, use = use, perm = perm};
}

local helpPanel = ["panel", "acp", "help", "pomoc"];
addEventHandler("onPlayerCommand", function(pid, cmd, params){
	if(!Players[pid].isLogged()) return;

	cmd = cmd.tolower();
	if(!Commands.rawin(cmd) && !helpPanel.find(cmd)){
		sendChatMessage(pid, "PANEL", format("Komenda '%s' nie istnieje.", cmd));
		return;
	}

	if(helpPanel.find(cmd)){
		foreach(key, cmdData in Commands){
			if(Players[pid].getPermissions() >= cmdData.perm)
			sendChatMessage(pid, "PANEL", format("/%s - %s", key, cmdData.use));
		}
	}

	if(Commands.rawin(cmd)){
		if(checkPermissions(pid, Commands[cmd].perm)) Commands[cmd].func(pid, params);
	}
});

function CMD_AFK(pid, params){
	if(!Players[pid].isAFK()){
		//send client packets

		returnColor(pid, Players[pid].getPermissions());
		sendChatMessage(pid, "PANEL", "Wr�ci�e� do gry.");
	} else {
		//send client packets

		Players[pid].setColor(0, 0, 0);
		sendChatMessage(pid, "PANEL", "Odszed�e� od gry.");
	}

	Players[pid].afk = !Players[pid].isAFK();
}
registerCommand("afk", CMD_AFK, "Zmie� status AFK.", perm.PLAYER);

function CMD_COLOR(pid, params){
	local args = sscanf("dddd", params);
	if(!args){
		sendChatMessage(pid, "PANEL", "B��dne parametry komendy. U�yj /color id r g b");
		return;
	}

	local id = args[0];
	local r = args[1];
	local g = args[2];
	local b = args[3];

	if(!isPlayerConnected(id)) sendChatMessage(pid, "PANEL", format("Gracz o ID %d nie jest po��czony z serwerem.", id));
	if(!Players[id].isLogged()) sendChatMessage(pid, "PANEL", format("Gracz o ID %d nie jest zalogowany.", id));

	if(r > 255 || g > 255 || b > 255) sendChatMessage(pid, "PANEL", "Maksymalna warto�� to 255.");
	if(r < 0 || g < 0 || b < 0) sendChatMessage(pid, "PANEL", "Minimalna warto�� to 0.");

	Players[id].setColor(r, g, b);
	sendChatMessage(id, "PANEL", format("Moderator %s zmieni� ci kolor na (%d %d %d).", Players[pid].getUsername(), r, g, b));
}
registerCommand("color", CMD_COLOR, "Zmie� kolor gracza.", perm.MODERATOR);

function CMD_NAME(pid, params){
	local args = sscanf("ds", params);
	if(!args){
		sendChatMessage(pid, "PANEL", "B��dne parametry komendy. U�yj /name id nick");
		return;
	}

	local id = args[0];
	local name = args[1];

	if(!isPlayerConnected(id)) sendChatMessage(pid, "PANEL", format("Gracz o ID %d nie jest po��czony z serwerem.", id));
	if(!Players[id].isLogged()) sendChatMessage(pid, "PANEL", format("Gracz o ID %d nie jest zalogowany.", id));

	Players[id].setName(name);
	sendChatMessage(id, "PANEL", format("Moderator %s zmieni� ci imi�, na %s.", Players[pid].getUsername(), name));
}
registerCommand("name", CMD_NAME, "Zmie� imi� gracza.", perm.MODERATOR);

function CMD_TP(pid, params){
	local args = sscanf("dd", params);
	if(!args){
		sendChatMessage(pid, "PANEL", "B��dne parametry komendy. U�yj /tp id id_to");
		return;
	}

	local id = args[0];
	local id_to = args[1];

	if(!isPlayerConnected(id) || !isPlayerConnected(id_to)) sendChatMessage(pid, "PANEL", "Jeden z graczy nie jest po��czony z serwerem.");
	if(!Players[id].isLogged() || !Players[id_to].isLogged()) sendChatMessage(pid, "PANEL","Jeden z graczy nie jest zalogowany.");

	if(id == id_to) sendChatMessage(pid, "PANEL","Nie mo�esz teleportowa� tego samego gracza.");

	local pos = Players[id_to].getPosition();
	local world = Players[id_to].getWorld();

	if(Players[id].getWorld() != Players[id_to].getWorld()) Players[id].setWorld(world);
		Players[id].setPosition(pos.x, pos.y, pos.z, pos.a);
		sendChatMessage(id, "PANEL", format("Moderator %s przeni�s� ci� do Gracza %s.", Players[pid].getUsername(), Players[id_to].getUsername()));
}
registerCommand("tp", CMD_TP, "Teleportuj gracza.", perm.MODERATOR);

function CMD_TPALL(pid, params){
	local args = sscanf("d", params);
	if(!args){
		sendChatMessage(pid, "PANEL", "B��dne parametry komendy. U�yj /tpall id");
		return;
	}

	local id = args[0];

	if(!isPlayerConnected(id)) sendChatMessage(pid, "PANEL", format("Gracz o ID %d nie jest po��czony z serwerem.", id));
	if(!Players[id].isLogged()) sendChatMessage(pid, "PANEL", format("Gracz o ID %d nie jest zalogowany.", id));

	local pos = Players[id].getPosition();
	local world = Players[id].getWorld();
	foreach(ppid in Players){
		if(!Players[ppid].isLogged()) continue;

		if(Players[ppid].getWorld() != Players[id].getWorld()) Players[ppid].setWorld(world);
			Players[ppid].setPosition(pos.x, pos.y, pos.z, pos.a);

			sendChatMessage(ppid, "PANEL", format("Moderator %s przeni�s� ci� do Gracza %s.", Players[pid].getUsername(), Players[id].getUsername()));
	}
}
registerCommand("tpall", CMD_TPALL, "Teleportuj wszystkich graczy.", perm.MODERATOR);

function CMD_WORLD(pid, params){
	local args = sscanf("d", params);
	if(!args){
		sendChatMessage(pid, "PANEL", "B��dne parametry komendy. U�yj /world id");
		return;
	}

	local id = args[0];

	if(id > worlds.len()) sendChatMessage(pid, "PANEL", format("Makysymalna warto�� to %d.", worlds.len()-1));

	local world = worlds[id];
	local pos = world.pos;

	if(Players[pid].getWorld() != world.path) Players[pid].setWorld(world.path);
		Players[pid].setPosition(pos.x, pos.y, pos.z, pos.a);
		sendChatMessage(pid, "PANEL", format("Przenios�e� si� do %s.", world.name));
}
registerCommand("world", CMD_WORLD, "Przenie� si� do innego �wiata.", perm.MODERATOR);

function CMD_WORLDLIST(pid, params){
	foreach(wrld in worlds){
		sendChatMessage(pid, "PANEL", format("%d - %s", wrld, wrld.name));
	}
}
registerCommand("worlds", CMD_WORLDLIST, "Poka� list� dost�pnych �wiat�w.", perm.MODERATOR);

function CMD_LOCATION(pid, params){
	local args = sscanf("d", params);
	if(!args){
		sendChatMessage(pid, "PANEL", "B��dne parametry komendy. U�yj /location id");
		return;
	}

	local id = args[0];

	if(id > locations.len()) sendChatMessage(pid, "PANEL", format("Makysymalna warto�� to %d.", locations.len()-1));

	local location = locations[id];
	local pos = location.pos;

	if(Players[pid].getWorld() != location.path) Players[pid].setWorld(location.path);
		Players[pid].setPosition(pos.x, pos.y, pos.z, pos.a);
		sendChatMessage(pid, "PANEL", format("Przenios�e� si� do %s.", location.name));
}
registerCommand("location", CMD_LOCATION, "Teleportuj si� do wybranej lokacji.", perm.MODERATOR);

function CMD_LOCATIONLIST(pid, params){
	foreach(loc in locations){
		sendChatMessage(pid, "PANEL", format("%d - %s", loc, loc.name));
	}
}
registerCommand("locations", CMD_LOCATIONLIST, "Poka� list� dost�pnych lokacji.", perm.MODERATOR);

function CMD_INSTANCE(pid, params){
	local args = sscanf("ds", params);
	if(!args){
		sendChatMessage(pid, "PANEL", "B��dne parametry komendy. U�yj /instance id instance");
		return;
	}

	local id = args[0];
	local instance = args[1];

	if(!isPlayerConnected(id)) sendChatMessage(pid, "PANEL", format("Gracz o ID %d nie jest po��czony z serwerem.", id));
	if(!Players[id].isLogged()) sendChatMessage(pid, "PANEL", format("Gracz o ID %d nie jest zalogowany.", id));

	if(instances.find(instance)){
		Players[id].setInstance(instance);
		sendChatMessage(id, "PANEL", format("Moderator %s zmieni� ci instancj� na %s.", Players[pid].getUsername(), instance));
	} else sendChatMessage(pid, "PANEL", format("Instancja o nazwie %s nie jest dozwolona.", instance));
}
registerCommand("instance", CMD_INSTANCE, "Zmie� instancj� postaci.", perm.MODERATOR);

function CMD_SCALE(pid, params){
	local args = sscanf("dddd", params);
	if(!args){
		sendChatMessage(pid, "PANEL", "B��dne parametry komendy. U�yj /scale id x y z");
		return;
	}

	local id = args[0];
	local x = args[1].tofloat();
	local y = args[2].tofloat();
	local z = args[3].tofloat();
	local fat = Players[id].getScale().f;

	if(!isPlayerConnected(id)) sendChatMessage(pid, "PANEL", format("Gracz o ID %d nie jest po��czony z serwerem.", id));
	if(!Players[id].isLogged()) sendChatMessage(pid, "PANEL", format("Gracz o ID %d nie jest zalogowany.", id));

	if(x > 20 || y > 20 || z > 20) sendChatMessage(pid, "PANEL", "Maksymalna warto�� to 20.");
	if(x < 0 || y < 0 || z < 0) sendChatMessage(pid, "PANEL", "Minimalna warto�� to 0.");

	Players[id].setScale(x, y, z, fat);
	sendChatMessage(id, "PANEL", format("Moderator %s zmieni� ci skal�, na (%f %f %f).", Players[pid].getUsername(), x, y, z));
}
registerCommand("scale", CMD_SCALE, "Zmie� skal� postaci.", perm.MODERATOR);

function CMD_POS(pid, params){
	local args = sscanf("s", params);
	if(!args){
		sendChatMessage(pid, "PANEL", "B��dne parametry komendy. U�yj /pos nazwa");
		return;
	}

	local name = args[0];
	local pos = Players[pid].getPosition();

	sendChatMessage(pid, "PANEL", format("Pozycja (%s: x:%f y:%f z:%f a:%f) zosta�a utworzona.", name, pos.x, pos.y, pos.z, pos.a));
	print(format("Pozycja %s: x:%f y:%f z:%f a:%f", name, pos.x, pos.y, pos.z, pos.a))

	local myfile = io.file("pos.txt", "a+");
	if(myfile.isOpen){
		myfile.write(format("%s: {x = %f, y = %f, z = %f, a = %f}", name, pos.x, pos.y, pos.z, pos.a));
		myfile.close();
	} else print(myfile.errorMsg);
}
registerCommand("pos", CMD_POS, "Zapisz pozycj�.", perm.MODERATOR);

function CMD_HEAL(pid, params){
	local args = sscanf("d", params);
	if(!args){
		sendChatMessage(pid, "PANEL", "B��dne parametry komendy. U�yj /heal id");
		return;
	}

	local id = args[0];
	local hp = Players[id].getHealth();
	local mhp = Players[id].getMaxHealth();
	local mp = Players[id].getMana();
	local mmp = Players[id].getMaxMana();

	if(!isPlayerConnected(id)) sendChatMessage(pid, "PANEL", format("Gracz o ID %d nie jest po��czony z serwerem.", id));
	if(!Players[id].isLogged()) sendChatMessage(pid, "PANEL", format("Gracz o ID %d nie jest zalogowany.", id));

	if(hp == mhp && mp == mmp) sendChatMessage(pid, "PANEL", format("Gracz o ID %d nie wymaga leczenia.", id));

	Players[id].setHealth(mhp);
	Players[id].setMana(mmp);
	sendChatMessage(id, "PANEL", format("Moderator %s uleczy� ci�.", Players[pid].getUsername()));
}
registerCommand("heal", CMD_HEAL, "Ulecz gracza.", perm.MODERATOR);

function CMD_STATS(pid, params){

}
registerCommand("stats", CMD_STATS, "Zmie� statystyki gracza.", perm.MODERATOR);

function CMD_KILL(pid, params){
	local args = sscanf("d", params);
	if(!args){
		sendChatMessage(pid, "PANEL", "B��dne parametry komendy. U�yj /kill id");
		return;
	}

	local id = args[0];

	if(!isPlayerConnected(id)) sendChatMessage(pid, "PANEL", format("Gracz o ID %d nie jest po��czony z serwerem.", id));
	if(!Players[id].isLogged()) sendChatMessage(pid, "PANEL", format("Gracz o ID %d nie jest zalogowany.", id));

	Players[id].setHealth(0);
	sendChatMessage(id, "PANEL", format("Moderator %s zabi� ci�.", Players[pid].getUsername()));
}
registerCommand("kill", CMD_KILL, "Zabij gracza.", perm.MODERATOR);

function CMD_TIME(pid, params){
	local args = sscanf("dd", params);
	if(!args){
		sendChatMessage(pid, "PANEL", "B��dne parametry komendy. U�yj /time hour minute");
		return;
	}

	local hour = args[0];
	local minute = args[1];
	local time = Calendar.getTime();

	if(hour > 23 || minute > 59) sendChatMessage(pid, "PANEL", "Maksymalna warto�� to 23:59.");
	if(hour < 0 || minute < 0) sendChatMessage(pid, "PANEL", "Minimalna warto�� to 00:00.");

	Calendar.updateTime(minute, hour, time.day, time.month, time.year);
	sendChatMessage(pid, "SERVER", format("Czas zosta� zmieniony na %02d:%02d.", hour, minute));
}
registerCommand("time", CMD_TIME, "Zmie� godzin� gry.", perm.MODERATOR);

function CMD_DATE(pid, params){
	local args = sscanf("ddd", params);
	if(!args){
		sendChatMessage(pid, "PANEL", "B��dne parametry komendy. U�yj /date day month year");
		return;
	}

	local day = args[0];
	local month = args[1];
	local year = args[2];
	local time = Calendar.getTime();

	Calendar.updateTime(time.minute, time.hour, day, month, year);
	sendChatMessage(pid, "SERVER", format("Czas zosta� zmieniony na %02d/%02d/%04d.", day, month, year));
}
registerCommand("date", CMD_TIME, "Zmie� dat� gry.", perm.MODERATOR);

function CMD_KICK(pid, params){
	local args = sscanf("ds", params);
	if(!args){
		sendChatMessage(pid, "PANEL", "B��dne parametry komendy. U�yj /kick id reason");
		return;
	}

	local id = args[0];
	local reason = args[1];

	if(!isPlayerConnected(id)) sendChatMessage(pid, "PANEL", format("Gracz o ID %d nie jest po��czony z serwerem.", id));
	if(!Players[id].isLogged()) sendChatMessage(pid, "PANEL", format("Gracz o ID %d nie jest zalogowany.", id));

	sendChatMessage(pid, "SERVER", format("Gracz %s zosta� wyrzucony z serwera, za %s.", Players[id].getUsername(), reason));
	Players[id].kick(reason);
}
registerCommand("kick", CMD_KICK, "Wyrzu� gracza z serwera.", perm.MODERATOR);

function CMD_BAN(pid, params){
	local args = sscanf("dds", params);
	if(!args){
		sendChatMessage(pid, "PANEL", "B��dne parametry komendy. U�yj /ban id time reason");
		return;
	}

	local id = args[0];
	local duration = args[1];
	local reason = args[2];

	if(!isPlayerConnected(id)) sendChatMessage(pid, "PANEL", format("Gracz o ID %d nie jest po��czony z serwerem.", id));
	if(!Players[id].isLogged()) sendChatMessage(pid, "PANEL", format("Gracz o ID %d nie jest zalogowany.", id));

	sendChatMessage(pid, "SERVER", format("Gracz %s zosta� zbanowany, za %s, na %d minut.", Players[id].getUsername(), reason, duration));
	Players[id].ban(duration, reason);
}
registerCommand("ban", CMD_BAN, "Zbanuj gracza.", perm.MODERATOR);

function CMD_JAIL(pid, params){
	local args = sscanf("dds", params);
	if(!args){
		sendChatMessage(pid, "PANEL", "B��dne parametry komendy. U�yj /jail id time reason");
		return;
	}

	local id = args[0];
	local duration = args[1];
	local reason = args[2];

	if(!isPlayerConnected(id)) sendChatMessage(pid, "PANEL", format("Gracz o ID %d nie jest po��czony z serwerem.", id));
	if(!Players[id].isLogged()) sendChatMessage(pid, "PANEL", format("Gracz o ID %d nie jest zalogowany.", id));

	sendChatMessage(pid, "SERVER", format("Gracz %s zosta� wrzucony do wi�zienia, za %s, na %d minut.", Players[id].getUsername(), reason, duration));
	Players[id].jail(duration, reason);
}
registerCommand("jail", CMD_JAIL, "Zatrzymaj tymczasowo gracza.", perm.MODERATOR);