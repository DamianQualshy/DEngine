class LogMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketString />
	fileLog = ""

	</ type = BPacketString />
	printLog = ""
}

class PrintMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketString />
	printLog = ""
}
