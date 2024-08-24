CalendarMessage_SeasonChange.bind(function(message){
	Sky.weather = Seasons[message.season].weather;
	Sky.windScale = Seasons[message.season].windScale;

	Sky.darkSky = Seasons[message.season].darkSky;

		local fogColor = Seasons[message.season].fogColor;
			local fogDay = fogColor[TIME_DAY];
			local fogEvening = fogColor[TIME_EVENING];
			local fogNight = fogColor[TIME_NIGHT];
			local fogDawn = fogColor[TIME_DAWN];
	Sky.setFogColor(TIME_DAY, fogDay.r, fogDay.g, fogDay.b);
	Sky.setFogColor(TIME_EVENING, fogEvening.r, fogEvening.g, fogEvening.b);
	Sky.setFogColor(TIME_NIGHT, fogNight.r, fogNight.g, fogNight.b);
	Sky.setFogColor(TIME_DAWN, fogDawn.r, fogDawn.g, fogDawn.b);

		local cloudsColor = Seasons[message.season].cloudsColor;
	Sky.setCloudsColor(cloudsColor.r, cloudsColor.g, cloudsColor.b);

		local sunColor = Seasons[message.season].sunColor;
	Sky.setPlanetSize(PLANET_SUN, Seasons[message.season].sunSize);
	Sky.setPlanetColor(PLANET_SUN, sunColor.r, sunColor.g, sunColor.b, sunColor.a);
	Sky.setPlanetTxt(PLANET_SUN, Seasons[message.season].sunTexture);

		local moonColor = Seasons[message.season].moonColor;
	Sky.setPlanetSize(PLANET_MOON, Seasons[message.season].moonSize);
	Sky.setPlanetColor(PLANET_MOON, moonColor.r, moonColor.g, moonColor.b, moonColor.a);
	Sky.setPlanetTxt(PLANET_MOON, Seasons[message.season].moonTexture);

	/* 	local skyLighting = Seasons[message.season].skyLighting;
	Sky.setLightingColor(skyLighting.r, skyLighting.g, skyLighting.b); */
});

local timedraw = GUI.Draw({
	position = {x = 1000, y = 4500},
	text = "hour:minute day/month/year season",
	font = "FONT_DEFAULT.TGA"
});
timedraw.setVisible(true);

CalendarMessage_TimeCheck.bind(function(message){
	timedraw.setText(format("%02d:%02d %02d/%02d/%04d (%s)", message.hour, message.minute, message.day, message.month, message.year, message.season));
})