LogMessage.bind(function(pid, message){
	saveLog(format("client/%s.txt", message.fileLog), message.printLog);
	print(message.printLog);
});

PrintMessage.bind(function(pid, message){
	print(message.printLog);
});