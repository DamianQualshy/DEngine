function saveLog(file, params){
	local myfile = io.file("database/logs/" + file, "a+");
	if(myfile.isOpen){
			local datas = format("%02d/%02d/%04d", date().day, date().month + 1, date().year) + " " + format("%02d:%02d:%02d", date().hour, date().min, date().sec) + " " + format("%02d:%02d", getTime().hour, getTime().min);
		myfile.write(datas + " || " + params + " \n");
		myfile.close();
	}
	else
		print(myfile.errorMsg)
}

/* LogMessage.bind(function(pid, message){
	saveLog(format("%s.txt", message.fileLog), message.printLog);
});

PrintMessage.bind(function(pid, message){
	print(message.printLog);
}); */