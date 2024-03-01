HeroHeightMessage.bind(function(pid, message){
	local height = message.height;
	setPlayerScale(pid, height, height, height);
});

HeroCreatorMessage.bind(function(pid, message){
	Player(pid, {
		name = getPlayerName(pid),

		instance = getPlayerInstance(pid),
		guild = 1,

		level = 1,

		visual = [message.visBodyM, message.visBodyT, message.visHeadM, message.visHeadT],
		walk = message.walk,
		height = message.height,
		fatness = message.fatness
	});

	Players[pid].logged = true;
});