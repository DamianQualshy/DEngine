classes <- [
	// Wanderer
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
		name = "Wanderer",
		guild = guilds.UNASSIGNED,
		level_cap = 7,
		spawn = {x = 38609.4, y = 3910.47, z = -1259.92, a = 142.253},
		func = function(id) {
		}
	},
	{
		name = "Wanderer",
		guild = guilds.UNASSIGNED,
		level_cap = 10,
		spawn = {x = 38609.4, y = 3910.47, z = -1259.92, a = 142.253},
		func = function(id) {
		}
	},
	{
		name = "Wanderer",
		guild = guilds.UNASSIGNED,
		level_cap = 12,
		spawn = {x = 38609.4, y = 3910.47, z = -1259.92, a = 142.253},
		func = function(id) {
		}
	},

	// Khorinis
	{
		name = "Citizen",
		guild = guilds.CITIZEN,
		level_cap = 7,
		spawn = {x = 38609.4, y = 3910.47, z = -1259.92, a = 142.253},
		func = function(id) {
			Players[id].giveItem("ITAR_VLK_L", 1);
		}
	},
	{
		name = "City Militia",
		guild = guilds.MILITIA,
		level_cap = 10,
		spawn = {x = 38609.4, y = 3910.47, z = -1259.92, a = 142.253},
		func = function(id) {
			Players[id].giveItem("ITAR_MIL_L", 1);
		}
	},
	{
		name = "City Guard",
		guild = guilds.MILITIA,
		level_cap = 14,
		spawn = {x = 38609.4, y = 3910.47, z = -1259.92, a = 142.253},
		func = function(id) {
			Players[id].giveItem("ITAR_MIL_M", 1);
		}
	},
	{
		name = "City Guard Captain",
		guild = guilds.MILITIA,
		level_cap = 20,
		spawn = {x = 38609.4, y = 3910.47, z = -1259.92, a = 142.253},
		func = function(id) {
			Players[id].giveItem("ITAR_MIL_H", 1);
		}
	},
	{
		name = "Knight",
		guild = guilds.PALADIN,
		level_cap = 25,
		spawn = {x = 38609.4, y = 3910.47, z = -1259.92, a = 142.253},
		func = function(id) {
			Players[id].giveItem("ITAR_PAL_M", 1);
		}
	},
	{
		name = "Paladin",
		guild = guilds.PALADIN,
		level_cap = 30,
		spawn = {x = 38609.4, y = 3910.47, z = -1259.92, a = 142.253},
		func = function(id) {
			Players[id].giveItem("ITAR_PAL_H", 1);
		}
	},
	{
		name = "Royal Guard",
		guild = guilds.ROYALGUARD,
		level_cap = 28,
		spawn = {x = 38609.4, y = 3910.47, z = -1259.92, a = 142.253},
		func = function(id) {
			Players[id].giveItem("ITAR_MIL_G", 1);
		}
	},

	// Mercenaries
	{
		name = "Farmer",
		guild = guilds.FARMER,
		level_cap = 7,
		spawn = {x = 38609.4, y = 3910.47, z = -1259.92, a = 142.253},
		func = function(id) {
			Players[id].giveItem("ITAR_BAU_L", 1);
		}
	},
	{
		name = "Mercenary",
		guild = guilds.MERCENARY,
		level_cap = 10,
		spawn = {x = 38609.4, y = 3910.47, z = -1259.92, a = 142.253},
		func = function(id) {
			Players[id].giveItem("ITAR_SLD_L", 1);
		}
	},
	{
		name = "Mercenary",
		guild = guilds.MERCENARY,
		level_cap = 14,
		spawn = {x = 38609.4, y = 3910.47, z = -1259.92, a = 142.253},
		func = function(id) {
			Players[id].giveItem("ITAR_SLD_M", 1);
		}
	},
	{
		name = "Heavy Mercenary",
		guild = guilds.MERCENARY,
		level_cap = 20,
		spawn = {x = 38609.4, y = 3910.47, z = -1259.92, a = 142.253},
		func = function(id) {
			Players[id].giveItem("ITAR_SLD_H", 1);
		}
	},
	{
		name = "Dragon Hunter",
		guild = guilds.DRAGONHUNTER,
		level_cap = 25,
		spawn = {x = 38609.4, y = 3910.47, z = -1259.92, a = 142.253},
		func = function(id) {
			Players[id].giveItem("ITAR_DJG_L", 1);
		}
	},
	{
		name = "Dragon Hunter",
		guild = guilds.DRAGONHUNTER,
		level_cap = 30,
		spawn = {x = 38609.4, y = 3910.47, z = -1259.92, a = 142.253},
		func = function(id) {
			Players[id].giveItem("ITAR_DJG_H", 1);
		}
	},
	{
		name = "Demon Hunter",
		guild = guilds.DEMONHUNTER,
		level_cap = 28,
		spawn = {x = 38609.4, y = 3910.47, z = -1259.92, a = 142.253},
		func = function(id) {
			Players[id].giveItem("ITAR_DEMONHUNTER", 1);
		}
	},

	// Monastery
	{
		name = "Fire Novice",
		guild = guilds.NOVICE,
		level_cap = 7,
		spawn = {x = 38609.4, y = 3910.47, z = -1259.92, a = 142.253},
		func = function(id) {
			Players[id].giveItem("ITAR_NOV_L", 1);
		}
	},
	{
		name = "Fire Novice",
		guild = guilds.NOVICE,
		level_cap = 10,
		spawn = {x = 38609.4, y = 3910.47, z = -1259.92, a = 142.253},
		func = function(id) {
			Players[id].giveItem("ITAR_NOV_H", 1);
		}
	},
	{
		name = "Fire Mage",
		guild = guilds.FIREMAGE,
		level_cap = 14,
		spawn = {x = 38609.4, y = 3910.47, z = -1259.92, a = 142.253},
		func = function(id) {
			Players[id].giveItem("ITAR_KDF_N", 1);
		}
	},
	{
		name = "Fire Mage",
		guild = guilds.FIREMAGE,
		level_cap = 20,
		spawn = {x = 38609.4, y = 3910.47, z = -1259.92, a = 142.253},
		func = function(id) {
			Players[id].giveItem("ITAR_KDF_L", 1);
		}
	},
	{
		name = "Archmage of Fire",
		guild = guilds.ARCHFIREMAGE,
		level_cap = 25,
		spawn = {x = 38609.4, y = 3910.47, z = -1259.92, a = 142.253},
		func = function(id) {
			Players[id].giveItem("ITAR_KDF_M", 1);
		}
	},
	{
		name = "Archmage of Fire",
		guild = guilds.ARCHFIREMAGE,
		level_cap = 30,
		spawn = {x = 38609.4, y = 3910.47, z = -1259.92, a = 142.253},
		func = function(id) {
			Players[id].giveItem("ITAR_KDF_H", 1);
		}
	}
];

classesNPC <- [
	{
		name = "Wanderer",
		guild = guilds.UNASSIGNED,
		func = function(id) {
			NPCs[id].setHealth(20);
			NPCs[id].setMaxHealth(20);
			NPCs[id].setMana(10);
			NPCs[id].setMaxMana(10);

			NPCs[id].setStrength(10);
			NPCs[id].setDexterity(10);

			NPCs[id].setOneHandSkill(10);
			NPCs[id].setTwoHandSkill(10);
			NPCs[id].setBowSkill(10);
			NPCs[id].setCrossbowSkill(10);

			NPCs[id].setMagicCircle(0);

			NPCs[id].giveItem("ITAR_LEATHER_L", 1);
			NPCs[id].giveItem("ITMW_NAGELKNUEPPEL", 1);

			NPCs[id].equipItem("ITAR_LEATHER_L");
			NPCs[id].equipItem("ITMW_NAGELKNUEPPEL");
		}
	},
	{
		name = "Innkeeper",
		guild = guilds.UNASSIGNED,
		func = function(id) {
			NPCs[id].setHealth(20);
			NPCs[id].setMaxHealth(20);
			NPCs[id].setMana(10);
			NPCs[id].setMaxMana(10);

			NPCs[id].setStrength(10);
			NPCs[id].setDexterity(10);

			NPCs[id].setOneHandSkill(10);
			NPCs[id].setTwoHandSkill(10);
			NPCs[id].setBowSkill(10);
			NPCs[id].setCrossbowSkill(10);

			NPCs[id].setMagicCircle(0);

			NPCs[id].giveItem("ITAR_BAU_M", 1);
			NPCs[id].giveItem("ITMW_1H_VLK_DAGGER", 1);

			NPCs[id].equipItem("ITAR_BAU_M");
			NPCs[id].equipItem("ITMW_1H_VLK_DAGGER");
		}
	},
	{
		name = "City Guard",
		guild = guilds.MILITIA,
		func = function(id) {
			NPCs[id].setHealth(200);
			NPCs[id].setMaxHealth(200);
			NPCs[id].setMana(10);
			NPCs[id].setMaxMana(10);

			NPCs[id].setStrength(200);
			NPCs[id].setDexterity(200);

			NPCs[id].setOneHandSkill(100);
			NPCs[id].setTwoHandSkill(100);
			NPCs[id].setBowSkill(100);
			NPCs[id].setCrossbowSkill(100);

			NPCs[id].setMagicCircle(0);

			NPCs[id].giveItem("ITAR_MIL_L", 1);
			NPCs[id].giveItem("ITMW_1H_MIL_SWORD", 1);

			NPCs[id].equipItem("ITAR_MIL_L");
			NPCs[id].equipItem("ITMW_1H_MIL_SWORD");
		}
	},
	{
		name = "Passage Guard",
		guild = guilds.MILITIA,
		func = function(id) {
			NPCs[id].setHealth(200);
			NPCs[id].setMaxHealth(200);
			NPCs[id].setMana(10);
			NPCs[id].setMaxMana(10);

			NPCs[id].setStrength(200);
			NPCs[id].setDexterity(200);

			NPCs[id].setOneHandSkill(100);
			NPCs[id].setTwoHandSkill(100);
			NPCs[id].setBowSkill(100);
			NPCs[id].setCrossbowSkill(100);

			NPCs[id].setMagicCircle(0);

			NPCs[id].giveItem("ITAR_MIL_M", 1);
			NPCs[id].giveItem("ITMW_1H_MIL_SWORD", 1);

			NPCs[id].equipItem("ITAR_MIL_M");
			NPCs[id].equipItem("ITMW_1H_MIL_SWORD");
		}
	},
	{
		name = "Fire Mage",
		guild = guilds.FIREMAGE,
		func = function(id) {
			NPCs[id].setHealth(200);
			NPCs[id].setMaxHealth(200);
			NPCs[id].setMana(500);
			NPCs[id].setMaxMana(500);

			NPCs[id].setStrength(200);
			NPCs[id].setDexterity(200);

			NPCs[id].setOneHandSkill(100);
			NPCs[id].setTwoHandSkill(100);
			NPCs[id].setBowSkill(100);
			NPCs[id].setCrossbowSkill(100);

			NPCs[id].setMagicCircle(6);

			NPCs[id].giveItem("ITAR_KDF_L", 1);

			NPCs[id].equipItem("ITAR_KDF_L");
		}
	}
];