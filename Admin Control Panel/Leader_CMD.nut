function CMD_PROMOTE(pid, params){
	local args = sscanf("dd", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /promote id class_id");
		return;
	}

	local id = args[0];
	local class_id = args[1];

	if(!Players[id].isConnected()) sendServerMessage(pid, "PANEL", format("Player of ID %d is not connected to the server.", id));
	if(!Players[id].isLogged()) sendServerMessage(pid, "PANEL", format("Player of ID %d is not logged in.", id));

	if(class_id > classes.len()-1) sendServerMessage(pid, "PANEL", format("Max. allowed class id is %d - %s.", classes.top(), classes[classes.top()].name));

	Players[id].promote(class_id);
	sendServerMessage(id, "PANEL", format("Leader %s changed your class to %s.", Players[pid].getName(), classes[class_id].name));
	sendServerMessage(pid, "PANEL", format("You changed %s class to %s.", Players[id].getName(), classes[class_id].name));
}
registerCommand("promote", CMD_PROMOTE, "Change Player class.", perm.LEADER);

function CMD_GIVEEXP(pid, params){
	local args = sscanf("dd", params);
	if(!args){
		sendServerMessage(pid, "PANEL", "Wrong parameters. Use /exp id amount");
		return;
	}

	local id = args[0];
	local amount = args[1];
	local get_exp = Players[id].getExperience();

	if(!Players[id].isConnected()) sendServerMessage(pid, "PANEL", format("Player of ID %d is not connected to the server.", id));
	if(!Players[id].isLogged()) sendServerMessage(pid, "PANEL", format("Player of ID %d is not logged in.", id));

	if(amount > 500 || amount < -500) sendServerMessage(pid, "PANEL", "Max. allowed experience amount is 500.");

	if(Players[id].hasGainedExperienceToday()){
		sendServerMessage(pid, "PANEL", format("Player %s already gained experience today.", Players[id].getName()));
	} else {
		Players[id].setExperience(get_xp + amount);
		sendServerMessage(id, "PANEL", format("Leader %s gave you %d experience points.", Players[pid].getName(), amount));
		sendServerMessage(pid, "PANEL", format("You gave %s %d experience points.", Players[id].getName(), amount));
		Players[id].gained_exp = true;
	}
}
registerCommand("exp", CMD_GIVEEXP, "Grant Player Experience.", perm.LEADER);