/* addEventHandler("onPlayerJoin", function(pid){
	if(isNpc(pid)) return;

	Player(pid);
}); */

addEventHandler("onPlayerDisconnect", function(pid, reason){
	if(isNpc(pid)) return;

	Players.rawdelete(pid);
});