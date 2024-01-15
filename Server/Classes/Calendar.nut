class Calendar {
	minute = -1;
	hour = -1;
	day = -1;
	month = -1;
	year = -1;
	currentSeason = -1;
	weekDay = -1;

	constructor() {
		local result = MySQL.query("SELECT * FROM Server_Info");
		local row = MySQL.fetchAssoc(result);
		MySQL.freeResult(result);

			if(row != null){
				local gameTime = row.Game_Time;
				local dateAndTime = split(gameTime, " ");

				local dateComponents = split(dateAndTime[0], "-");
				local timeComponents = split(dateAndTime[1], ":");

				this.year = dateComponents[0].tointeger();
				this.month = dateComponents[1].tointeger();
				this.day = dateComponents[2].tointeger();

				this.hour = timeComponents[0].tointeger();
				this.minute = timeComponents[1].tointeger();
			}

			if(this.minute < 0 || this.hour < 0 || this.day < 1 || this.month < 1 || this.year < 0){
				this.year = 1;
				this.month = 1;
				this.day = 1;

				this.hour = 0;
				this.minute = 0;
			}

		this.currentSeason = this.updateSeason();

		this.weekDay = (this.day % 7) + 1;
	}

	function changeTime(minuteDelta, hourDelta, dayDelta, monthDelta, yearDelta) {
		this.minute += minuteDelta;

		while (this.minute >= 60) {
			this.minute -= 60;
			this.hour += 1;
		}
		while (this.minute < 0) {
			this.minute += 60;
			this.hour -= 1;
		}

		this.hour += hourDelta;

		while (this.hour >= 24) {
			this.hour -= 24;
			this.day += 1;
		}
		while (this.hour < 0) {
			this.hour += 24;
			this.day -= 1;
		}

		this.day += dayDelta;

		while (this.day >= 31) {
			this.day -= 30;
			this.month += 1;
		}
		while (this.day < 0) {
			this.day += 30;
			this.month -= 1;
		}

		this.month += monthDelta;

		while (this.month >= 13) {
			this.month -= 12;
			this.year += 1;
		}
		while (this.month < 1) {
			this.month += 12;
			this.year -= 1;
		}

		this.year += yearDelta;

		this.currentSeason = this.updateSeason();

		this.weekDay = (this.day % 7) + 1;

		callEvent("onCalendar");
	}

	function getCurrentTime() {
		return format(
			"%02i:%02i, %s, Day %i, %s, Month %i, Year %i",
			this.hour, this.minute, season[this.currentSeason], this.day,
			this.getWeekdayName(), this.month, this.year
		);
	}


	function getWeekdayName() {
		switch (this.weekDay) {
			case 1: return "Monday";
			case 2: return "Tuesday";
			case 3: return "Wednesday";
			case 4: return "Thursday";
			case 5: return "Friday";
			case 6: return "Saturday";
			case 7: return "Sunday";
			default: return "Invalid Weekday";
		}
	}

	function updateSeason(){
		local newSeason;
		switch(this.month){
			case 3:
			case 4:
			case 5:
				newSeason = 0;
				setDayLength(LENGTH_OF_DAY);
			break;

			case 6:
			case 7:
			case 8:
				newSeason = 1;
				setDayLength((LENGTH_OF_DAY * 1.5));
			break;

			case 9:
			case 10:
			case 11:
				newSeason = 2;
				setDayLength((LENGTH_OF_DAY * 0.5));
			break;

			case 12:
			case 1:
			case 2:
				newSeason = 3;
				setDayLength((LENGTH_OF_DAY / 4.0));
			break;
		}

		if(newSeason != this.currentSeason){
			this.currentSeason = newSeason;

			callEvent("onSeasonChange", season[this.currentSeason]);
		}

		return newSeason;
	}
}