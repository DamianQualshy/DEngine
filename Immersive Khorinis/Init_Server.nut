addEventHandler("onInit", function(){
	MySQL.initializeMySQLConnection();

	Calendar = Calendar();
	setDayLength(LENGTH_OF_DAY);
});

addEventHandler("onExit", function(){
	MySQL.closeMySQLConnection();
})

addEventHandler("onTime", function(day, hour, min){
	/* Calendar.changeTime(1, 0, 0, 0, 0, 0);
	if(Calendar.hour != hour || Calendar.minute != min){
		setTime(Calendar.hour, Calendar.minute);
		cancelEvent();
		print(hour + " " + min);
	} */
});