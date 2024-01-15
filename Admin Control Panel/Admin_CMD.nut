function CMD_STATSADD(pid, params){
	local args = sscanf("dsd", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /stats_add id type amount")
		return;
	}

	local id = args[0];
		if(!Players.rawin(id)) {
			sendServerMessage(pid, "PANEL", format("Player of ID %d does not exist.", id));
			return;
		}
	local stat = args[1];
	local stat_name = "";
	local amount = args[2];
	local amount_new = -1;

	if(isNpc(id)) {
		sendServerMessage(pid, "PANEL", "You can't change the stats of an NPC.");
		return;
	}

	if(!isPlayerConnected(id)) sendServerMessage(pid, "PANEL", format("Player of ID %d is not connected to the server.", id));
	if(!Players[id].isLogged()) sendServerMessage(pid, "PANEL", format("Player of ID %d is not logged in.", id));

	switch(stat){
		case "str":
			stat_name = "Strength";
			amount_new = Players[id].getStrength() + amount;
			Players[id].setStrength(amount_new);
		break;
		case "dex":
			stat_name = "Dexterity";
			amount_new = Players[id].getDexterity() + amount;
			Players[id].setDexterity(amount_new);
		break;
		case "mp":
			stat_name = "Max Mana";
			amount_new = Players[id].getMaxMana() + amount;
			Players[id].setMaxMana(amount_new);
			Players[id].setMana(amount_new);
		break;
		case "hp":
			stat_name = "Max Health";
			amount_new = Players[id].getMaxHealth() + amount;
			Players[id].setMaxHealth(amount_new);
			Players[id].setHealth(amount_new);
		break;
		case "oneh":
			stat_name = "One-Hand Skill";
			amount_new = Players[id].getOneHandSkill() + amount;
			Players[id].setOneHandSkill(amount_new);
		break;
		case "twoh":
			stat_name = "Two-Hand Skill";
			amount_new = Players[id].getTwoHandSkill() + amount;
			Players[id].setTwoHandSkill(amount_new);
		break;
		case "bow":
			stat_name = "Bow Skill";
			amount_new = Players[id].getBowSkill() + amount;
			Players[id].setBowSkill(amount_new);
		break;
		case "cbow":
			stat_name = "Crossbow Skill";
			amount_new = Players[id].getCrossbowSkill() + amount;
			Players[id].setCrossbowSkill(amount_new);
		break;
		case "mine":
			stat_name = "Mining Skill";
			amount_new = Players[id].getMiningSkill() + amount;
			Players[id].setMiningSkill(amount_new);
		break;
		case "herb":
			stat_name = "Herbalism Skill";
			amount_new = Players[id].getHerbalismSkill() + amount;
			Players[id].setHerbalismSkill(amount_new);
		break;
		case "hunt":
			stat_name = "Hunting Skill";
			amount_new = Players[id].getHuntingSkill() + amount;
			Players[id].setHuntingSkill(amount_new);
		break;
		case "exp":
			stat_name = "Experience";
			amount_new = Players[id].getExperience() + amount;
			Players[id].setExperience(amount_new);
		break;
	}

	if(!stat){
		sendServerMessage(pid, "PANEL", "Wrong stat type.");
		return;
	}
	sendServerMessage(id, "PANEL", format("Administrator %s changed your %s to %d.", Players[pid].getName(), stat_name, amount_new));
}
registerCommand("stats_add", CMD_STATSADD, "Add or Subtract player stats.", perm.ADMIN);

function CMD_STATS(pid, params){
	local args = sscanf("dsd", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /stats id type amount")
		return;
	}

	local id = args[0];
		if(!Players.rawin(id)) {
			sendServerMessage(pid, "PANEL", format("Player of ID %d does not exist.", id));
			return;
		}
	local stat = args[1];
	local stat_name = "";
	local amount_new = args[2];

	if(isNpc(id)) {
		sendServerMessage(pid, "PANEL", "You can't change the stats of an NPC.");
		return;
	}

	if(!isPlayerConnected(id)) sendServerMessage(pid, "PANEL", format("Player of ID %d is not connected to the server.", id));
	if(!Players[id].isLogged()) sendServerMessage(pid, "PANEL", format("Player of ID %d is not logged in.", id));

	switch(stat){
		case "str":
			stat_name = "Strength";
			Players[id].setStrength(amount_new);
		break;
		case "dex":
			stat_name = "Dexterity";
			Players[id].setDexterity(amount_new);
		break;
		case "mp":
			stat_name = "Max Mana";
			Players[id].setMaxMana(amount_new);
			Players[id].setMana(amount_new);
		break;
		case "hp":
			stat_name = "Max Health";
			Players[id].setMaxHealth(amount_new);
			Players[id].setHealth(amount_new);
		break;
		case "oneh":
			stat_name = "One-Hand Skill";
			Players[id].setOneHandSkill(amount_new);
		break;
		case "twoh":
			stat_name = "Two-Hand Skill";
			Players[id].setTwoHandSkill(amount_new);
		break;
		case "bow":
			stat_name = "Bow Skill";
			Players[id].setBowSkill(amount_new);
		break;
		case "cbow":
			stat_name = "Crossbow Skill";
			Players[id].setCrossbowSkill(amount_new);
		break;
		case "mine":
			stat_name = "Mining Skill";
			Players[id].setMiningSkill(amount_new);
		break;
		case "herb":
			stat_name = "Herbalism Skill";
			Players[id].setHerbalismSkill(amount_new);
		break;
		case "hunt":
			stat_name = "Hunting Skill";
			Players[id].setHuntingSkill(amount_new);
		break;
		case "exp":
			stat_name = "Experience";
			Players[id].setExperience(amount_new);
		break;
	}

	if(!stat){
		sendServerMessage(pid, "PANEL", "Wrong stat type.");
		return;
	}
	sendServerMessage(id, "PANEL", format("Administrator %s changed your %s to %d.", Players[pid].getName(), stat_name, amount_new));
}
registerCommand("stats", CMD_STATS, "Change player stats.", perm.ADMIN);

function CMD_WOUND(pid, params){
	local args = sscanf("dsd", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /wound id type amount")
		return;
	}

	local id = args[0];
		if(!Players.rawin(id)) {
			sendServerMessage(pid, "PANEL", format("Player of ID %d does not exist.", id));
			return;
		}
	local stat = args[1];
	local stat_name = "";
	local amount_new = args[2];

	if(isNpc(id)) {
		sendServerMessage(pid, "PANEL", "You can't change the stats of an NPC.");
		return;
	}

	if(!isPlayerConnected(id)) sendServerMessage(pid, "PANEL", format("Player of ID %d is not connected to the server.", id));
	if(!Players[id].isLogged()) sendServerMessage(pid, "PANEL", format("Player of ID %d is not logged in.", id));

	switch(stat){
		case "mp":
			stat_name = "Mana";
			if(amount_new < 1) amount_new = 1;
			Players[id].setMana(amount_new);
		break;
		case "hp":
			stat_name = "Health";
			if(amount_new < 1) amount_new = 1;
			Players[id].setHealth(amount_new);
		break;
		case "stm":
			stat_name = "Stamina";
			if(amount_new < 1) amount_new = 1;
			Players[id].setStamina(amount_new);
		break;
	}

	if(!stat){
		sendServerMessage(pid, "PANEL", "Wrong stat type.");
		return;
	}
	sendServerMessage(id, "PANEL", format("Administrator %s changed your %s to %d.", Players[pid].getName(), stat_name, amount_new));
}
registerCommand("wound", CMD_WOUND, "Hurt player.", perm.ADMIN);

function CMD_DATE(pid, params){
	local args = sscanf("ddd", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /date day month year");
		return;
	}

	local day = args[0];
	local month = args[1];
	local year = args[2];

	Calendar.day = day;
	Calendar.month = month;
	Calendar.year = year;
	sendServerMessage(pid, "SERVER", format("Date was changed to %02d/%02d/%04d.", day, month, year));
}
registerCommand("date", CMD_DATE, "Change server date.", perm.ADMIN);

function CMD_NAME(pid, params){
	local args = sscanf("ds", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /name id new_name");
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

	Players[id].setName(name);
	sendServerMessage(id, "PANEL", format("Administrator %s changed your name to %s.", Players[pid].getName(), name));
}
registerCommand("name", CMD_NAME, "Change player's name permanently.", perm.ADMIN);

function CMD_INSERT(pid, params){
	local args = sscanf("dsd", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /insert id instance amount");
		return;
	}

	local id = args[0];
		if(!Players.rawin(id)) {
			sendServerMessage(pid, "PANEL", format("Player of ID %d does not exist.", id));
			return;
		}
	local inst = args[1].toupper();
	local amount = args[2];

	if(isNpc(id)) {
		sendServerMessage(pid, "PANEL", "You can't give items to an NPC.");
		return;
	}

	if(!isPlayerConnected(id)) sendServerMessage(pid, "PANEL", format("Player of ID %d is not connected to the server.", id));
	if(!Players[id].isLogged()) sendServerMessage(pid, "PANEL", format("Player of ID %d is not logged in.", id));

	if(doesItemExist(inst)){
		Players[id].giveItem(inst, amount);
		sendServerMessage(id, "PANEL", format("Administrator %s gave you %d of %s.", Players[pid].getName(), amount, inst));
	} else {
		sendServerMessage(pid, "PANEL", format("Item of instance %s does not exist in the table.", inst));
	}
}
registerCommand("insert", CMD_INSERT, "Give Player a new item.", perm.ADMIN);

function CMD_GOTO(pid, params){
	local args = sscanf("fff", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /goto x y z");
		return;
	}

	local x = args[0];
	local y = args[1];
	local z = args[2];
	local a = Players[pid].getPosition().a;

	Players[pid].setPosition(x, y, z, a);
	sendServerMessage(pid, "PANEL", format("You teleported to %f %f %f.", x, y, z));
}
registerCommand("goto", CMD_GOTO, "Teleport to specific coordinates.", perm.ADMIN);

function CMD_CREATENPC(pid, params){
	local args = sscanf("ss", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /npc name instance");
		return;
	}

	local pos = Players[pid].getPosition();
	local world = Players[pid].getWorld();

	local npc = {
		Name = args[0],
		Instance = args[1],

		ID = -1,

		class_id = 0,
		level = 5,

		walkstyle = "HUMANS.MDS",
		visual = {bm = "HUM_BODY_NAKED0", bt = 8, hm = "HUM_HEAD_PONY", ht = 18},
		scale = {x = 1.0, y = 1.0, z = 1.0, f = 1.0},

		world = world,
		spawnpos = {x = pos.x, y = pos.y, z = pos.z, a = pos.a},

		virtual_world = virtualworlds.TESTING
	}

	createNPC(npc);
	sendServerMessage(pid, "PANEL", format("You created an NPC %s.", args[0]));
}
registerCommand("npc", CMD_CREATENPC, "Create an NPC template in-game.", perm.ADMIN);