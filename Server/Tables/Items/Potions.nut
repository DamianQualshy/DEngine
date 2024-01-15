Item("ITPO_HEALTH_01", {
	name = "Potion of Health",
	description = "Recovers 5 Health Points",

	flag = itemFlag.ITEM_POTION,
	sFlag = subFlag.POTION_RESTORE,

	weight = 0.1,
	value = 10,

	restore = {
		health = 5
	},

	itemText = [
		NAME_RECOVER_HEALTH
	],
	itemCount = [
		5
	]
});