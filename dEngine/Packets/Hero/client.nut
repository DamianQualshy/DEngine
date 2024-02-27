HeroStatsMessage_Level.bind(function(message){
	setPlayerLevel(message.heroID, message.level);
	setNextLevelExp(250 * message.level * (message.level + 1))
});

HeroStatsMessage_EXP.bind(function(message){
	setExp(message.exp);
});

HeroStatsMessage_LP.bind(function(message){
	setLearnPoints(message.learnPoints);
});

HeroStatsMessage_Guild.bind(function(message){
	setPlayerGuild(message.heroID, message.guildId);
});