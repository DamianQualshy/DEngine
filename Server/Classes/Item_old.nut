addEvent("onItemCreate");
addEvent("onItemRemove");
addEvent("onItemUse");
addEvent("onItemEquip");
addEvent("onItemUnequip");

itemDatabase <- {};
class Item {
	index = null;
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

	constructor(args) {
		index = args.index;

		itemDatabase[index] <- this;
		this.createItem(args);
	}



	function createItem(properties){
		foreach(key, value in properties){
			this[key] = value;
		}
		callEvent("onItemCreate", this.instance);
	}


}

/* function getItemName(instance){
	instance = convert(instance, "string").toupper();

	foreach(item in itemDatabase){
		if(item.instance == instance) return item.name;
	}
} */



/* function getItemInstance(name){
	name = convert(name, "string");

	foreach(item in itemDatabase){
		if(item.name == name) return item.instance;
	}
} */

/* function getItemDescription(instance){
	instance = convert(instance, "string").toupper();

	foreach(item in itemDatabase){
		if(item.instance == instance) return item.description;
	}
} */



addEventHandler("onInit", function(){
	foreach(args in ik_items){
		Item(args);
	}
});

