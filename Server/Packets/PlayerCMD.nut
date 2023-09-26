class PlayerAFKMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketBool />
	state = false
}

class PlayerRestMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketBool />
	state = false

	</ type = BPacketString />
	ani = ""
}
class PlayerRestStopMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1
}