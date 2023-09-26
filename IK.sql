DROP DATABASE IF EXISTS `immersivekhorinis`;
CREATE DATABASE `immersivekhorinis` CHARACTER SET cp1250 COLLATE cp1250_bin;

CREATE TABLE `Players` (
	`ID` INT unsigned NOT NULL AUTO_INCREMENT,
	`Login` VARCHAR(32) NOT NULL DEFAULT '',
	`Password` VARCHAR(64) NOT NULL DEFAULT '',
	`Serial` VARCHAR(64) NOT NULL DEFAULT '',
	`UID` VARCHAR(64) NOT NULL DEFAULT '',
	`FirstLogin` DATETIME NOT NULL,
	`LastLogin` DATETIME NOT NULL,

	`Perms` TINYINT unsigned NOT NULL DEFAULT '0',
	`Color` VARCHAR(6) NOT NULL DEFAULT 'FFFFFF',
	`Name` VARCHAR(32) NOT NULL DEFAULT '',
	`Description` VARCHAR(64) NOT NULL DEFAULT '',

	`Instance` VARCHAR(32) NOT NULL DEFAULT 'PC_HERO',

	`Class_ID` TINYINT unsigned NOT NULL DEFAULT '0',

	`Level` INT unsigned NOT NULL DEFAULT '1',
	`Experience` INT unsigned NOT NULL DEFAULT '0',
	`LearnPoints` INT unsigned NOT NULL DEFAULT '0',
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

	`MagicCircle` TINYINT unsigned NOT NULL DEFAULT '0',
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
	`WalkStyle` VARCHAR(64) NOT NULL DEFAULT 'HUMANS.MDS',

	`Position_X` FLOAT NOT NULL DEFAULT '0.0',
	`Position_Y` FLOAT NOT NULL DEFAULT '0.0',
	`Position_Z` FLOAT NOT NULL DEFAULT '0.0',
	`Position_A` FLOAT NOT NULL DEFAULT '0.0',
	`World` VARCHAR(64) NOT NULL DEFAULT 'NEWWORLD\\NEWWORLD.ZEN',
	`World_Virtual` TINYINT unsigned NOT NULL DEFAULT '0',

	`Invisible` BOOLEAN NOT NULL DEFAULT '0',
	`Whitelist` BOOLEAN NOT NULL DEFAULT '0',
	`Gained_Exp` BOOLEAN NOT NULL DEFAULT '0',
	`CK` BOOLEAN NOT NULL DEFAULT '0',

	PRIMARY KEY (`ID`)
);

CREATE TABLE `Player_Items` (
	`UID` VARCHAR(64) NOT NULL DEFAULT '',
	`Instance` VARCHAR(32) NOT NULL DEFAULT '',
	`Amount` INT unsigned NOT NULL DEFAULT '0',
	`Equipped` BOOLEAN NOT NULL DEFAULT '0'
);