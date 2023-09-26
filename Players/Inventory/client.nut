addEventHandler("onPlayerUseItem", function(id, itemid, from, to){
	if(from == 0){
		local itemUse = ItemUseMessage(heroId,
			itemid
			).serialize();
		itemUse.send(RELIABLE_ORDERED);
	} else {
		return;
	}
});