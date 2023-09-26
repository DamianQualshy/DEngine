classes <- [
	{
		name = "Wanderer",
		guild = guilds.UNASSIGNED,
		level_cap = 5,
		spawn = {x = 38609.4, y = 3910.47, z = -1259.92, a = 142.253},
		func = function(id) {
			Players[id].giveItem("ITAR_LEATHER_L", 1);
			Players[id].giveItem("ITMW_NAGELKNUEPPEL", 1);
			Players[id].giveItem("ITPO_HEALTH_01", 10);
			Players[id].giveItem("ITPO_HEALTH_02", 10);
		}
	},
	{
		name = "Wanderer 2",
		guild = guilds.UNASSIGNED,
		level_cap = 7,
		spawn = {x = 38609.4, y = 3910.47, z = -1259.92, a = 142.253},
		func = function(id) {
			Players[id].giveItem("ITAR_LEATHER_L", 1);
			Players[id].giveItem("ITMW_NAGELKNUEPPEL", 1);
			Players[id].giveItem("ITPO_HEALTH_01", 10);
			Players[id].giveItem("ITPO_HEALTH_02", 10);
		}
	}
];
