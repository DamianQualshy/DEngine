class Inventory {
	id = -1;

	equipment = {
		helmet = null,
		armor = null,
		shield = null,
		melee = null,
		ranged = null,
		amulet = null,
		ringL = null,
		ringR = null,
		belt = null
	};

	quickslot = [];

	items = {};

	constructor(pid){
		this.id = pid;
	}

	function listItems(){
		local itemsList = [];
		foreach(item in this.items){
			itemsList.append({
				instance = item.instance,
				amount = item.amount,

				id = getItemIndex(item.instance)
			});
		}
		return itemsList;
	}

	function equipSlot(instance, slot){
		local _slot = this.equipment;

		switch(slot){
			case inventorySlot.SLOT_HELMET:
				if(_slot.helmet != null) this.unequipSlot(inventorySlot.SLOT_HELMET);

				_slot.helmet = instance;
			break;
			case inventorySlot.SLOT_AMULET:
				if(_slot.amulet != null) this.unequipSlot(inventorySlot.SLOT_AMULET);

				_slot.amulet = instance;
			break;
			case inventorySlot.SLOT_ARMOR:
				if(_slot.armor != null) this.unequipSlot(inventorySlot.SLOT_ARMOR);

				_slot.armor = instance;
			break;
			case inventorySlot.SLOT_BELT:
				if(_slot.belt != null) this.unequipSlot(inventorySlot.SLOT_BELT);

				_slot.belt = instance;
			break;
			case inventorySlot.SLOT_RING:
				if(_slot.ringL != null || _slot.ringR != null) this.unequipSlot(inventorySlot.SLOT_RING);

				if(_slot.ringL == null && _slot.ringR != null) _slot.ringL = instance;
				if(_slot.ringL != null && _slot.ringR == null) _slot.ringR = instance;
			break;
			case inventorySlot.SLOT_SHIELD:
				if(_slot.shield != null) this.unequipSlot(inventorySlot.SLOT_SHIELD);

				_slot.shield = instance;
			break;
			case inventorySlot.SLOT_WEAPONMELEE:
				if(_slot.melee != null) this.unequipSlot(inventorySlot.SLOT_WEAPONMELEE);

				_slot.melee = instance;
			break;
			case inventorySlot.SLOT_WEAPONRANGED:
				if(_slot.ranged != null) this.unequipSlot(inventorySlot.SLOT_WEAPONRANGED);

				_slot.ranged = instance;
			break;
		}

		itemDatabase[getItemIndex(instance)].onEquip(this.id);
	}

	function unequipSlot(slot){
		local _slot = this.equipment;
		local itemInstance;

		switch(slot){
			case inventorySlot.SLOT_HELMET:
				itemInstance = _slot.helmet;
				_slot.helmet = null;
			break;
			case inventorySlot.SLOT_AMULET:
				itemInstance = _slot.amulet;
				_slot.amulet = null;
			break;
			case inventorySlot.SLOT_ARMOR:
				itemInstance = _slot.armor;
				_slot.armor = null;
			break;
			case inventorySlot.SLOT_BELT:
				itemInstance = _slot.belt;
				_slot.belt = null;
			break;
			case inventorySlot.SLOT_RING:
				if(_slot.ringL == null && _slot.ringR != null){
					itemInstance = _slot.ringL;
					_slot.ringL = null;
				}
				if(_slot.ringL != null && _slot.ringR == null){
					itemInstance = _slot.ringR;
					_slot.ringR = null;
				}
			break;
			case inventorySlot.SLOT_SHIELD:
				itemInstance = _slot.shield;
				_slot.shield = null;
			break;
			case inventorySlot.SLOT_WEAPONMELEE:
				itemInstance = _slot.melee;
				_slot.melee = null;
			break;
			case inventorySlot.SLOT_WEAPONRANGED:
				itemInstance = _slot.ranged;
				_slot.ranged = null;
			break;
		}

		if(itemInstance != null){
			if(Players[this.id].isItemEquipped(itemInstance)){
				Players[this.id].unequipItem(itemInstance);
			}
			itemDatabase[getItemIndex(itemInstance)].onUnequip(this.id);
		}
	}
}