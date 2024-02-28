JournalMessage_CreateTopic.bind(function(message){
	Daedalus.call("Log_CreateTopic", message.topicName, message.logSection);
});

JournalMessage_AddEntry.bind(function(message){
	Daedalus.call("Log_AddEntry", message.topicName, message.entry);
});

JournalMessage_LogEntry.bind(function(message){
	Daedalus.call("B_LogEntry", message.topicName, message.entry);
});

JournalMessage_SetTopicStatus.bind(function(message){
	Daedalus.call("Log_SetTopicStatus", message.topicName, message.status);
});