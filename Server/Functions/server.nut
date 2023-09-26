function getDistanceBetweenPlayers(centre_id, distance_id){
	local center = Players[centre_id].getPosition();
	local distance = Players[distance_id].getPosition();

	if(Players[distance_id].getWorld() == Players[centre_id].getWorld()){
		return getDistance3d(center.x, center.y, center.z, distance.x, distance.y, distance.z);
	} else return false;
}

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