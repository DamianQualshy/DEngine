class Calendar {
	minute = 0;
	hour = 8;
	day = 1;
	week = 1;
	month = 1;
	year = 1;
	season = ["Spring", "Summer", "Autumn", "Winter"];
	currentSeason = 0;
	weekDay = 1;

	constructor() {
		this.minute = 0;
		this.hour = 8;
		this.day = 1;
		this.week = 1;
		this.month = 1;
		this.year = 1;
		this.season = ["Spring", "Summer", "Autumn", "Winter"];
		this.currentSeason = 0;
		this.weekDay = 1;
	}

	function changeTime(minuteDelta, hourDelta, dayDelta, weekDelta, monthDelta, yearDelta) {

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

		while (this.day >= 7) {
			this.day -= 7;
			this.week += 1;
		}
		while (this.day < 0) {
			this.day += 7;
			this.week -= 1;
		}

		this.week += weekDelta;

		while (this.week >= 4) {
			this.week -= 4;
			this.month += 1;
		}
		while (this.week < 0) {
			this.week += 4;
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

		this.currentSeason = floor((this.month - 1) / 3);

		while (dayDelta > 0) {
			this.weekDay = (this.weekDay % 7) + 1;
			dayDelta -= 1;
		}
		while (dayDelta < 0) {
			this.weekDay = (this.weekDay + 5) % 7 + 1;
			dayDelta += 1;
		}
	}

	function getCurrentTime() {
		return format(
			"%02i:%02i, %s, Day %i, %s, Week %i, Month %i, Year %i",
			this.hour, this.minute, this.season[this.currentSeason], this.day,
			this.getWeekdayName(), this.week, this.month, this.year
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
}