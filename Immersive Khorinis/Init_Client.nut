local barrier;
addEventHandler("onInit", function(){
	clearMultiplayerMessages();
	setKeyLayout(1);

	enableEvent_Render(true);

	Calendar = Calendar();
	setDayLength(LENGTH_OF_DAY);

	Ore("ORE_GROUND.ASC", "NEWWORLD\\NEWWORLD.ZEN", 0.0, 0.0, 0.0, 0);
	/* barrier = Barrier();
	barrier.setModel("MAGICFRONTIER_OUT.3DS");
	barrier.setTexture("BARRIERE.TGA");
});

addEventHandler("onRender", function(){
	barrier.render(); */
});

/* addEventHandler("onWorldEnter", function(world){
	if(world == "OLDWORLD\\OLDWORLD.ZEN" || world == "COLONY.ZEN"){
		barrier.setModel("MAGICFRONTIER_OUT.3DS");
	}
	if(world == "NEWWORLD\\NEWWORLD.ZEN"){
		barrier.setModel("MAGICFRONTIER_KHORINIS.3DS");
	}
});

addEventHandler("onKey", function(key){
	if(chatInputIsOpen() || loginGUIvisible || creatorGUIvisible || animGUIvisible || statsGUIvisible) return;

	switch(key){
		case KEY_K:
			barrier.setModel("MAGICFRONTIER_KHORINIS_CITY.3DS");
		break;
		case KEY_L:
			barrier.setModel("MAGICFRONTIER_KHORINIS.3DS");
		break;
	}
}); */

addEventHandler("onTime", function(day, hour, min){
	/* Calendar.changeTime(1, 0, 0, 0, 0, 0);
	if(Calendar.hour != hour || Calendar.minute != min){
		setTime(Calendar.hour, Calendar.minute);
		cancelEvent();
		print(hour + " " + min);
	} */
});