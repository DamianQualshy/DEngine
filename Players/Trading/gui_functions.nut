local showcaseCollection = GUI.Collection({
	positionPx = {x = 0, y = 0}
});
local showcaseGUI = {
	showcase = GUI.Texture({
		positionPx = {x = nax(1940), y = nay(6200)},
		sizePx = {width = nax(4230), height = nay(1800)},
		file = "DLG_CONVERSATION.TGA",
		collection = showcaseCollection
	}),
		itemName = GUI.Button({
			positionPx = {x = nax(3300), y = nay(6250)},
			sizePx = {width = nax(1400), height = nay(300)},
			file = "INV_SLOT_FOCUS.TGA",
			draw = {text = "Name/Instance"},
			collection = showcaseCollection
		}),

		itemText = [
			GUI.Draw({
				positionPx = {x = nax(2050), y = nay(6650)},
				text = "",
				collection = showcaseCollection
			}),
			GUI.Draw({
				positionPx = {x = nax(2050), y = nay(6850)},
				text = "",
				collection = showcaseCollection
			}),
			GUI.Draw({
				positionPx = {x = nax(2050), y = nay(7050)},
				text = "",
				collection = showcaseCollection
			}),
			GUI.Draw({
				positionPx = {x = nax(2050), y = nay(7250)},
				text = "",
				collection = showcaseCollection
			}),
			GUI.Draw({
				positionPx = {x = nax(2050), y = nay(7450)},
				text = "",
				collection = showcaseCollection
			})
		],
		itemValue = [
			GUI.Draw({
				positionPx = {x = nax(6000), y = nay(6650)},
				text = "",
				collection = showcaseCollection
			}),
			GUI.Draw({
				positionPx = {x = nax(6000), y = nay(6850)},
				text = "",
				collection = showcaseCollection
			}),
			GUI.Draw({
				positionPx = {x = nax(6000), y = nay(7050)},
				text = "",
				collection = showcaseCollection
			}),
			GUI.Draw({
				positionPx = {x = nax(6000), y = nay(7250)},
				text = "",
				collection = showcaseCollection
			}),
			GUI.Draw({
				positionPx = {x = nax(6000), y = nay(7450)},
				text = "",
				collection = showcaseCollection
			})
		],

		itemDescription = GUI.Draw({
			positionPx = {x = nax(2050), y = nay(7600)},
			text = "",
			collection = showcaseCollection
		}),
		itemWorth = GUI.Draw({
			positionPx = {x = nax(2050), y = nay(7800)},
			text = "",
			collection = showcaseCollection
		}),

		itemRender = GUI.ItemRender({
			relativePositionPx = {x = nax(4850), y = nay(6570)},
			sizePx = {width = nax(810), height = nay(985)},
			instance = "",
			collection = showcaseCollection
		})
}

currItemID <- -1;

inventoryGUI <- -1;

tradeSelf <- -1
tradeOther <- -1;
tradeOffer <- -1;

addEventHandler("GUI.onMouseIn", function(self){
	//if(isGUIOpened(guiCheck.inventory) || isGUIOpened(guiCheck.trade)) return;

	if(self instanceof GUI.CellListVisibleCell){
		currItemID = self.getDataCell().getValue();

		showcaseCollection.setVisible(true);
		updateItemInfo();
	}
});

addEventHandler("GUI.onMouseOut", function(self){
	//if(isGUIOpened(guiCheck.inventory) || isGUIOpened(guiCheck.trade)) return;

	if(self instanceof GUI.CellListVisibleCell){
		showcaseCollection.setVisible(false);
	}
});

addEventHandler("GUI.onClick", function(self){
	//if(isGUIOpened(guiCheck.inventory) || isGUIOpened(guiCheck.trade)) return;

	switch(self){
		case showcaseGUI.itemName:
			local itemInfo = itemDatabase[currItemID];

			if(showcaseGUI.itemName.getText() == itemInfo.name){
				showcaseGUI.itemName.setText(itemInfo.instance);
			} else {
				showcaseGUI.itemName.setText(itemInfo.name);
			}
		break;
	}
});

addEventHandler("onRender", function(){
	if(isGUIOpened(guiCheck.inventory) || isGUIOpened(guiCheck.trade)) return;

	local item = showcaseGUI.itemRender;

	if(item.rotX > 360) item.rotX = 0;
		item.rotX += 1;
});

function updateItemInfo(){
	local itemInfo = itemDatabase[currItemID];
	showcaseGUI.itemName.setText(itemInfo.name);

	local itemText = showcaseGUI.itemText;
	local itemValue = showcaseGUI.itemValue;

	for(local i = 0, end = itemText.len(); i < end; i++){
		itemText[i].setText("");
		itemValue[i].setText("");
	}
	for(local i = 0, end = itemInfo.itemText.len(); i < end; i++){
		itemText[i].setText(itemInfo.itemText[i]);
		itemValue[i].setText(itemInfo.itemCount[i]);
	}

	showcaseGUI.itemDescription.setText(itemInfo.description);
	showcaseGUI.itemWorth.setText(format("Value in Gold: %d", itemInfo.value));

	showcaseGUI.itemRender.setInstance(itemInfo.instance);
	//showcaseGUI.itemRender.zbias = 108;
	showcaseGUI.itemRender.rotY = 224;
	showcaseGUI.itemRender.rotZ = 68;
	showcaseGUI.itemRender.top();
}

function refreshInventory(grid, items){
	switch(grid){
		case inventoryGUI.inventoryGrid:
			local grid = inventoryGUI.inventoryGrid;
			foreach(item in items){
				grid.insertCell(grid.cells.len(), {
					value = item.id,
					text = format("%d", item.amount),
					file = format("%s.TGA", item.instance)
				})
			}
			grid.sort(sortInventory);
		break;
		case tradeOther.inventoryOtherGrid:
			local grid = tradeOther.inventoryOtherGrid;
			foreach(item in items){
				grid.insertCell(grid.cells.len(), {
					value = item.id,
					text = format("%d", item.amount),
					file = format("%s.TGA", item.instance)
				})
			}
			grid.sort(sortInventory);
		break;
	}
}

function sortInventory(first, second){
	local firstType = itemDatabase[first.getValue()].flag;
	local secondType = itemDatabase[second.getValue()].flag;

	local firstValue = itemDatabase[first.getValue()].sFlag;
	local secondValue = itemDatabase[second.getValue()].sFlag;

	if(firstType == secondType){
		if(firstValue > secondValue)
			return 1;
		else if(firstValue < secondValue)
			return -1;
		else
			return 0;
	} else {
		if(firstType > secondType)
			return 1;
		else if(firstType < secondType)
			return -1;
		else
			return 0;
	}
}