class HeroStatsMessage_Level extends BPacketMessage {
	</ type = BPacketInt32 />
	heroID = -1

	</ type = BPacketInt32 />
	level = -1
}

class HeroStatsMessage_EXP extends BPacketMessage {
	</ type = BPacketInt32 />
	heroID = -1

	</ type = BPacketInt32 />
	exp = -1
}

class HeroStatsMessage_LP extends BPacketMessage {
	</ type = BPacketInt32 />
	heroID = -1

	</ type = BPacketInt32 />
	learnPoints = -1
}

class HeroStatsMessage_Guild extends BPacketMessage {
	</ type = BPacketInt32 />
	heroID = -1

	</ type = BPacketInt32 />
	guildId = -1
}