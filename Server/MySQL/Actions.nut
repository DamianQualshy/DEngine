local actionTimer;
local actionInterval = 10000; //10 seconds
local actionTimestampLast;
local actionsTable;

addEventHandler("onInit", function(){
	actionTimer = setTimer(function(){
		actionTimestampLast = format("%04d-%02d-%02d %02d:%02d:%02d", date().year, date().month + 1, date().day, date().hour, date().min, date().sec);
		actionsTable = MySQL.query("SELECT * FROM Actions WHERE Timestamp > '" + actionTimestampLast + "' ORDER BY Timestamp");
			if(actionsTable != null){
				local result_actions = [];
				for(local i = 0, end = MySQL.numRows(actionsTable); i < end; i++){
					result_actions.append(MySQL.fetchAssoc(actionsTable));
				}

				MySQL.freeResult(actionsTable);
				MySQL.query("TRUNCATE Actions");

				foreach(action in result_actions){
					local tableName = action.Action_Type;
					local actionDescription = action.Action_Data;

					local parts = split(actionDescription, ";");

						local columnName = strip(parts[0]);
						local changeDescription = strip(parts[1]);

						local _id = -1;
						local oldValue = -1;
						local newValue = -1;

						if(changeDescription.find("|")){
							local changeDetails = split(changeDescription, "|");

							_id = strip(changeDetails[0]);
							local changedValues = strip(changeDetails[1]);

							local values = split(changedValues, ">");

							oldValue = values[0];
							newValue = values[1];
						} else {
							local changeDetails = split(changeDescription, ">");

							oldValue = changeDetails[0];
							newValue = changeDetails[1];
						}

						acknowledgeMySQLChange(tableName, columnName, _id, oldValue, newValue);
				}
			}
	}, actionInterval, 0);
});

addEventHandler("onExit", function(){
	killTimer(actionTimer);
});

function acknowledgeMySQLChange(tableName, columnName, _id, oldValue, newValue){
	if(newValue == oldValue) return;

	local pid = -1;
	if(_id != -1){
		for(local i = 0, end = getMaxSlots(); i < end; ++i){
			if(!Players.rawin(i)) continue;
			if(!Players[i].isLogged()) continue;

			if(Players[i].getDatabaseID() == _id.tointeger()){
				pid = i;
				break;
			}
		}
	}

	switch(tableName){
		case "Server_Info":
			switch(columnName){
				case "Server_Name":
					SERVER_NAME = newValue;
				break;
				case "Game_Time":
					local gameTime = newValue;
					local dateAndTime = split(gameTime, " ");

					local dateComponents = split(dateAndTime[0], "-");
					local timeComponents = split(dateAndTime[1], ":");

					Calendar.year = dateComponents[0].tointeger();
					Calendar.month = dateComponents[1].tointeger();
					Calendar.day = dateComponents[2].tointeger();

					Calendar.hour = timeComponents[0].tointeger();
					Calendar.minute = timeComponents[1].tointeger();
				break;
			}
		break;

		case "Server_Config":
			switch(columnName){
				case "Whitelist":

				break;
				case "PvP":

				break;
				case "Drop_Items":

				break;
			}
		break;

		case "Players":
			if(!Players.rawin(pid)) break;
			switch(columnName){
				case "Perms":
					Players[pid].setPermissions(newValue);
				break;
				case "Color":
					Players[pid].setColorHex(newValue);
				break;
				case "Whitelist":
					Players[pid].setWhitelist(newValue);
				break;
			}
		break;

		case "Player_Hero":
			if(!Players.rawin(pid)) break;
			switch(columnName){
				case "Name":
					Players[pid].setName(newValue);
				break;
				case "Description":
					Players[pid].setDescription(newValue);
				break;
				case "Level":
					Players[pid].setLevel(newValue);
				break;
				case "Experience":
					Players[pid].setExperience(newValue);
				break;
				case "Learn_Points":
					Players[pid].setLearnPoints(newValue);
				break;
				case "Health":
					Players[pid].setHealth(newValue);
				break;
				case "Health_Max":
					Players[pid].setMaxHealth(newValue);
				break;
				case "Mana":
					Players[pid].setMana(newValue);
				break;
				case "Mana_Max":
					Players[pid].setMaxMana(newValue);
				break;
				case "Strength":
					Players[pid].setStrength(newValue);
				break;
				case "Dexterity":
					Players[pid].setDexterity(newValue);
				break;
				case "Skill_OneHand":
					Players[pid].setOneHandSkill(newValue);
				break;
				case "Skill_TwoHand":
					Players[pid].setTwoHandSkill(newValue);
				break;
				case "Skill_Bow":
					Players[pid].setBowSkill(newValue);
				break;
				case "Skill_Crossbow":
					Players[pid].setCrossbowSkill(newValue);
				break;
				case "Magic_Circle":
					Players[pid].setMagicCircle(newValue);
				break;
				case "Talent_Sneak":
					Players[pid].setSneakSkill(newValue);
				break;
				case "Talent_Picklock":
					Players[pid].setPicklockSkill(newValue);
				break;
				case "Talent_Pickpocket":
					Players[pid].setPickpocketSkill(newValue);
				break;
				case "Talent_Runemaking":
					Players[pid].setRuneSkill(newValue);
				break;
				case "Talent_Alchemy":
					Players[pid].setAlchemySkill(newValue);
				break;
				case "Talent_Smith":
					Players[pid].setSmithSkill(newValue);
				break;
				case "Talent_Trophy":
					Players[pid].setTrophySkill(newValue);
				break;
				case "Talent_Acrobatic":
					Players[pid].setAcrobaticSkill(newValue);
				break;
				case "Profession_Level":
					Players[pid].setProfessionLevel(newValue);
				break;
				case "Profession_Exp":
					Players[pid].setProfessionExp(newValue);
				break;
				case "Skill_Mining":
					Players[pid].setMiningSkill(newValue);
				break;
				case "Skill_Hunting":
					Players[pid].setHuntingSkill(newValue);
				break;
				case "Skill_Herbalism":
					Players[pid].setHerbalismSkill(newValue);
				break;
				case "Stamina":
					Players[pid].setStamina(newValue);
				break;
				case "Walk_Style":
					Players[pid].setWalkstyle(newValue);
				break;
				case "Invisible":
					Players[pid].setInvisibility(newValue);
				break;
			}
		break;
	}
	callEvent("onMySQLAction", tableName, columnName, _id, oldValue, newValue);
}

addEventHandler("onMySQLAction", function(tableName, columnName, _id, oldValue, newValue){
	print(tableName + " " + columnName + " " + _id + " " + oldValue + " -> " + newValue);
});