addEventHandler("onPlayerHit", function(kid, pid, desc){
	if(kid != -1){
		local updateFocus = FocusHitMessage(kid,
			pid,
			desc.damage
			).serialize();
		updateFocus.send(RELIABLE_ORDERED);
	}
	cancelEvent();
});