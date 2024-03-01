local discord = Discord.activity;

addEventHandler("onInit", function(){
	discord.details = "dEngine";
	discord.state = "Connecting..."
	discord.assets.largeImage = "https://i.imgur.com/Vn3X6uF.png";
	discord.state = format("%s (%s)", getPlayerName(heroId), "Having a wank");
	discord.update();
});

function updateDiscordState(stringFormat){
	discord.state = stringFormat;
	discord.update();
}