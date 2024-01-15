addEventHandler("onPlayerEnterZone", function(pid, area){
	if(!area.isChunk) return;
});

addEventHandler("onPlayerExitZone", function(pid, area){
	if(!area.isChunk) return;
});