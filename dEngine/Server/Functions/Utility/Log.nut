function saveLog(file, params){
	local myfile = file(file, "ab+");
	if(myfile != null){
			local datas = format("%02d/%02d/%04d", date().day, date().month + 1, date().year) + " " + format("%02d:%02d:%02d", date().hour, date().min, date().sec) + " " + format("%02d:%02d", getTime().hour, getTime().min);
		myfile.write(format("(%s) || %s", datas, params) + " \n");
		myfile.close();
	}
	else
		print("Failed to open the file.");
}