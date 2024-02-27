JournalMessage_CreateTopic.bind(function(message){
	Daedalus.call("Log_CreateTopic", message.topicName, message.logSection);
	print(format("call create: %s %d", message.topicName, message.logSection));
});

JournalMessage_AddEntry.bind(function(message){
	Daedalus.call("Log_AddEntry", message.topicName, message.entry);
	print(format("call entry: %s %s", message.topicName, message.entry));
});

JournalMessage_SetTopicStatus.bind(function(message){
	Daedalus.call("Log_SetTopicStatus", message.topicName, message.status);
	print(format("call status: %s %d", message.topicName, message.status));
});