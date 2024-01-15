addEventHandler("onInit", function(){
	Calendar = Calendar();
});

addEventHandler("onExit", function(){
	local result = MySQL.query("SELECT Game_Time FROM Server_Info");
	local row = MySQL.fetchAssoc(result);
		MySQL.freeResult(result);

	if(row == null){
		MySQL.insert("Server_Info", {
			Game_Time = format("%04d-%02d-%02d %02d:%02d:%02d", Calendar.year, Calendar.month, Calendar.day, Calendar.hour, Calendar.minute, 0)
		});
	} else {
		MySQL.updateAll("Server_Info", {
			Game_Time = format("%04d-%02d-%02d %02d:%02d:%02d", Calendar.year, Calendar.month, Calendar.day, Calendar.hour, Calendar.minute, 0)
		});
	}
});

addEventHandler("onTime", function(day, hour, min){
	if(Calendar.hour != hour || Calendar.minute != min){
		setTime(Calendar.hour, Calendar.minute);
	} else if(Calendar.hour == hour && Calendar.minute == min){
		Calendar.changeTime(1, 0, 0, 0, 0);
	}
});

addEventHandler("onCalendar", function(){
	for(local i = 0, end = getMaxSlots(); i < end; ++i){
		if(!Players.rawin(i)) continue;
		if(!Players[i].isLogged()) continue;

		local timePacket = TimeMessage(i,
			Calendar.hour,
			Calendar.minute,
			Calendar.day,
			Calendar.month,
			Calendar.year,
			getDayLength(),
			season[Calendar.currentSeason]
			).serialize();
		timePacket.send(i, RELIABLE_ORDERED);
	}
});