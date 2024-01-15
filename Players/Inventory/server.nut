ItemUseMessage.bind(function(pid, message){
	itemDatabase[message.itemId].onUse(pid);
});

addEventHandler("onItemUse", function(pid, instance){
	local _item = Players[pid].inventory.items[getItemIndex(instance)];

	local inventoryUpdateItem = InventoryUpdateItemMessage(pid,
		instance,
		("amount" in _item) ? _item.amount : 0
		).serialize();
	inventoryUpdateItem.send(pid, RELIABLE_ORDERED);
});

addEventHandler("onItemEquip", function(playerid, instance, slot){
});

addEventHandler("onItemUnequip", function(playerid, instance, slot){
});

InventoryAskForItemsMessage.bind(function(pid, message){
	local inventoryListItems = InventoryListItemsMessage(pid,
		Players[pid].inventory.listItems()
		).serialize();
	inventoryListItems.send(pid, RELIABLE_ORDERED);
});

addEventHandler("onGiveItem", function(pid, instance, amount){
	local inventoryGiveItem = InventoryGiveItemMessage(pid,
		instance,
		amount
		).serialize();
	inventoryGiveItem.send(pid, RELIABLE_ORDERED);
});

addEventHandler("onRemoveItem", function(pid, instance, amount){
	local inventoryRemoveItem = InventoryRemoveItemMessage(pid,
		instance,
		amount
		).serialize();
	inventoryRemoveItem.send(pid, RELIABLE_ORDERED);
});

InventoryUseItemMessage.bind(function(pid, message){
	local _instance = itemDatabase[message.itemId].instance;
	if(itemDatabase[message.itemId].wear != -1){
		if(Players[pid].isItemEquipped(_instance)){
			Players[pid].unequipItem(_instance);
		} else {
			Players[pid].equipItem(_instance);
		}
	} else {
		Players[pid].useItem(_instance);
	}
});