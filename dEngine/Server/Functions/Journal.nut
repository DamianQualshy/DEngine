function Log_CreateTopic(pid, topicName, logSection){
	local createTopic = JournalMessage_CreateTopic(pid,
		topicName,
		logSection
		).serialize();
	createTopic.send(pid, RELIABLE);
}

function Log_AddEntry(pid, topicName, entry){
	local addEntry = JournalMessage_AddEntry(pid,
		topicName,
		entry
		).serialize();
	addEntry.send(pid, RELIABLE);
}

function Log_SetTopicStatus(pid, topicName, status){
	local setTopicStatus = JournalMessage_SetTopicStatus(pid,
		topicName,
		status
		).serialize();
	setTopicStatus.send(pid, RELIABLE);
}

function B_LogEntry(pid, topicName, entry){
	local logEntry = JournalMessage_LogEntry(pid,
		topicName,
		entry
		).serialize();
	logEntry.send(pid, RELIABLE);
}