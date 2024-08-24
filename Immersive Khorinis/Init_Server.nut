addEventHandler("onPlayerJoin", function(pid){
	Player(pid, {
		name = getPlayerName(pid)
		scale = {x = 1.0, y = 1.0, z = 3.0}
		pos = {
			x = 1275.29,
			y = 0.0,
			z = -1734.19,
			a = 90.0
		}
	});
		local _pos = getPlayerPosition(pid);

	foreach(npc in NPCs){
		npc.setPosition(_pos.x, _pos.y, _pos.z, 90);
	}

	Calendar().handleSeasonChangeForPlayer(pid);

	/* foreach(npc in NPCS){
		local sendNPCID = NPCIdentificationMessage(npc).serialize()
		sendNPCID.send(pid, RELIABLE)
	} */
});

local function onEnter(pid){
	print("test enter")
}

local function onExit(pid){
	print("test exit")
}

local function init_handler() {
	local testArea = Area({
		points = [
			{x = 1000.0, z = 1000.0},
			{x = -1000.0, z = -1000.0},
			{x = -1000.0, z = 1000.0},
			{x = 1000.0, z = -1000.0},
		],

		world = getServerWorld()
	})

	AreaManager.add(testArea, onEnter, onExit);

	createChunksForMap();
}
addEventHandler("onInit", init_handler)

addEventHandler("onPlayerEnterArea", function(pid, area){
	if(area instanceof Chunk) return;

	local areaFunction = AreaManager.enterCallbacks[area];
	if(areaFunction != null) AreaManager.enterCallbacks[area](pid);

	print("testu testu 1")
});

addEventHandler("onPlayerExitArea", function(pid, area){
	if(area instanceof Chunk) return;

	local areaFunction = AreaManager.exitCallbacks[area];
	if(areaFunction != null) AreaManager.exitCallbacks[area](pid);

	print("testu testu 2")
});