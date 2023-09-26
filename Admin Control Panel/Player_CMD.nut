function CMD_CHATTYPES(pid, params){
	sendServerMessage(pid, "PANEL", "(@) /b /ooc - Out Of Character");
	sendServerMessage(pid, "PANEL", "(#) /ja /me - Action");
	sendServerMessage(pid, "PANEL", "(.) (-) /do - Surroundings");
	sendServerMessage(pid, "PANEL", "(,) (;) /sz /wh - Whisper");
	sendServerMessage(pid, "PANEL", "(!) /k /sh - Shout");
	sendServerMessage(pid, "PANEL", "/pw /pm /dm - Private Message");
	sendServerMessage(pid, "PANEL", "(:) /g /gooc - OOC Global");
	if(Players[pid].getPermissions() >= perm.LEADER){
		sendServerMessage(pid, "PANEL", "/p /post /gdo - Surroundings Global");
	}
	if(Players[pid].getPermissions() >= perm.MODERATOR){
		sendServerMessage(pid, "PANEL", "/msg - Moderator Chat");
	}
}
registerCommand("chat", CMD_CHATTYPES, "Available Chat commands and prefixes.", perm.PLAYER);

function CMD_AFK(pid, params){
	local state;

	if(Players[pid].isAFK()){
		state = false;
		returnColor(pid, Players[pid].getPermissions());
		sendServerMessage(pid, "PANEL", "You came back.");
	} else {
		state = true;
		Players[pid].setColor(0, 0, 0);
		sendServerMessage(pid, "PANEL", "You went away.");
	}

	local afkCMD = PlayerAFKMessage(pid,
		state
		).serialize();
	afkCMD.send(pid, RELIABLE_ORDERED);
	Players[pid].afk = !Players[pid].isAFK();
}
registerCommand("afk", CMD_AFK, "Change AFK status.", perm.PLAYER);

function CMD_TRY(pid, params){
	local resultColor = {r = 0, g = 0, b = 0};
	local resultMessage = "";

	local coinFlip = rand() % 2;

	if(coinFlip == 0){
		resultColor = {r = 255, g = 0, b = 0};
		resultMessage = "but failed";
	} else {
		resultColor = {r = 0, g = 255, b = 0};
		resultMessage = "and succeded";
	}

	local resultFormat = format("#%s tried to %s, %s.#", Players[pid].getName(), params, resultMessage);

	for(local i = 0, end = getMaxSlots(); i < end; ++i){
		if(!Players.rawin(i)) break;
		if(!Players[i].isLogged()) continue;
		if(Players[i].getWorld() != Players[pid].getWorld()) continue;

		if(getDistanceBetweenPlayers(pid, i) <= 2000){
			sendMessageToPlayer(i, resultColor.r, resultColor.g, resultColor.b, resultFormat);
		} else {
			sendMessageToAdmin(pid, resultColor.r, resultColor.g, resultColor.b, resultFormat);
		}
	}
}
registerCommand("try", CMD_TRY, "Perform a 'Try' action.", perm.PLAYER);

function CMD_DICE(pid, params){
	if(!params){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /dice d4/d6/d8/d10/d12/d20");
		return;
	}

	local result = -1;

	switch(params){
		case "d4":
			result = rand() % 5;
		break;
		case "d6":
			result = rand() % 7;
		break;
		case "d8":
			result = rand() % 9;
		break;
		case "d10":
			result = rand() % 11;
		break;
		case "d12":
			result = rand() % 13;
		break;
		case "d20":
			result = rand() % 21;
		break;
		default:
			sendServerMessage(pid, "PANEL", "Wrong type of dice. Use /dice d4/d6/d8/d10/d12/d20");
		break;
	}

	if(result == -1) return;
	for(local i = 0, end = getMaxSlots(); i < end; ++i){
		if(!Players.rawin(i)) break;
		if(!Players[i].isLogged()) continue;
		if(Players[i].getWorld() != Players[pid].getWorld()) continue;

		if(getDistanceBetweenPlayers(pid, i) <= 2000){
			sendMessageToPlayer(i, 0, 0, 0, format("#%s threw a %s dice, with result %d#", Players[pid].getName(), params, result));
		} else {
			sendMessageToAdmin(pid, 0, 0, 0, format("#%s threw a %s dice, with result %d#", Players[pid].getName(), params, result));
		}
	}
}
registerCommand("dice", CMD_DICE, "Throw a dice.", perm.PLAYER);

function CMD_REST(pid, params){
	local curr_hp = Players[pid].getHealth();
	local max_hp = Players[pid].getMaxHealth();
	local curr_mp = Players[pid].getMana();
	local max_mp = Players[pid].getMaxMana();
	local curr_stm = Players[pid].getStamina();
	local max_stm = 100;

	if(curr_mp > max_mp * 0.8 && curr_hp > max_hp * 0.8){
		sendServerMessage(pid, "PANEL", "You don't need to rest.");
	} else {
		local hpRegen = 0;
		local mpRegen = 0;
		local regenAni = "";
		local standAni = "";
		Players[pid].resting = true;

		if (curr_stm > max_stm * 0.8) {
			hpRegen = max_hp * 0.1;
			mpRegen = max_mp * 0.05;
			regenAni = "T_STAND_2_SIT";
			//regenAni = "S_CASUALSIT";
			standAni = "T_SIT_2_STAND";
		} else if (curr_stm > max_stm * 0.5) {
			hpRegen = max_hp * 0.05;
			mpRegen = max_mp * 0.02;
			regenAni = "T_STAND_2_SIT";
			//regenAni = "S_TIREDSIT";
			standAni = "T_SIT_2_STAND";
		} else if (curr_stm > max_stm * 0.25) {
			hpRegen = max_hp * 0.02;
			mpRegen = max_mp * 0.01;
			regenAni = "T_STAND_2_SIT";
			//regenAni = "S_DEPRESSIONSIT";
			standAni = "T_SIT_2_STAND";
		} else {
			hpRegen = max_hp * 0.01;
			regenAni = "T_STAND_2_SLEEPGROUND";
			standAni = "T_SLEEPGROUND_2_STAND";
		}

		local restCMD = PlayerRestMessage(pid,
			Players[pid].isResting(),
			regenAni
			).serialize();
		restCMD.send(pid, RELIABLE_ORDERED);

		regenTimer = setTimer(function(){
			curr_hp = ceil(curr_hp + hpRegen).tointeger();
			curr_mp = ceil(curr_mp + mpRegen).tointeger();
			if(curr_hp < max_hp || curr_mp < max_mp){
				if(curr_hp < max_hp){
					Players[pid].setHealth(curr_hp);
					sendServerMessage(pid, "PANEL", format("Regenerated %d health out of %d.", curr_hp, max_hp));
				}
				if(curr_mp < max_mp){
					Players[pid].setMana(curr_mp);
					sendServerMessage(pid, "PANEL", format("Regenerated %d mana out of %d.", curr_mp, max_mp));
				}
			}
			if(curr_hp >= max_hp * 0.9 && curr_mp >= max_mp * 0.9) {
					sendServerMessage(pid, "PANEL", "You have rested enough.");
					Players[pid].resting = false;
				if(rand() % 100 <= 20 && curr_stm < 97){
					local stmRegen = rand() % 3 + 1;
					curr_stm = floor(curr_stm + stmRegen);
						Players[pid].setStamina(curr_stm);
						sendServerMessage(pid, "PANEL", format("You've also regained %d Stamina!", stmRegen));
				}
					local restCMD = PlayerRestMessage(pid,
						Players[pid].isResting(),
						standAni
						).serialize();
					restCMD.send(pid, RELIABLE_ORDERED);
				killTimer(regenTimer);
			}
		}, 2000, 0);
	}
}
registerCommand("rest", CMD_REST, "Regenerate your Health and Mana.", perm.PLAYER);