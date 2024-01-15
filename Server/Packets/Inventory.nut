class InventoryGiveItemMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketString />
	instance = ""

	</ type = BPacketInt32 />
	amount = -1
}

class InventoryRemoveItemMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketString />
	instance = ""

	</ type = BPacketInt32 />
	amount = -1
}

class InventoryAskForItemsMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1
}

class InventoryListItemsMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketArray(BPacketTable({
		instance = BPacketString(),
		amount = BPacketInt32(),

		id = BPacketInt32()
	})) />
	itemsList = null
}

class InventoryUseItemMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketInt32 />
	itemId = -1
}

class InventoryUpdateItemMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketString />
	instance = ""

	</ type = BPacketInt32 />
	amount = -1
}