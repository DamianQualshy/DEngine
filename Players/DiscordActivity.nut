local discord = Discord.activity;

addEventHandler("onInit", function(){
	discord.details = "Immersive Khorinis";
	discord.state = "Connecting..."
	discord.assets.largeImage = "https://i.imgur.com/Vn3X6uF.png";
	discord.update();
});

function updateDiscordState(stringFormat){
	discord.state = stringFormat;
	discord.update();
}

addEventHandler("onEnterZone", function(area){
	if(!area.isChunk) return;
	if(!isRemoteNpc(heroId)) updateDiscordState(format("%s (%s)", getPlayerName(heroId), area.name));
});

addEventHandler("onExitZone", function(area){
	if(!area.isChunk) return;
	if(!isRemoteNpc(heroId)) updateDiscordState(format("%s (%s)", getPlayerName(heroId), "Wilderness"));
});

addEventHandler("onPlayerSpawn", function(heroId){
	if(!isRemoteNpc(heroId)) updateDiscordState(format("%s (%s)", getPlayerName(heroId), "Wilderness"));
});

PlayerLoginSuccessMessage.bind(function(message){
	updateDiscordState(format("%s (%s)", getPlayerName(heroId), "Wilderness"));
});