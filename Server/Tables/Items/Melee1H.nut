Item("ITMW_1H_VLK_DAGGER", {
	name = "Dagger",
	description = "Small, dull weapon",

	flag = itemFlag.ITEM_MELEE,
	sFlag = subFlag.WEAPON_1HBLADE,

	weight = 0.1,
	value = 10,

	wear = inventorySlot.SLOT_WEAPONMELEE,

	damage = {
		edge = 5
	},
	condition = {
		strength = 5
	},

	itemText = [
		NAME_DAMAGE_EDGE,
		NAME_CONDITION_STR
	],
	itemCount = [
		5,
		5
	]
});