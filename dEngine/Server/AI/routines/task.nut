class Task {
	constructor(action, start_h, start_m, stop_h, stop_m, waypoint){
		this.action = action;

		this.hour_start = start_h;
		this.minute_start = start_m;
		this.hour_end = stop_h;
		this.minute_end = stop_m;

		this.waypoint = waypoint;
	}

	function isCurrentTime(hour, minute) {
		local startTime = this.hour_start * 60 + this.minute_start;
		local endTime = this.hour_end * 60 + this.minute_end;
		local currentTime = hour * 60 + minute;
		return currentTime >= startTime && currentTime < endTime;
	}
}