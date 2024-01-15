Item("ITMW_2H_AXE_L_01", {
	name = "Pickaxe",
	description = "Necessary in mining",

	flag = itemFlag.ITEM_MELEE,
	sFlag = subFlag.WEAPON_2HAXE,

	weight = 0.1,
	value = 10,

	wear = inventorySlot.SLOT_WEAPONMELEE,

	damage = {
		blunt = 10
	},
	condition = {
		strength = 5
	},

	itemText = [
		NAME_DAMAGE_BLUNT,
		NAME_CONDITION_STR
	],
	itemCount = [
		10,
		5
	]
});