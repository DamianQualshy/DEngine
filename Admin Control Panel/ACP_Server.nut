regenTimer <- null;

function checkPermissions(pid, level){
	if(Players[pid].getPermissions() < level){
		sendServerMessage(pid, "PANEL", "You don't have required permissions.");
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

local helpCMD = ["panel", "acp", "help", "pomoc"];
local chatCMD = ["null", "b", "ooc", "me", "ja", "do", "sz", "wh", "k", "sh", "g", "p", "post", "gdo", "msg", "dm", "pm", "pw"];
addEventHandler("onPlayerCommand", function(pid, cmd, params){
	if(!Players[pid].isLogged()) return;

	cmd = cmd.tolower();

	if(!Commands.rawin(cmd) && !helpCMD.find(cmd) && !chatCMD.find(cmd)){
		sendServerMessage(pid, "PANEL", format("Command '%s' doesn't exist.", cmd));
		return;
	}

	if(helpCMD.find(cmd)){
		foreach(key, cmdData in Commands){
			if(Players[pid].getPermissions() >= cmdData.perm)
			sendServerMessage(pid, "PANEL", format("/%s - %s", key, cmdData.use));
		}
	}

	if(Commands.rawin(cmd)){
		if(checkPermissions(pid, Commands[cmd].perm)) Commands[cmd].func(pid, params);
	}
});


PlayerRestStopMessage.bind(function(pid, message){
	killTimer(regenTimer);

	sendServerMessage(pid, "PANEL", "You've decided you don't need to rest.");
	Players[pid].resting = false;

	local restCMD = PlayerRestMessage(pid,
		Players[pid].isResting(),
		"T_STAND_2_JUMPUP"
		).serialize();
	restCMD.send(pid, RELIABLE_ORDERED);
});