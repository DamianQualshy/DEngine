function saveLog(file, params){
	local printLog = LogMessage(heroId,
		file,
		params
		).serialize();
	printLog.send(RELIABLE_ORDERED);
}

function printLog(params){
	local printLog = PrintMessage(heroId,
		params
		).serialize();
	printLog.send(RELIABLE_ORDERED);
}