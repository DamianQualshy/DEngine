addEvent("onItemCreate");
addEvent("onItemRemove");
addEvent("onItemUse");
addEvent("onItemEquip");
addEvent("onItemUnequip");

itemDatabase <- {};
class Item {
	id = null;
	instance = null;

	name = null;
	description = null;

	flag = null;
	weight = null;
	value = null;

	wear = null;
	owner = null;
	ownerGuild = null;

	damage = {edge = null, blunt = null, point = null, magic = null};

	protection = {edge = null, blunt = null, point = null, magic = null};

	condition = {strength = null, dexterity = null, mana = null, magic_circle = null};

	restore = {health = null, mana = null};

	change = {health = null, mana = null, strength = null, dexterity = null};

	constructor(id, args) {
		this.id = id;

		//Items[id] <- this;
		itemDatabase[id] <- this;
		this.createItem(args);
	}

	function onUse(pid){
		if(this.flag == itemFlag.ITEM_POTION){
			if(this.restore.rawin("health")) Players[pid].restoreHealth(this.restore.health);
			if(this.restore.rawin("mana")) Players[pid].restoreMana(this.restore.mana);
		}
		if(this.flag == itemFlag.ITEM_PERMPOTION){
			if(this.change.rawin("health")) Players[pid].addHealth(this.change.health);
			if(this.change.rawin("mana")) Players[pid].addMana(this.change.mana);
			if(this.change.rawin("strength")) Players[pid].addStrength(this.change.strength);
			if(this.change.rawin("dexterity")) Players[pid].addDexterity(this.change.dexterity);
		}
		callEvent("onItemUse", pid, this.instance);
	}

	function onEquip(pid){
		callEvent("onItemEquip", pid, this.instance);
	}

	function onUnequip(pid){
		callEvent("onItemUnequip", pid, this.instance);
	}

	function createItem(properties){
		foreach(key, value in properties){
			this[key] = value;
		}
		callEvent("onItemCreate", this.instance);
	}

	function removeItem(){
		itemDatabase.rawdelete(this.id);
		callEvent("onItemRemove", this.instance);
	}
}

function getItemId(instance){
	instance = instance.toupper();

	foreach(item in itemDatabase){
		if(item.instance == instance) return item.id;
	}
}

function getItemName(instance){
	instance = instance.toupper();

	foreach(item in itemDatabase){
		if(item.instance == instance) return item.name;
	}
}

function getItemInstance(name){
	foreach(item in itemDatabase){
		if(item.name == name) return item.instance;
	}
}

function getItemDescription(instance){
	instance = instance.toupper();

	foreach(item in itemDatabase){
		if(item.instance == instance) return item.description;
	}
}

addEventHandler("onInit", function(){
	foreach(args in ik_items){
		Item(Items.id(args.instance), args);
	}
});

addEventHandler("onPlayerEquipAmulet", function(pid, itemId){
	if(itemId == -1) return;
	Players[pid].equipItem(Items.name(itemId));
});
addEventHandler("onPlayerEquipArmor", function(pid, itemId){
	if(itemId == -1) return;
	Players[pid].equipItem(Items.name(itemId));
});
addEventHandler("onPlayerEquipBelt", function(pid, itemId){
	if(itemId == -1) return;
	Players[pid].equipItem(Items.name(itemId));
});
addEventHandler("onPlayerEquipHelmet", function(pid, itemId){
	if(itemId == -1) return;
	Players[pid].equipItem(Items.name(itemId));
});
addEventHandler("onPlayerEquipMeleeWeapon", function(pid, itemId){
	if(itemId == -1) return;
	Players[pid].equipItem(Items.name(itemId));
});
addEventHandler("onPlayerEquipRangedWeapon", function(pid, itemId){
	if(itemId == -1) return;
	Players[pid].equipItem(Items.name(itemId));
});
addEventHandler("onPlayerEquipRing", function(pid, itemId){
	if(itemId == -1) return;
	Players[pid].equipItem(Items.name(itemId));
});
addEventHandler("onPlayerEquipShield", function(pid, itemId){
	if(itemId == -1) return;
	Players[pid].equipItem(Items.name(itemId));
});