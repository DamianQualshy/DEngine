class ExcavationCheckMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1
}

class ExcavationResultMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketInt32 />
	stamina = -1
}

class ExcavationOreMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1
}

class ExcavationMiningMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketInt32 />
	stamina = -1

	</ type = BPacketInt32 />
	ore_amount = -1

	</ type = BPacketInt32 />
	mine_exp = -1
}

class ExcavationFinishedMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1
}