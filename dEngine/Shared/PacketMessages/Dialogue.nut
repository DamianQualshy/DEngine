class DialogueMessage_Output extends BPacketMessage {
	</ type = BPacketInt32 />
	heroID = -1

	</ type = BPacketInt32 />
	npcID = -1

	</ type = BPacketString />
	dialogue = ""
}


class DialogueChoiceMessage extends BPacketMessage {
	</ type = BPacketString />
	dialogId = ""

	</ type = BPacketString />
	choiceId = ""
}

class DialogueInitMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	npcID = -1
}

class DialogueExitMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	npcID = -1
}