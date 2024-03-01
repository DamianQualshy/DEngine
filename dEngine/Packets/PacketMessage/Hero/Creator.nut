class HeroCreatorMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketString />
	visBodyM = ""

	</ type = BPacketInt32 />
	visBodyT = -1

	</ type = BPacketString />
	visHeadM = ""

	</ type = BPacketInt32 />
	visHeadT = -1

	</ type = BPacketString />
	walk = ""

	</ type = BPacketFloat />
	height = -1

	</ type = BPacketFloat />
	fatness = -1
}

class HeroHeightMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketFloat />
	height = -1
}