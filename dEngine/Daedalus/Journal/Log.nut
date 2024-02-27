function Log_CreateTopic(pid, topicName, logSection){
	local createTopic = JournalMessage_CreateTopic(pid,
		topicName,
		logSection
		).serialize();
	createTopic.send(pid, RELIABLE_ORDERED);
}

function Log_AddEntry(pid, topicName, entry){
	local addEntry = JournalMessage_AddEntry(pid,
		topicName,
		entry
		).serialize();
	addEntry.send(pid, RELIABLE_ORDERED);
}

function Log_SetTopicStatus(pid, topicName, status){
	local setTopicStatus = JournalMessage_SetTopicStatus(pid,
		topicName,
		status
		).serialize();
	setTopicStatus.send(pid, RELIABLE_ORDERED);
}