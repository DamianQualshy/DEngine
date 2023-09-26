local khorinisCity
local monastery
local lighthouse
local taverne

zones <- [
	khorinisCity = Area({
		name = "City of Khorinis",
		world = "NEWWORLD\\NEWWORLD.ZEN",
		points = [
			{x = 0.0, z = 0.0},
			{x = 0.0, z = 0.0},
			{x = 0.0, z = 0.0},
			{x = 0.0, z = 0.0},
			{x = 0.0, z = 0.0},
			{x = 0.0, z = 0.0}
		]
	}),
	monastery = Area({
		name = "Monastery of Innos",
		world = "NEWWORLD\\NEWWORLD.ZEN",
		points = [
			{x = 0.0, z = 0.0},
			{x = 0.0, z = 0.0},
			{x = 0.0, z = 0.0},
			{x = 0.0, z = 0.0},
			{x = 0.0, z = 0.0},
			{x = 0.0, z = 0.0}
		]
	}),
	lighthouse = Area({
		name = "Lighthouse",
		world = "NEWWORLD\\NEWWORLD.ZEN",
		points = [
			{x = 0.0, z = 0.0},
			{x = 0.0, z = 0.0},
			{x = 0.0, z = 0.0},
			{x = 0.0, z = 0.0},
			{x = 0.0, z = 0.0},
			{x = 0.0, z = 0.0}
		]
	}),
	taverne = Area({
		name = "'Dead Harpy' Tavern",
		world = "NEWWORLD\\NEWWORLD.ZEN",
		points = [
			{x = 38342.8, z = -1739.81},
			{x = 38409.4, z = -2738.75},
			{x = 36501.3, z = -2865.9},
			{x = 36410.3, z = -1497.91},
			{x = 37372.4, z = -1401.03},
			{x = 37428.9, z = -1799.83}
		]
	})
];

foreach(zone in zones){
	AreaManager.add(zone);
}