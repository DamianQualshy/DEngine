local SECONDS_PER_MINUTE = 60;
local MINUTES_PER_HOUR = 60;
local HOURS_PER_DAY = 24;
local DAYS_PER_WEEK = 7;
local DAYS_PER_MONTH = 28;
local WEEKS_PER_MONTH = 4;
local MONTHS_PER_YEAR = 12;
local SEASONS_PER_YEAR = 4;

local seasons = [
	{}
];

class Calendar {
	season = 0;

	second = 0;
	minute = 0;
	hour = 0;

	day = 0;
	week = 0;
	month = 0;
	year = 0;

	constructor() {
		this.season = 0;

		this.second = 0;
		this.minute = 0;
		this.hour = 0;

		this.day = 0;
		this.week = 0;
		this.month = 0;
		this.year = 0;
	}

	function setSeason(season){
		this.season = season;
	}
	function getSeason(){
		return this.season;
	}

	function setSecond(second){
		this.second = second;
	}
	function getSecond(){
		return this.second;
	}

	function setMinute(minute){
		this.minute = minute % MINUTES_PER_HOUR;
	}
	function getMinute(){
		return this.minute;
	}

	function setHour(hour){
		this.hour = hour % HOURS_PER_DAY;
	}
	function getHour(){
		return this.hour;
	}

	function setDay(day){
		this.day = day % DAYS_PER_MONTH;
	}
	function getDay(){
		return this.day;
	}

	function setWeek(week){
		this.week = week % WEEKS_PER_MONTH;
	}
	function getWeek(){
		return this.week;
	}

	function setMonth(month){
		this.month = month % MONTHS_PER_YEAR;
	}
	function getMonth(){
		return this.month;
	}

	function setYear(year){
		this.year = year;
	}
	function getYear(){
		return this.year;
	}

	function tick(){
		this.second += 60;
		this.minute++;
		if(this.minute >= MINUTES_PER_HOUR){
			this.hour++;
			this.minute = 0;
			if(this.hour >= HOURS_PER_DAY){
				this.day++;
				this.hour = 0;
				if(this.day >= DAYS_PER_MONTH){
					this.month++;
					this.day = 1;
					if(this.month > MONTHS_PER_YEAR){
						this.year++;
						this.month = 1;
					}
				}
			}
		}
	}

	function convertTimestamp(timestamp){
		local _min = floor(timestamp / SECONDS_PER_MINUTE) % MINUTES_PER_HOUR;
		local _hour = floor(timestamp / (SECONDS_PER_MINUTE * MINUTES_PER_HOUR)) % HOURS_PER_DAY;
		local _day = floor(timestamp / (SECONDS_PER_MINUTE * MINUTES_PER_HOUR * HOURS_PER_DAY)) % (DAYS_PER_WEEK * WEEKS_PER_MONTH);
		local _week = floor(_day / DAYS_PER_WEEK);
		local _month = floor(_week / WEEKS_PER_MONTH) % MONTHS_PER_YEAR;
		local _year = floor(_week / (WEEKS_PER_MONTH * MONTHS_PER_YEAR));

		return format("[%02d/%02d/%04d] (%02d:%02d)", _day, _month, _year, _hour, _minute);
	}

	function updateTime(minute, hour, day, month, year){
		setYear(year * (MONTHS_PER_YEAR * DAYS_PER_MONTH * HOURS_PER_DAY * MINUTES_PER_HOUR * SECONDS_PER_MINUTE));
		setMonth(month * (DAYS_PER_MONTH * HOURS_PER_DAY * MINUTES_PER_HOUR * SECONDS_PER_MINUTE));
		setDay(day * (HOURS_PER_DAY * MINUTES_PER_HOUR * SECONDS_PER_MINUTE));
		setHour(hour * (MINUTES_PER_HOUR * SECONDS_PER_MINUTE));
		setMinute(minute * SECONDS_PER_MINUTE);

		setSecond((_year + _month + _day + _hour + _min) - 60); //wyrówna siê w onTime

		setTime(this.hour, this.minute);
	}

	function getIngameTime(){
		return format("[%02d/%02d/%04d] (%02d:%02d)", this.day, this.month, this.year, this.hour, this.minute);
	}
	function getTime(){
		return this;
	}
}