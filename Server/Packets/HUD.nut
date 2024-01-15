class FocusHealthMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketInt32 />
	focusId = -1

	</ type = BPacketInt32 />
	health = -1

	</ type = BPacketInt32 />
	max_health = -1
}

class CollectFocusMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketInt32 />
	focusId = -1
}

class FocusHitMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketInt32 />
	focusId = -1

	</ type = BPacketInt32 />
	damage = -1
}