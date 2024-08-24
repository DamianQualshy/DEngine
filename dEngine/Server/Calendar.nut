addEvent("onNewYear");
addEvent("onNewMonth");
addEvent("onNewDay");
addEvent("onNewSeason");
addEvent("onWeatherChange");

class Calendar {
	hour = 6;
	minute = 0;
	day = 1;
	month = 1;
	year = 1000;
	season = "Spring";

	function handleTime(_day, _hour, _minute){
		if(_hour != this.hour || _minute != this.minute){
			this.hour = _hour;
			this.minute = (_minute <= 1 ? _minute : _minute - 1);
		}

		if((hour == Sky.getRainStartTime().hour && minute == Sky.getRainStartTime().min) ||
			(hour == Sky.getRainStopTime().hour && minute == Sky.getRainStopTime().min)){
			callEvent("onWeatherChange");
		}

		this.updateTime();
		this.handleSeason();
		this.handleTimeLength();

		local checkTimeClient = CalendarMessage_TimeCheck(
			this.hour,
			this.minute,
			this.day,
			this.month,
			this.year,
			this.season
		).serialize();
		foreach(player in Players){
			checkTimeClient.send(player.id, RELIABLE);
		}
	}

	function handleSeasonChange(){
		local thisSeason = Seasons[this.season];

		Sky.dontRain = thisSeason.dontRain;

		Sky.setRainStartTime(thisSeason.rainStart.hour, thisSeason.rainStart.minute);
		Sky.setRainStopTime(thisSeason.rainEnd.hour, thisSeason.rainEnd.minute);

		local changeSeasonClient = CalendarMessage_SeasonChange(this.season).serialize();
		foreach(player in Players){
			changeSeasonClient.send(player.id, RELIABLE);
		}
	}

	function updateTime(){
		this.minute += 1;

		if(this.minute >= 60){
			this.minute = 0;
			this.hour += 1;
		}

		if(this.hour >= 24){
			this.hour = 0;
			this.day += 1;

			callEvent("onNewDay");
		}

		if(this.day >= DAYS_IN_MONTH){
			this.day = 1;
			this.month += 1;

			callEvent("onNewMonth");
		}

		if(this.month >= MONTHS_IN_YEAR){
			this.month = 1;
			this.year += 1;

			callEvent("onNewYear");
		}
	}

	function handleSeason(){
		local newSeason;

		foreach(season, data in Seasons){
			if(data.months.find(this.month) != null){
				newSeason = season;
				break;
			}
		}

		if(newSeason != this.season){
			this.season = newSeason;
			this.handleSeasonChange();

			callEvent("onNewSeason");
		}
	}

	function handleTimeLength(){
		local dayLength = (Seasons[this.season].daylength * 1000);
		local nightLength = (Seasons[this.season].nightlength * 1000);

		if(this.hour >= 18 || this.hour < 6){
			if(getDayLength() == nightLength) return;

			setDayLength(nightLength);
		}
		if(this.hour >= 6 && this.hour < 18){
			if(getDayLength() == dayLength) return;

			setDayLength(dayLength);
		}
	}

	function setDate(newDay, newMonth, newYear){
		this.year = newYear;
		this.month = newMonth;
		this.day = newDay;

			this.handleTime(this.day, this.hour, this.minute);
	}

	function initTime(){

	}
}


function Calendar::handleSeasonChangeForPlayer(pid){
	local thisSeason = Seasons[this.season];

	Sky.dontRain = thisSeason.dontRain;

	Sky.setRainStartTime(thisSeason.rainStart.hour, thisSeason.rainStart.minute);
	Sky.setRainStopTime(thisSeason.rainEnd.hour, thisSeason.rainEnd.minute);

	local changeSeasonClient = CalendarMessage_SeasonChange(this.season).serialize();
	changeSeasonClient.send(pid, RELIABLE);
}


addEventHandler("onTime", function(d, m, y){
	Calendar().handleTime(d, m, y);
});

addEventHandler("onPlayerJoin", function(pid){
	Calendar().handleSeasonChangeForPlayer(pid);
});