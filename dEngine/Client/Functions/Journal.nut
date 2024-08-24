JournalMessage_CreateTopic.bind(function(message){
	Daedalus.call("Log_CreateTopic", message.topicName, message.logSection);
	Player[heroId].logCreateTopic(message.topicName, message.logSection);
});

JournalMessage_AddEntry.bind(function(message){
	Daedalus.call("Log_AddEntry", message.topicName, message.entry);
	Player[heroId].logAddEntry(message.topicName, message.entry);
});

JournalMessage_SetTopicStatus.bind(function(message){
	Daedalus.call("Log_SetTopicStatus", message.topicName, message.status);
	Player[heroId].logSetTopicStatus(message.topicName, message.status);
});

JournalMessage_LogEntry.bind(function(message){
	Daedalus.call("B_LogEntry", message.topicName, message.entry);
	Player[heroId].logEntry(message.topicName, message.entry);
});