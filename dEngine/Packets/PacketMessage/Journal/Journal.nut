class JournalMessage_CreateTopic extends BPacketMessage {
	</ type = BPacketInt32 />
	heroID = -1

	</ type = BPacketString />
	topicName = ""

	</ type = BPacketInt32 />
	logSection = -1
}

class JournalMessage_AddEntry extends BPacketMessage {
	</ type = BPacketInt32 />
	heroID = -1

	</ type = BPacketString />
	topicName = ""

	</ type = BPacketString />
	entry = ""
}

class JournalMessage_LogEntry extends BPacketMessage {
	</ type = BPacketInt32 />
	heroID = -1

	</ type = BPacketString />
	topicName = ""

	</ type = BPacketString />
	entry = ""
}

class JournalMessage_SetTopicStatus extends BPacketMessage {
	</ type = BPacketInt32 />
	heroID = -1

	</ type = BPacketString />
	topicName = ""

	</ type = BPacketInt32 />
	status = -1
}