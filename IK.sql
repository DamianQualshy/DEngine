DROP DATABASE IF EXISTS `immersivekhorinis`;
CREATE DATABASE `immersivekhorinis` CHARACTER SET cp1250 COLLATE cp1250_bin;

CREATE TABLE `Server_Info` (
	`Server_Name` VARCHAR(64) NOT NULL DEFAULT '',
	`First_Launch` DATETIME NOT NULL,
	`Last_Restart` DATETIME NOT NULL,
	`Game_Time` DATETIME NOT NULL,
	`Registered_Total` INT unsigned NOT NULL DEFAULT '0',
	`Online_Top` INT unsigned NOT NULL DEFAULT '0'
);

CREATE TABLE `Server_Config` (
	`Whitelist` BOOLEAN NOT NULL DEFAULT '0',
	`PvP` BOOLEAN NOT NULL DEFAULT '0',
	`Drop_Items` BOOLEAN NOT NULL DEFAULT '0'
);

CREATE TABLE `Actions` (
	`ID` INT unsigned NOT NULL AUTO_INCREMENT,
	`Action_Type` VARCHAR(255) NOT NULL,
	`Action_Data` TEXT NOT NULL,
	`Timestamp` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

	PRIMARY KEY (`ID`)
);

CREATE TABLE `Chunks` (
	`Chunk_ID` INT unsigned NOT NULL AUTO_INCREMENT,
	`Name` VARCHAR(10) NOT NULL DEFAULT '',
	`Type` INT unsigned NOT NULL DEFAULT '0',
	`World` VARCHAR(64) NOT NULL DEFAULT 'NEWWORLD\\NEWWORLD.ZEN',
	`X` INT NOT NULL DEFAULT '0',
	`Z` INT NOT NULL DEFAULT '0',
	`Size` INT unsigned NOT NULL DEFAULT '0',

	PRIMARY KEY (`Chunk_ID`)
);

CREATE TABLE `Players` (
	`ID` INT unsigned NOT NULL AUTO_INCREMENT,
	`Login` VARCHAR(32) NOT NULL DEFAULT '',
	`Password` VARCHAR(64) NOT NULL DEFAULT '',

	`Serial` VARCHAR(64) NOT NULL DEFAULT '',

	`First_Login` DATETIME NOT NULL,
	`Last_Login` DATETIME NOT NULL,

	`First_Serial` VARCHAR(64) NOT NULL DEFAULT '',

	`Perms` TINYINT unsigned NOT NULL DEFAULT '0',
	`Color` VARCHAR(6) NOT NULL DEFAULT 'FFFFFF',

	`Whitelist` BOOLEAN NOT NULL DEFAULT '0',

	PRIMARY KEY (`ID`)
);

CREATE TABLE `Player_Hero` (
	`Player_ID` INT unsigned NOT NULL,
	`Name` VARCHAR(32) NOT NULL DEFAULT '',
	`Description` VARCHAR(64) NOT NULL DEFAULT '',

	`Instance` VARCHAR(32) NOT NULL DEFAULT 'PC_HERO',

	`Class_ID` TINYINT unsigned NOT NULL DEFAULT '0',

	`Level` INT unsigned NOT NULL DEFAULT '1',
	`Experience` INT unsigned NOT NULL DEFAULT '0',
	`Learn_Points` INT unsigned NOT NULL DEFAULT '0',
	`Guild` VARCHAR(64) NOT NULL DEFAULT '',

	`Health` INT unsigned NOT NULL DEFAULT '50',
	`Health_Max` INT unsigned NOT NULL DEFAULT '50',
	`Mana` INT unsigned NOT NULL DEFAULT '10',
	`Mana_Max` INT unsigned NOT NULL DEFAULT '10',
	`Strength` INT unsigned NOT NULL DEFAULT '10',
	`Dexterity` INT unsigned NOT NULL DEFAULT '10',

	`Skill_OneHand` TINYINT unsigned NOT NULL DEFAULT '10',
	`Skill_TwoHand` TINYINT unsigned NOT NULL DEFAULT '10',
	`Skill_Bow` TINYINT unsigned NOT NULL DEFAULT '10',
	`Skill_Crossbow` TINYINT unsigned NOT NULL DEFAULT '10',

	`Magic_Circle` TINYINT unsigned NOT NULL DEFAULT '0',
	`Talent_Sneak` TINYINT unsigned NOT NULL DEFAULT '0',
	`Talent_Picklock` TINYINT unsigned NOT NULL DEFAULT '0',
	`Talent_Pickpocket` TINYINT unsigned NOT NULL DEFAULT '0',
	`Talent_Runemaking` TINYINT unsigned NOT NULL DEFAULT '0',
	`Talent_Alchemy` TINYINT unsigned NOT NULL DEFAULT '0',
	`Talent_Smith` TINYINT unsigned NOT NULL DEFAULT '0',
	`Talent_Trophy` TINYINT unsigned NOT NULL DEFAULT '0',
	`Talent_Acrobatic` TINYINT unsigned NOT NULL DEFAULT '0',

	`Profession` VARCHAR(32) NOT NULL DEFAULT '',
	`Profession_Level` INT unsigned NOT NULL DEFAULT '0',
	`Profession_Exp` INT unsigned NOT NULL DEFAULT '0',

	`Skill_Mining` INT unsigned NOT NULL DEFAULT '0',
	`Skill_Hunting` INT unsigned NOT NULL DEFAULT '0',
	`Skill_Herbalism` INT unsigned NOT NULL DEFAULT '0',

	`Stamina` TINYINT unsigned NOT NULL DEFAULT '100',

	`Visual_BodyModel` VARCHAR(32) NOT NULL DEFAULT 'HUM_BODY_NAKED0',
	`Visual_BodyTexture` INT unsigned NOT NULL DEFAULT '8',
	`Visual_HeadModel` VARCHAR(32) NOT NULL DEFAULT 'HUM_HEAD_PONY',
	`Visual_HeadTexture` INT unsigned NOT NULL DEFAULT '18',
	`Visual_Scale_X` FLOAT NOT NULL DEFAULT '1.0',
	`Visual_Scale_Y` FLOAT NOT NULL DEFAULT '1.0',
	`Visual_Scale_Z` FLOAT NOT NULL DEFAULT '1.0',
	`Visual_Fatness` FLOAT NOT NULL DEFAULT '1.0',
	`Walk_Style` VARCHAR(64) NOT NULL DEFAULT 'HUMANS.MDS',

	`Position_X` FLOAT NOT NULL DEFAULT '0.0',
	`Position_Y` FLOAT NOT NULL DEFAULT '0.0',
	`Position_Z` FLOAT NOT NULL DEFAULT '0.0',
	`Position_A` FLOAT NOT NULL DEFAULT '0.0',
	`World` VARCHAR(64) NOT NULL DEFAULT 'NEWWORLD\\NEWWORLD.ZEN',
	`World_Virtual` TINYINT unsigned NOT NULL DEFAULT '0',

	`Invisible` BOOLEAN NOT NULL DEFAULT '0',
	`Gained_Exp` BOOLEAN NOT NULL DEFAULT '0',
	`CK` BOOLEAN NOT NULL DEFAULT '0',

	INDEX `PlayIND` (`Player_ID`),
	FOREIGN KEY (`Player_ID`) REFERENCES `Players`(`ID`) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `Player_Info` (
	`Player_ID` INT unsigned NOT NULL,
	`Messages_Sent` INT unsigned NOT NULL DEFAULT '0',
	`Monsters_Killed` INT unsigned NOT NULL DEFAULT '0',
	`Players_Killed` INT unsigned NOT NULL DEFAULT '0',
	`Deaths` INT unsigned NOT NULL DEFAULT '0',
	`Items_Crafted` INT unsigned NOT NULL DEFAULT '0',
	`Items_Picked` INT unsigned NOT NULL DEFAULT '0',
	`Ore_Mined` INT unsigned NOT NULL DEFAULT '0',

	INDEX `PlayIND` (`Player_ID`),
	FOREIGN KEY (`Player_ID`) REFERENCES `Players`(`ID`) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `Player_Items` (
	`Player_ID` INT unsigned NOT NULL,
	`Instance` VARCHAR(32) NOT NULL DEFAULT '',
	`Amount` INT unsigned NOT NULL DEFAULT '0',
	`Equipped` BOOLEAN NOT NULL DEFAULT '0',
	`Slot` INT unsigned NOT NULL DEFAULT '0',

	INDEX `PlayIND` (`Player_ID`),
	FOREIGN KEY (`Player_ID`) REFERENCES `Players`(`ID`) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `NPCs` (
	`ID` INT unsigned NOT NULL AUTO_INCREMENT,

	`Color` VARCHAR(6) NOT NULL DEFAULT 'FFFFFF',

	`Name` VARCHAR(32) NOT NULL DEFAULT '',
	`Voice` TINYINT unsigned NOT NULL DEFAULT '0',
	`Instance` VARCHAR(32) NOT NULL DEFAULT 'PC_HERO',

	`Class_ID` TINYINT unsigned NOT NULL DEFAULT '0',

	`Level` INT unsigned NOT NULL DEFAULT '1',
	`Guild` VARCHAR(64) NOT NULL DEFAULT '',

	`Visual_BodyModel` VARCHAR(32) NOT NULL DEFAULT 'HUM_BODY_NAKED0',
	`Visual_BodyTexture` INT unsigned NOT NULL DEFAULT '8',
	`Visual_HeadModel` VARCHAR(32) NOT NULL DEFAULT 'HUM_HEAD_PONY',
	`Visual_HeadTexture` INT unsigned NOT NULL DEFAULT '18',

	`Visual_Scale_X` FLOAT NOT NULL DEFAULT '1.0',
	`Visual_Scale_Y` FLOAT NOT NULL DEFAULT '1.0',
	`Visual_Scale_Z` FLOAT NOT NULL DEFAULT '1.0',
	`Visual_Fatness` FLOAT NOT NULL DEFAULT '1.0',

	`Walk_Style` VARCHAR(64) NOT NULL DEFAULT 'HUMANS.MDS',

	`Position_X` FLOAT NOT NULL DEFAULT '0.0',
	`Position_Y` FLOAT NOT NULL DEFAULT '0.0',
	`Position_Z` FLOAT NOT NULL DEFAULT '0.0',
	`Position_A` FLOAT NOT NULL DEFAULT '0.0',

	`Spawn_X` FLOAT NOT NULL DEFAULT '0.0',
	`Spawn_Y` FLOAT NOT NULL DEFAULT '0.0',
	`Spawn_Z` FLOAT NOT NULL DEFAULT '0.0',
	`Spawn_A` FLOAT NOT NULL DEFAULT '0.0',

	`World` VARCHAR(64) NOT NULL DEFAULT 'NEWWORLD\\NEWWORLD.ZEN',
	`World_Virtual` TINYINT unsigned NOT NULL DEFAULT '0',

	PRIMARY KEY (`ID`)
);

CREATE TABLE `Chests` (
	`Chest_ID` INT unsigned NOT NULL AUTO_INCREMENT,
	`Player_ID` INT unsigned NOT NULL,
	`Open` BOOLEAN NOT NULL DEFAULT '0',
	`Instance` VARCHAR(32) NOT NULL DEFAULT '',
	`Amount` INT unsigned NOT NULL DEFAULT '0',

	PRIMARY KEY (`Chest_ID`)
);

CREATE TABLE `Houses` (
	`House_ID` INT unsigned NOT NULL AUTO_INCREMENT,
	`Player_ID` INT unsigned NOT NULL,
	`House_Name` VARCHAR(32) NOT NULL DEFAULT '',
	`Price` INT unsigned NOT NULL DEFAULT '0',
	`Open` BOOLEAN NOT NULL DEFAULT '0',

	PRIMARY KEY (`House_ID`)
);

DELIMITER //

CREATE TRIGGER log_server_info_changes
AFTER UPDATE ON Server_Info
FOR EACH ROW
BEGIN
	DECLARE change_description VARCHAR(255);

	IF OLD.Server_Name <> NEW.Server_Name THEN
		SET change_description = CONCAT('Server_Name;', OLD.Server_Name, '>', NEW.Server_Name);
	END IF;

	IF change_description IS NOT NULL THEN
		INSERT INTO Actions (Action_Type, Action_Data)
		VALUES ('Server_Info', change_description);
	END IF;
END;
//

CREATE TRIGGER log_server_config_changes
AFTER UPDATE ON Server_Config
FOR EACH ROW
BEGIN
	DECLARE change_description VARCHAR(255);

	IF OLD.Whitelist <> NEW.Whitelist THEN
		SET change_description = CONCAT('Whitelist;', OLD.Whitelist, '>', NEW.Whitelist);
	END IF;

	IF OLD.PvP <> NEW.PvP THEN
		SET change_description = CONCAT('PvP;', OLD.PvP, '>', NEW.PvP);
	END IF;

	IF OLD.Drop_Items <> NEW.Drop_Items THEN
		SET change_description = CONCAT('Drop_Items;', OLD.Drop_Items, '>', NEW.Drop_Items);
	END IF;

	IF change_description IS NOT NULL THEN
		INSERT INTO Actions (Action_Type, Action_Data)
		VALUES ('Server_Config', change_description);
	END IF;
END;
//

CREATE TRIGGER log_players_changes
AFTER UPDATE ON Players
FOR EACH ROW
BEGIN
	DECLARE change_description VARCHAR(255);

	IF OLD.Perms <> NEW.Perms THEN
		SET change_description = CONCAT('Perms;', NEW.ID, '|', OLD.Perms, '>', NEW.Perms);
	END IF;

	IF OLD.Color <> NEW.Color THEN
		SET change_description = CONCAT('Color;', NEW.ID, '|', OLD.Color, '>', NEW.Color);
	END IF;

	IF OLD.Whitelist <> NEW.Whitelist THEN
		SET change_description = CONCAT('Whitelist;', NEW.ID, '|', OLD.Whitelist, '>', NEW.Whitelist);
	END IF;

	IF change_description IS NOT NULL THEN
		INSERT INTO Actions (Action_Type, Action_Data)
		VALUES ('Players', change_description);
	END IF;
END;
//

DELIMITER ;