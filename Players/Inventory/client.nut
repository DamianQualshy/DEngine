local inventoryCollection = GUI.Collection({
	positionPx = {x = 0, y = 0}
});
inventoryGUI = {
	header = 0,

	inventoryGrid = GUI.CellList({
		positionPx = {x = nax(5770), y = nay(1400)},
		sizePx = {width = nax(2070), height = nay(4440)},
		cellWidthPx = 96,
		cellHeightPx = 96,
		spacingXPx = 1,
		spacingYPx = 1,
		scrollbarVisibilityMode = false,
		file = "DLG_CONVERSATION.TGA",
		collection = inventoryCollection
	}),
		category = GUI.Button({
			positionPx = {x = nax(6100), y = nay(1050)},
			sizePx = {width = nax(1400), height = nay(300)},
			file = "INV_SLOT_FOCUS.TGA",
			draw = {text = "(All)"},
			collection = inventoryCollection
		}),
		money = GUI.Draw({
			positionPx = {x = nax(6620), y = nay(5870)},
			text = "Gold: 000",
			collection = inventoryCollection
		})
}

local inventoryGrid = inventoryGUI.inventoryGrid;

function toggleInventory(toggle){
	if(!isGUIOpened(guiCheck.inventory) && !isPlayerBusy() && !chatInputIsOpen()){
		inventoryCollection.setVisible(toggle);

		setCursorVisible(toggle);
		setCursorPosition(4096, 4096);
		disableControls(toggle);
		Camera.movementEnabled = !toggle;

		if(toggle == true){
			local inventoryAskForItems = InventoryAskForItemsMessage(heroId).serialize();
			inventoryAskForItems.send(RELIABLE_ORDERED);
		}

		inventoryGUIvisible = toggle;
	}
}

InventoryListItemsMessage.bind(function(message){
	inventoryGrid.clear();
	refreshInventory(inventoryGrid, message.itemsList);
});

InventoryUpdateItemMessage.bind(function(message){
	local _cell = inventoryGrid.findCell(getItemIndex(message.instance));
	if(_cell != null){
		if(message.amount == 0){
			inventoryGrid.removeCell(_cell.id);
		} else {
			_cell.setText(format("%d", message.amount));
		}
	}
	inventoryGrid.sort(sortInventory);
});

InventoryGiveItemMessage.bind(function(message){
	local _cell = inventoryGrid.findCell(getItemIndex(message.instance));
	if(_cell != null){
		_cell.setText(format("%d", _cell.getText().tointeger() + message.amount));
	} else {
		inventoryGrid.insertCell(inventoryGrid.cells.len(), {
			value = getItemIndex(message.instance),
			text = format("%d", message.amount),
			file = format("%s.TGA", message.instance)
		});
	}
	inventoryGrid.sort(sortInventory);
});

InventoryRemoveItemMessage.bind(function(message){
	local _cell = inventoryGrid.findCell(getItemIndex(message.instance));
	if(_cell != null){
		if(_cell.getText().tointeger() <= message.amount){
			inventoryGrid.removeCell(_cell.id);
		} else {
			_cell.setText(format("%d", _cell.getText().tointeger() + message.amount));
		}
	}
	inventoryGrid.sort(sortInventory);
});

addEventHandler("onKeyDown", function(key){
	switch(key){
		case KEY_TAB:
			toggleInventory(!inventoryGUIvisible);
		break;
	}
});

addEventHandler("GUI.onClick", function(self){
	if(isGUIOpened(guiCheck.inventory)) return;

	switch(self){
		case inventoryGUI.category:
			//
		break;
	}

	if(self instanceof GUI.CellListVisibleCell){
		local inventoryUseItem = InventoryUseItemMessage(heroId,
			currItemID
			).serialize();
		inventoryUseItem.send(RELIABLE_ORDERED);
	}
});