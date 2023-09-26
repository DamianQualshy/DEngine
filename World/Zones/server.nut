addEventHandler("onInit", function(){
	foreach(zone in zones){
		AreaManager.add(zone);
	}
})

/* addEventHandler("onPlayerEnterZone", function(pid, area){
	sendMessageToPlayer(pid, 255, 0, 0, "You entered " + area.name)
});

addEventHandler("onPlayerExitZone", function(pid, area){
	sendMessageToPlayer(pid, 255, 0, 0, "You left " + area.name)
}); */