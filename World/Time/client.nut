local timedraw = GUI.Draw({
	position = {x = 1000, y = 4500},
	text = "hour:minute day/week/month/year",
	font = "FONT_DEFAULT.TGA"
});
timedraw.setVisible(true);

local _season;
local old_season;
TimeMessage.bind(function(message){
	local clientTime = getTime();
	_season = message.season;

	if(old_season != _season){
		switch(_season){
			case "Spring":
					setDayLength(LENGTH_OF_DAY);
				Sky.weather = WEATHER_RAIN;
				Sky.setFogColor(0, 82, 109, 198);
				Sky.setFogColor(0, 255, 255, 0);
				Sky.setFogColor(0, 18, 16, 60);
				Sky.setFogColor(0, 134, 104, 125);
				Sky.setCloudsColor(214, 214, 214);
					Sky.renderLightning = false;
					Sky.windScale = 0.02;
				Sky.setRainStartTime(16, 0);
				Sky.setRainStopTime(20, 0);
			break;
			case "Summer":
					setDayLength((LENGTH_OF_DAY * 1.5));
				Sky.dontRain = true;
				Sky.setFogColor(0, 82, 109, 198);
				Sky.setFogColor(1, 255, 255, 0);
				Sky.setFogColor(2, 18, 16, 60);
				Sky.setFogColor(3, 134, 104, 125);
					Sky.windScale = 0.01;
			break;
			case "Autumn":
					setDayLength((LENGTH_OF_DAY * 0.5));
					Sky.dontRain = false;
				Sky.weather = WEATHER_RAIN;
				Sky.setFogColor(0, 116, 89, 75);
				Sky.setFogColor(1, 80, 90, 80);
				Sky.setFogColor(2, 120, 140, 180);
				Sky.setFogColor(3, 120, 140, 180);
				Sky.setCloudsColor(73, 64, 62);
					Sky.renderLightning = true;
					Sky.windScale = 0.05;
				Sky.setRainStartTime(10, 0);
				Sky.setRainStopTime(22, 0);
			break;
			case "Winter":
					setDayLength((LENGTH_OF_DAY / 4.0));
					Sky.dontRain = false;
				Sky.weather = WEATHER_SNOW;
				Sky.setFogColor(0, 185, 245, 255);
				Sky.setFogColor(1, 185, 245, 255);
				Sky.setFogColor(2, 185, 245, 255);
				Sky.setFogColor(3, 185, 245, 255);
				Sky.setCloudsColor(134, 134, 134);
					Sky.renderLightning = false;
					Sky.windScale = 0.01;
				Sky.setRainStartTime(0, 0);
				Sky.setRainStopTime(23, 59);
				Sky.weather = WEATHER_SNOW;
			break;
		}
		old_season = _season;
	}

	timedraw.setText(format("%02d:%02d %02d/%02d/%04d", message.hour, message.minute, message.day, message.month, message.year));
});

addEventHandler("onRender", function(){
	if(Sky.raining){
		switch(_season){
			case "Spring":
				Sky.darkSky = false;
				Sky.weather = WEATHER_RAIN;
			break;
			case "Summer":
				Sky.dontRain = true;
			break;
			case "Autumn":
				Sky.darkSky = true;
			break;
			case "Winter":
				Sky.darkSky = false;
				Sky.weather = WEATHER_SNOW;
			break;
		}
	}
});