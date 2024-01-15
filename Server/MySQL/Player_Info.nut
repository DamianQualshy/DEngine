addEventHandler("onPlayerSendsMessage", function(pid){
	local result = MySQL.query("SELECT * FROM Player_Info WHERE Player_ID = '" + Players[pid].getDatabaseID() + "'");
	local row = MySQL.fetchAssoc(result);
		MySQL.freeResult(result);

	if(row != null){
		MySQL.updateAll("Player_Info", {
			Messages_Sent = row.Messages_Sent + 1
		});
	} else {
		MySQL.insert("Player_Info", {
			Player_ID = Players[pid].getDatabaseID(),
			Messages_Sent = 1
		});
	}
});

addEventHandler("onPlayerSendsCommand", function(pid, cmd){

});