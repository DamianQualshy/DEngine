local connection;

class MySQL {
	static function connect(host, username, password, database, port) {
		return mysql_connect(host, username, password, database, port);
	}

	static function close(connection) {
		mysql_close(connection);
	}

	static function selectDatabase(database) {
		mysql_select_db(connection, database);
	}

	static function query(query) {
		return mysql_query(connection, query);
	}

	static function escapeString(unescaped_string) {
		return mysql_real_escape_string(connection, unescaped_string);
	}

	static function affectedRows(result) {
		return mysql_affected_rows(result);
	}

	static function numFields(result) {
		return mysql_num_fields(result);
	}

	static function numRows(result) {
		return mysql_num_rows(result);
	}

	static function fetchAssoc(result) {
		return mysql_fetch_assoc(result);
	}

	static function fetchRow(result) {
		return mysql_fetch_row(result);
	}

	static function freeResult(result) {
		mysql_free_result(result);
	}

	static function insertId(connection) {
		return mysql_insert_id(connection);
	}

	static function errorCode(connection) {
		return mysql_errno(connection);
	}

	static function errorMessage(connection) {
		return mysql_error(connection);
	}

	static function sqlState(connection) {
		return mysql_sqlstate(connection);
	}

	static function characterSetName(connection) {
		return mysql_character_set_name(connection);
	}

	static function characterSetInfo(connection) {
		return mysql_get_character_set_info(connection);
	}

	static function info(connection) {
		return mysql_info(connection);
	}

	static function stat(connection) {
		return mysql_stat(connection);
	}

	static function warningCount(connection) {
		return mysql_warning_count(connection);
	}

	static function ping(connection) {
		return mysql_ping(connection);
	}

	static function optionReconnect(reconnect = null) {
		if (reconnect != null) {
			mysql_option_reconnect(reconnect);
		} else {
			return mysql_option_reconnect();
		}
	}

	static function setCharacterSet(charset) {
		return mysql_set_character_set(connection, charset);
	}

	static function executeTransaction(queries) {
		mysql_query(connection, "SET AUTOCOMMIT=0");
		mysql_query(connection, "BEGIN");

		local success = true;

		foreach (query in queries) {
			if (!mysql_query(connection, query)) {
				success = false;
				break;
			}
		}

		if (success) {
			mysql_query(connection, "COMMIT");
		} else {
			mysql_query(connection, "ROLLBACK");
		}

		mysql_query(connection, "SET AUTOCOMMIT=1");

		return success;
	}

	function saveErrorMessage(){
		saveLog("mysql_log.txt", mysql_error(connection));
		saveLog("mysql_log.txt", mysql_errno(connection));
	}

	function initializeMySQLConnection() {
		connection = mysql_connect(database.host, database.user, database.pass, database.db, 3306);

		if (connection != null) {
			print("Connected to " + database.db);
			return connection;
		} else {
			print("Failed to connect to the MySQL database.");
			MySQL.saveErrorMessage();
			return null;
		}
	}

	function closeMySQLConnection() {
		mysql_close(connection);
	}


	static function insert(tableName, tableArg) {
		if (!tableName || typeof(tableArg) != "table") {
			print("Error: Missing or invalid argument on function: insert");
			return false;
		}

		if (connection != null) {
			local columnsAndValues = [];

			foreach (column, value in tableArg) {
				local escapedValue;
				if (typeof(value) == "string") {
					escapedValue = MySQL.escapeString(value);
				} else if (typeof(value) == "bool") {
					escapedValue = boolToInt(value);
				} else {
					escapedValue = value;
				}

				if (value != null) {
					columnsAndValues.append("`" + column + "` = '" + escapedValue + "'");
				} else {
					print("Error: Missing argument in SQL, on function insert");
					return false;
				}
			}

			local values = "";

			foreach (item in columnsAndValues) {
				if (values != "") {
					values += ", ";
				}
				values += item;
			}

			local query = format("INSERT INTO `%s` SET %s", tableName, values);

			local result = mysql_query(connection, query);
			if (result == null) {
				return true;
			} else {
				print("Failed to insert data into the table.");
				MySQL.saveErrorMessage();
			}
		} else {
			print("Failed to connect to the MySQL database.");
			MySQL.saveErrorMessage();
		}

		return false;
	}

	static function update(tableName, column, columnValue, updateValues) {
		if (!tableName || !column || columnValue == null || typeof(updateValues) != "table") {
			print("Error: Missing argument on function: update");
			return false;
		}

		if (connection != null) {
			local updates = [];

			foreach (columnName, newValue in updateValues) {
				local escapedValue;
				if (typeof(newValue) == "string") {
					escapedValue = MySQL.escapeString(newValue);
				} else if (typeof(newValue) == "bool") {
					escapedValue = boolToInt(newValue);
				} else {
					escapedValue = newValue;
				}

				updates.push("`" + columnName + "` = '" + escapedValue + "'");
			}

			local updateString = "";

			foreach (item in updates) {
				if (updateString != "") {
					updateString += ", ";
				}
				updateString += item;
			}

			local query = format("UPDATE %s SET %s WHERE %s = '%s'", tableName, updateString, column, MySQL.escapeString(columnValue));

			local result = mysql_query(connection, query);
			if (result == null) {
				return true;
			} else {
				print("Failed to update data in the table.");
				MySQL.saveErrorMessage();
			}
		} else {
			print("Failed to connect to the MySQL database.");
			MySQL.saveErrorMessage();
		}

		return false;
	}

	static function updateAll(tableName, updateValues) {
		if (!tableName || typeof(updateValues) != "table") {
			print("Error: Missing or invalid argument on function: updateAll");
			return false;
		}

		if (connection != null) {
			local updates = [];

			foreach (columnName, newValue in updateValues) {
				local escapedValue;
				if (typeof(newValue) == "string") {
					escapedValue = MySQL.escapeString(newValue);
				} else if (typeof(newValue) == "bool") {
					escapedValue = boolToInt(newValue);
				} else {
					escapedValue = newValue;
				}

				updates.push("`" + columnName + "` = '" + escapedValue + "'");
			}

			local updateString = "";

			foreach (item in updates) {
				if (updateString != "") {
					updateString += ", ";
				}
				updateString += item;
			}

			local query = format("UPDATE %s SET %s", tableName, updateString);
			saveLog("gowno.txt", query);

			local result = mysql_query(connection, query);
			if (result == null) {
				saveLog("gowno.txt", mysql_query);
				return true;
			} else {
				print("Failed to update data in the table.");
				MySQL.saveErrorMessage();
			}
		} else {
			print("Failed to connect to the MySQL database.");
			MySQL.saveErrorMessage();
		}

		return false;
	}

	function isConnectedToDB(){
		if(connection != null){
			return true;
		} else return false;
	}
}


addEventHandler("onInit", function(){
	MySQL.initializeMySQLConnection();
});

addEventHandler("onExit", function(){
	local mySQLClose = setTimer(function(){
		MySQL.closeMySQLConnection();
	}, 5000, 1);
})