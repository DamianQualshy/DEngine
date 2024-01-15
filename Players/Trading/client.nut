local tradeCollection = GUI.Collection({
	positionPx = {x = 0, y = 0}
});

tradeSelf = {
	header = 0,

	inventorySelfGrid = GUI.CellList({
		positionPx = {x = nax(5770), y = nay(1400)},
		sizePx = {width = nax(2070), height = nay(4440)},
		cellWidthPx = 96,
		cellHeightPx = 96,
		spacingXPx = 0,
		spacingYPx = 0,
		scrollbarVisibilityMode = false,
		file = "DLG_CONVERSATION.TGA",
		collection = tradeCollection
	}),
		category = GUI.Button({
			positionPx = {x = nax(6100), y = nay(1050)}
			sizePx = {width = nax(1400), height = nay(300)}
			file = "INV_SLOT_FOCUS.TGA"
			draw = {text = "(All)"}
			collection = tradeCollection
		}),
		money = GUI.Draw({
			positionPx = {x = nax(6620), y = nay(5870)}
			text = "Gold: 000"
			collection = tradeCollection
		})
}

tradeOther = {
	header = 0,

	inventoryOtherGrid = GUI.CellList({
		positionPx = {x = nax(350), y = nay(1400)},
		sizePx = {width = nax(2070), height = nay(4440)},
		cellWidthPx = 96,
		cellHeightPx = 96,
		spacingXPx = 0,
		spacingYPx = 0,
		scrollbarVisibilityMode = false,
		file = "DLG_CONVERSATION.TGA",
		collection = tradeCollection
	}),
		category = GUI.Button({
			positionPx = {x = nax(692), y = nay(1050)}
			sizePx = {width = nax(1400), height = nay(300)}
			file = "INV_SLOT_FOCUS.TGA"
			draw = {text = "(All)"}
			collection = tradeCollection
		}),
		money = GUI.Draw({
			positionPx = {x = nax(1212), y = nay(5870)}
			text = "Gold: 000"
			collection = tradeCollection
		})
}

tradeOffer = {
	selfMoney = 0,
	selfGrid = GUI.GridList({
		positionPx = {x = nax(3810), y = nay(500)}
		sizePx = {width = nax(100), height = nay(500)}
		marginPx = {top = nax(100), left = nay(50)}
		file = ""
		scrollbarVisibilityMode = false
		collection = tradeCollection
	}),

	otherMoney = 0,
	otherGrid = GUI.GridList({
		positionPx = {x = nax(3780), y = nay(500)}
		sizePx = {width = nax(100), height = nay(500)}
		marginPx = {top = nax(100), left = nay(50)}
		file = ""
		scrollbarVisibilityMode = false
		collection = tradeCollection
	}),
}

local gridSelf = tradeSelf.inventorySelfGrid;
local gridOther = tradeOther.inventoryOtherGrid;

local offerSelf = tradeOffer.selfGrid;
local offerOther = tradeOffer.otherGrid;

function toggleTradeWindow(toggle){
	if(!isGUIOpened(guiCheck.trade) && !isPlayerBusy() && !chatInputIsOpen()){
		tradeCollection.setVisible(toggle);

		setCursorVisible(toggle);
		setCursorPosition(4096, 4096);
		disableControls(toggle);
		Camera.movementEnabled = !toggle;

		if(toggle == true){
			//local inventoryAskForItems = InventoryAskForItemsMessage(heroId).serialize();
			//inventoryAskForItems.send(RELIABLE_ORDERED);
			showOffer();
		}

		tradeGUIvisible = toggle;
	}
}

local columnSelf = offerSelf.addColumn({
		widthPx = nax(100)
		align = Align.Center
	});
local columnOther = offerOther.addColumn({
		widthPx = nax(100)
		align = Align.Center
	});

function showOffer(){
	offerSelf.clear();
	offerOther.clear();

		for(local i = 0, end = 5; i < end; i++){
			local rowS = offerSelf.addRow({
				value = -1,
				text = "",
				file = "DEFAULT.TGA"
			});
			rowS.cells[columnSelf].setDrawColor(145, 175, 205);

			local rowO = offerOther.addRow({
				value = -1,
				text = "",
				file = "DEFAULT.TGA"
			});
			rowO.cells[columnOther].setDrawColor(145, 175, 205);
		}
}

InventoryListItemsMessage.bind(function(message){
	gridOther.clear();
	refreshInventory(gridOther, message.itemsList);
});

InventoryUpdateItemMessage.bind(function(message){
	local _cell = gridOther.findCell(getItemIndex(message.instance));
	if(_cell != null){
		if(message.amount == 0){
			gridOther.removeCell(_cell.id);
		} else {
			_cell.setText(format("%d", message.amount));
		}
	}
	gridOther.sort(sortInventory);
});

InventoryGiveItemMessage.bind(function(message){
	local _cell = gridOther.findCell(getItemIndex(message.instance));
	if(_cell != null){
		_cell.setText(format("%d", _cell.getText().tointeger() + message.amount));
	} else {
		gridOther.insertCell(gridOther.cells.len(), {
			value = getItemIndex(message.instance),
			text = format("%d", message.amount),
			file = format("%s.TGA", message.instance)
		});
	}
	gridOther.sort(sortInventory);
});

InventoryRemoveItemMessage.bind(function(message){
	local _cell = gridOther.findCell(getItemIndex(message.instance));
	if(_cell != null){
		if(_cell.getText().tointeger() <= message.amount){
			gridOther.removeCell(_cell.id);
		} else {
			_cell.setText(format("%d", _cell.getText().tointeger() + message.amount));
		}
	}
	gridOther.sort(sortInventory);
});

addEventHandler("onKeyDown", function(key){
	switch(key){
		case KEY_O:
			toggleTradeWindow(!tradeGUIvisible);
		break;
	}
});

/* addEventHandler("GUI.onClick", function(self){
	if(isGUIOpened(guiCheck.trade)) return;

	if(self instanceof GUI.CellListVisibleCell){
		local inventoryUseItem = InventoryUseItemMessage(heroId,
			currItemID
			).serialize();
		inventoryUseItem.send(RELIABLE_ORDERED);
	}
}); */