Item("ITAR_LEATHER_L", {
	name = "Leather Armor",
	description = "Basic hunter gear",

	flag = itemFlag.ITEM_ARMOR,
	sFlag = subFlag.ARMOR_BASIC,

	weight = 0.1,
	value = 10,

	wear = inventorySlot.SLOT_ARMOR,

	protection = {
		edge = 10,
		blunt = 10,
		point = 10,
		magic = 0
	},

	itemText = [
		NAME_PROT_EDGE,
		NAME_PROT_BLUNT,
		NAME_PROT_POINT
	],
	itemCount = [
		10,
		10,
		10
	]
});

Item("ITAR_MIL_L", {
	name = "Militia Armor",
	description = "Light Guard Armor",

	flag = itemFlag.ITEM_ARMOR,
	sFlag = subFlag.ARMOR_LIGHT,

	weight = 0.1,
	value = 10,

	wear = inventorySlot.SLOT_ARMOR,

	protection = {
		edge = 20,
		blunt = 20,
		point = 20,
		magic = 0
	},

	itemText = [
		NAME_PROT_EDGE,
		NAME_PROT_BLUNT,
		NAME_PROT_POINT
	],
	itemCount = [
		20,
		20,
		20
	]
});