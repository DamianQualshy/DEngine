/* local aiTimer;
local svmTimer;
addEventHandler("onNPCCreate", function(nid){
	aiTimer = setTimer(function(){
		for(local id = 0, end = getMaxSlots() + getNPCCount(); id < end; ++id){
			if(!NPCs.rawin(id)) {
				if(!Players.rawin(id)) continue;
				if(!Players[id].isLogged()) continue;

				if(getPlayerDistanceToNpc(id, nid) < 600) {
					B_LookAtNpc(nid, id);
				}
			}
		}
	}, 100, 0);
	svmTimer = setTimer(function(){
		for(local id = 0, end = getMaxSlots() + getNPCCount(); id < end; ++id){
			if(nid == id) continue;

			if(NPCs.rawin(id)) {
				if(getDistanceBetweenNPCs(nid, id) < 300){
					B_LookAtNpc(nid, id);
					//B_Say_Smalltalk(nid, id);
					print("test" + nid + " " + id);
					break;
				}
			}
		}
	}, 10000, 0);
});

addEventHandler("onNPCDestroy", function(nid){
	killTimer(aiTimer);
	killTimer(svmTimer);
});

addEventHandler("onPlayerChangeFocus", function(nid, oldFocus, newFocus){
	if(!isNpc(nid)) return;
	print(nid + " " + oldFocus + " " + newFocus);

	if(newFocus != -1){
		B_LookAtNpc(nid, newFocus);
	} else {
		B_StopLookAt(nid);
	}
});

addEventHandler("onTick", function(){

}); */