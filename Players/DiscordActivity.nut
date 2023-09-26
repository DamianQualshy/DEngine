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
	updateDiscordState(format("%s (%s)", getPlayerName(heroId), area.name));
});

addEventHandler("onExitZone", function(area){
	updateDiscordState(format("%s (%s)", getPlayerName(heroId), "Wilderness"));
});

addEventHandler("onPlayerSpawn", function(heroId){
	updateDiscordState(format("%s (%s)", getPlayerName(heroId), "Wilderness"));
});

addEventHandler("onPacket", function(packet){
	local packetId = packet.readUInt8();
	switch(packetId){
		case packets.login_success:
			updateDiscordState(format("%s (%s)", getPlayerName(heroId), "Wilderness"));
		break;
	}
});