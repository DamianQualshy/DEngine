class Calendar {
	minute = -1;
	hour = -1;
	day = -1;

	constructor() {
		local result = MySQL.query("SELECT * FROM Server_Info");
		local row = MySQL.fetchAssoc(result);
		MySQL.freeResult(result);

			if(row != null){
				local gameTime = row.Game_Time;
				local dateAndTime = split(gameTime, " ");

				local dateComponents = split(dateAndTime[0], "-");
				local timeComponents = split(dateAndTime[1], ":");

				this.day = dateComponents[2].tointeger();

				this.hour = timeComponents[0].tointeger();
				this.minute = timeComponents[1].tointeger();
			}

			if(this.minute < 0 || this.hour < 0 || this.day < 1){
				this.day = 1;

				this.hour = 0;
				this.minute = 0;
			}
	}

	function changeTime(minuteDelta, hourDelta, dayDelta) {
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
	}

	function getCurrentTime() {
		return format(
			"%02i:%02i, Day %i",
			this.hour, this.minute, this.day
		);
	}
}