class PlayerLoginMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketString />
	login = ""

	</ type = BPacketString />
	password = ""
}

class PlayerRegisterMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1
}

class PlayerLoginFailMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1
}

class PlayerLoginSuccessMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1
}