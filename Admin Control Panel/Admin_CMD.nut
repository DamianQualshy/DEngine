function CMD_STATSADD(pid, params){
	local args = sscanf("dsd", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /stats_add id type amount")
		return;
	}

	local id = args[0];
	local stat = args[1];
	local stat_name = "";
	local amount = args[2];
	local amount_new = -1;

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
	local stat = args[1];
	local stat_name = "";
	local amount_new = args[2];

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
	local stat = args[1];
	local stat_name = "";
	local amount_new = args[2];

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
	local time = Calendar.getTime();

	Calendar.updateTime(time.minute, time.hour, day, month, year);
	sendServerMessage(pid, "SERVER", format("Date was changed to %02d/%02d/%04d.", day, month, year));
}
registerCommand("date", CMD_TIME, "Change server date.", perm.ADMIN);

function CMD_NAME(pid, params){
	local args = sscanf("ds", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /name id new_name");
		return;
	}

	local id = args[0];
	local name = args[1];

	if(!isPlayerConnected(id)) sendServerMessage(pid, "PANEL", format("Player of ID %d is not connected to the server.", id));
	if(!Players[id].isLogged()) sendServerMessage(pid, "PANEL", format("Player of ID %d is not logged in.", id));

	Players[id].setName(name);
	sendServerMessage(id, "PANEL", format("Administrator %s changed your name to %s.", Players[pid].getName(), name));
}
registerCommand("name", CMD_NAME, "Change player's name permanently.", perm.ADMIN);

function CMD_INSERT(pid, params){
	local args = sscanf("dsd", params);
	if(!args){
		if(args[1] != null){
			args[2] = 1;
		} else {
			sendServerMessage(pid, "PANEL", "Wrong parameters. Use /insert id instance amount");
			return;
		}
	}

	local id = args[0];
	local inst = args[1];
	local amount = args[2];

	if(!isPlayerConnected(id)) sendServerMessage(pid, "PANEL", format("Player of ID %d is not connected to the server.", id));
	if(!Players[id].isLogged()) sendServerMessage(pid, "PANEL", format("Player of ID %d is not logged in.", id));

	Players[id].giveItem(inst, amount);
	sendServerMessage(id, "PANEL", format("Administrator %s gave you %d of %s.", Players[pid].getName(), amount, inst));
}
registerCommand("insert", CMD_INSERT, "Give Player a new item.", perm.ADMIN);