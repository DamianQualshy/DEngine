local LENGTH_OF_DAY = 10800000.0; //10800 seconds = 3 hours

addEventHandler("onInit", function(){
	Calendar = Calendar();
	setTime(0,0);

	setDayLength(LENGTH_OF_DAY/200);
});

addEventHandler("onTime", function(day, hour, min){
	Calendar.tick();
	//print(Calendar.getIngameTime());
});