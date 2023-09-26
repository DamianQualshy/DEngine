PlayerAFKMessage.bind(function(message){
	local state = message.state;

	if(state == true){
		playAni(heroId, "T_STAND_2_SIT");
	} else {
		playAni(heroId, "T_SIT_2_STAND");
	}

	setFreeze(state);

	isHeroAFK = state;
});

PlayerRestMessage.bind(function(message){
	playAni(heroId, message.ani);
	setFreeze(message.state);

	isHeroResting = message.state;
});

addEventHandler("onKey", function(key){
	if(!isHeroResting) return;

	switch(key){
		case KEY_W:
			local stopRest = PlayerRestStopMessage(heroId).serialize();
			stopRest.send(RELIABLE_ORDERED);
		break;
	}
});