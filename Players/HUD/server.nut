addEventHandler("onPlayerChangeFocus", function(pid, oldFocus, newFocus){
	if(isNpc(pid)) return;

	updateFocusHealth(pid, newFocus);
});

CollectFocusMessage.bind(function(pid, message){
	updateFocusHealth(pid, message.focusId);
});

function updateFocusHealth(pid, focusId){
	local hp = -1;
	local maxhp = -1;

	if(focusId != -1){
		if(isNpc(focusId)) {
			if(NPCs.rawin(focusId)){
				hp = NPCs[focusId].getHealth();
				maxhp = NPCs[focusId].getMaxHealth();
			}
		} else {
			if(Players.rawin(focusId)){
				hp = Players[focusId].getHealth();
				maxhp = Players[focusId].getMaxHealth();
			}
		}
	}

	local updateFocusHealth = FocusHealthMessage(pid,
		focusId,
		hp,
		maxhp
		).serialize();
	updateFocusHealth.send(pid, RELIABLE_ORDERED);
}