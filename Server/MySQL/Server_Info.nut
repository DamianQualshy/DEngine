addEventHandler("onInit", function(){
	local result = MySQL.query("SELECT * FROM Server_Info");
	local row = MySQL.fetchAssoc(result);
		MySQL.freeResult(result);

	if(row != null){
		MySQL.updateAll("Server_Info", {
			Last_Restart = format("%04d-%02d-%02d %02d:%02d:%02d", date().year, date().month + 1, date().day, date().hour, date().min, date().sec)
		});
		if(SERVER_NAME == "Gothic Role-Play") SERVER_NAME = row.Server_Name;
	} else {
		MySQL.insert("Server_Info", {
			Server_Name = getHostname(),
			First_Launch = format("%04d-%02d-%02d %02d:%02d:%02d", date().year, date().month + 1, date().day, date().hour, date().min, date().sec)
		});
	}
});

addEventHandler("onExit", function(){
	local result = MySQL.query("SELECT * FROM Server_Info");
	local row = MySQL.fetchAssoc(result);
		MySQL.freeResult(result);

	if(row != null){
		MySQL.updateAll("Server_Info", {
			Server_Name = SERVER_NAME
		});
	}
});

addEventHandler("onPlayerLogin", function(pid){
	local totalPlayers = getTotalPlayers();

	local result = MySQL.query("SELECT * FROM Server_Info");
	local row = MySQL.fetchAssoc(result);
		MySQL.freeResult(result);

	if(row.Online_Top == null){
		MySQL.insert("Server_Info", {
			Online_Top = 1
		});
	} else {
		if(row.Online_Top < totalPlayers){
			MySQL.updateAll("Server_Info", {
				Online_Top = totalPlayers
			});
		}
	}
});

addEventHandler("onPlayerRegister", function(pid){
	local result = MySQL.query("SELECT * FROM Server_Info");
	local row = MySQL.fetchAssoc(result);
		MySQL.freeResult(result);

	if(row.Registered_Total == null){
		MySQL.insert("Server_Info", {
			Registered_Total = 1
		});
	} else {
		MySQL.updateAll("Server_Info", {
			Registered_Total = row.Registered_Total + 1
		});
	}
});