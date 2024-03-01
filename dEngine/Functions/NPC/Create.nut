local _createNpc = createNpc;

function createNPC(params){
	local id = _createNpc(params.name, params.instance);

	NPC(id, params);
}

addEventHandler("onInit", function(){
	createNPC({
		name = "NPC Hero",

		instance = "PC_HERO",
		guild = 1,

		level = 1,

		visual = ["HUM_BODY_NAKED0", 8, "HUM_HEAD_PONY", 18],
		walk = "HUMANS.MDS",
		height = 1.0,
		fatness = 0.9
	});
})