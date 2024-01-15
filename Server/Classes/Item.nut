itemDatabase <- {};

class Item {
	index = -1;
	instance = "";

	name = "";
	description = "";

	flag = itemFlag.ITEM_MISC;
	sFlag = subFlag.ITEM_MISC;

	weight = 0.0;
	value = 0;

	owner = -1;
	ownerGuild = -1;

	itemText = -1;
	itemCount = -1;

	wear = -1;
	protection = -1;

	damage = -1;
	condition = -1;

	change = -1;
	restore = -1;

	constructor(instance, arg){
		this.index = Daedalus.index(instance);
		this.instance = instance;

		this.name = ("name" in arg) ? arg.name : name;
		this.description = ("description" in arg) ? arg.description : description;

		this.flag = ("flag" in arg) ? arg.flag : flag;
		this.sFlag = ("sFlag" in arg) ? arg.sFlag : sFlag;

		this.weight = ("weight" in arg) ? arg.weight : weight;
		this.value = ("value" in arg) ? arg.value : value;

		this.owner = ("owner" in arg) ? arg.owner : owner;
		this.ownerGuild = ("ownerGuild" in arg) ? arg.ownerGuild : ownerGuild;

		this.wear = ("wear" in arg) ? arg.wear : wear;
		this.protection = ("protection" in arg) ? arg.protection : protection;

		this.damage = ("damage" in arg) ? arg.damage : damage;
		this.condition = ("condition" in arg) ? arg.condition : condition;

		this.change = ("change" in arg) ? arg.change : change;
		this.restore = ("restore" in arg) ? arg.restore : restore;

		this.itemText = ("itemText" in arg) ? arg.itemText : itemText;
		this.itemCount = ("itemCount" in arg) ? arg.itemCount : itemCount;

		itemDatabase[index] <- this;
	}

	function removeItem(){
		itemDatabase.rawdelete(this.instance);
	}
}

function getItemIndex(instance){
	if(instance == null) return;
	instance = convert(instance, "string").toupper();

	return Daedalus.index(instance);
}

function doesItemExist(instance){
	if(instance == null) return;
	instance = convert(instance, "string").toupper();

	local id = getItemIndex(instance);
	return itemDatabase.rawin(id);
}

if(SERVER_SIDE){
	addEvent("onItemUse");
	addEvent("onItemEquip");
	addEvent("onItemUnequip");

	function Item::onUse(pid){
		/* if(this.flag == itemFlag.ITEM_POTION){
			if(this.restore.rawin("health")) Players[pid].restoreHealth(this.restore.health);
			if(this.restore.rawin("mana")) Players[pid].restoreMana(this.restore.mana);
		}
		if(this.flag == itemFlag.ITEM_PERMPOTION){
			if(this.change.rawin("health")) Players[pid].addHealth(this.change.health);
			if(this.change.rawin("mana")) Players[pid].addMana(this.change.mana);
			if(this.change.rawin("strength")) Players[pid].addStrength(this.change.strength);
			if(this.change.rawin("dexterity")) Players[pid].addDexterity(this.change.dexterity);
		} */
		callEvent("onItemUse", pid, this.instance);
	}

	function Item::onEquip(pid){
		callEvent("onItemEquip", pid, this.instance, this.wear);
	}

	function Item::onUnequip(pid){
		callEvent("onItemUnequip", pid, this.instance, this.wear);
	}


	function checkEquip(pid, itemInstance, slot){
		if(itemInstance == null){
			Players[pid].inventory.unequipSlot(slot);
		} else {
			if(doesItemExist(itemInstance)){
				if(Players[pid].inventory.items.rawin(getItemIndex(itemInstance))){
					if(itemDatabase[getItemIndex(itemInstance)].wear == slot){
						Players[pid].inventory.equipSlot(itemInstance, slot);
					} else {
						unequipItem(pid, itemInstance);
					}
				} else {
					unequipItem(pid, itemInstance);
				}
			} else {
				unequipItem(pid, itemInstance);
			}
		}
	}

	addEventHandler("onPlayerEquipHelmet", function(pid, itemInstance){
		if(isNpc(pid)) return;
		checkEquip(pid, itemInstance, inventorySlot.SLOT_HELMET);
	});
	addEventHandler("onPlayerEquipArmor", function(pid, itemInstance){
		if(isNpc(pid)) return;
		checkEquip(pid, itemInstance, inventorySlot.SLOT_ARMOR);
	});
	addEventHandler("onPlayerEquipShield", function(pid, itemInstance){
		if(isNpc(pid)) return;
		checkEquip(pid, itemInstance, inventorySlot.SLOT_SHIELD);
	});
	addEventHandler("onPlayerEquipMeleeWeapon", function(pid, itemInstance){
		if(isNpc(pid)) return;
		checkEquip(pid, itemInstance, inventorySlot.SLOT_WEAPONMELEE);
	});
	addEventHandler("onPlayerEquipRangedWeapon", function(pid, itemInstance){
		if(isNpc(pid)) return;
		checkEquip(pid, itemInstance, inventorySlot.SLOT_WEAPONRANGED);
	});
	addEventHandler("onPlayerEquipAmulet", function(pid, itemInstance){
		if(isNpc(pid)) return;
		checkEquip(pid, itemInstance, inventorySlot.SLOT_AMULET);
	});
	addEventHandler("onPlayerEquipRing", function(pid, itemInstance){
		if(isNpc(pid)) return;
		checkEquip(pid, itemInstance, inventorySlot.SLOT_RING);
	});
	addEventHandler("onPlayerEquipBelt", function(pid, itemInstance){
		if(isNpc(pid)) return;
		checkEquip(pid, itemInstance, inventorySlot.SLOT_BELT);
	});
	/* addEventHandler("onPlayerEquipSpell", function(pid, itemInstance){
		if(isNpc(pid)) return;
		if(itemInstance.find("ITRU_")){
			checkEquip(pid, itemInstance, inventorySlot.SLOT_RUNE);
		} else {
			checkEquip(pid, itemInstance, inventorySlot.SLOT_SCROLL);
		}
	}); */
	addEventHandler("onPlayerEquipHandItem", function(pid, handSlot, itemInstance){
		if(isNpc(pid)) return;
		if(itemInstance == null) return;
		itemDatabase[getItemIndex(itemInstance)].onUse(pid);
		//checkEquip(pid, itemInstance, inventorySlot.SLOT_HAND);
	});
}