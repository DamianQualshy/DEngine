local _giveItem = giveItem;
local _removeItem = removeItem;
local _equipItem = equipItem;
local _unequipItem = unequipItem;
local _useItem = useItem;

Players <- {};
class Player {
	id = -1;
	db_id = -1;

	login = "";
	password = "";
	serial = "";

	permissions = perm.PLAYER;
	color = {r = 0, g = 0, b = 0};

	name = "";
	description = "";

	instance = "PC_HERO";
	class_id = 0;

	level = 1;
	experience = 0;
	learnpoints = 0;
	guild = guilds.UNASSIGNED;

	health = 50;
	max_health = 50;
	mana = 10;
	max_mana = 10;
	strength = 10;
	dexterity = 10;
	onehand = 10;
	twohand = 10;
	bow = 10;
	crossbow = 10;

	magic_circle = 0;

	sneak = 0;
	picklock = 0;
	pickpocket = 0;
	runes = 0;
	alchemy = 0;
	smith = 0;
	trophy = 0;
	acrobatic = 0;

	profession = prof.NONE;
	profession_level = 0;
	profession_exp = 0;

	mining = 0;
	hunting = 0;
	herbalism = 0;

	stamina = 100;

	visual = {bm = "HUM_BODY_NAKED0", bt = 8, hm = "HUM_HEAD_PONY", ht = 18};
	scale = {x = 1.0, y = 1.0, z = 1.0, f = 1.0};
	walk = "HUMANS.MDS";
	pos = {x = 0.0, y = 0.0, z = 0.0, a = 0.0};

	world = "NEWWORLD\\NEWWORLD.ZEN";
	virtual_world = virtualworlds.VOID;

	inventory = {};

	logged = false;
	afk = false;
	invisible = false;
	whitelist = false;

	gained_exp = false;
	ck = false;

	excavating = false;
	gathering = false;
	salvaging = false;

	resting = false;

	constructor(id) {
		this.id = id;

		Players[this.id] <- this;
		this.inventory = Inventory(id);
	}

	function setDatabaseID(_id){
		this.db_id = _id;
	}
	function getDatabaseID(){
		return this.db_id;
	}

	function setLogin(login){
		this.login = convert(login, "string");
	}
	function getLogin(){
		return this.login;
	}

	function setPassword(pass){
		this.password = convert(pass, "string");
	}
	function getPassword(){
		return this.password;
	}

	function setSerial(serial){
		this.serial = convert(serial, "string");
	}
	function getSerial(){
		return this.serial;
	}

	function setPermissions(perms){
		this.permissions = convert(perms, "integer");
	}
	function getPermissions(){
		return this.permissions;
	}

	function setColor(r, g, b){
		this.color.r = convert(r, "integer");
		this.color.g = convert(g, "integer");
		this.color.b = convert(b, "integer");

		setPlayerColor(this.id, this.color.r, this.color.g, this.color.b);
	}
	function setColorHex(hex){
		hex = hexToRgb(convert(hex, "string"));

		this.color.r = hex.r;
		this.color.g = hex.g;
		this.color.b = hex.b;

		setPlayerColor(this.id, this.color.r, this.color.g, this.color.b);
	}
	function getColor(){
		return this.color;
	}
	function getColorHex(){
		return rgbToHex(this.color.r, this.color.g, this.color.b);
	}

	function setName(name){
		this.name = convert(name, "string");

		setPlayerName(this.id, this.name);
	}
	function getName(){
		return this.name;
	}

	function setDescription(desc){
		this.description = convert(desc, "string");
	}
	function getDescription(){
		return this.description;
	}

	function setInstance(instance){
		this.instance = convert(instance, "string");

		setPlayerInstance(this.id, this.instance);
		callEvent("onPlayerUpdate", this.id, statupdate.instance);
	}
	function getInstance(){
		return this.instance;
	}

	function promote(class_id){
		class_id = convert(class_id, "integer");

		if(class_id <= classes.len() && class_id >= 0){
			classes[class_id].func(this.id);

			this.setGuild(classes[class_id].guild);
			this.class_id = class_id;

			callEvent("onPlayerUpdate", this.id, statupdate.classid);
		}
	}
	function getClass(){
		return this.class_id;
	}

	function setLevel(level){
		this.level = convert(level, "integer");

		callEvent("onPlayerUpdate", this.id, statupdate.level);
	}
	function getLevel(){
		return this.level;
	}

	function setExperience(experience){
		this.experience = convert(experience, "integer");

		callEvent("onPlayerUpdate", this.id, statupdate.experience);
	}
	function getExperience(){
		return this.experience;
	}

	function setLearnPoints(learnpoints){
		this.learnpoints = convert(learnpoints, "integer");

		callEvent("onPlayerUpdate", this.id, statupdate.learnpoints);
	}
	function getLearnPoints(){
		return this.learnpoints;
	}

	function setGuild(guild){
		this.guild = convert(guild, "string");

		callEvent("onPlayerUpdate", this.id, statupdate.guildname);
	}
	function getGuild(){
		return this.guild;
	}

	function setHealth(health){
		this.health = convert(health, "integer");

		setPlayerHealth(this.id, this.health);
		callEvent("onPlayerUpdate", this.id, statupdate.health);
	}
	function getHealth(){
		return this.health;
	}
	function setMaxHealth(max_health){
		this.max_health = convert(max_health, "integer");

		setPlayerMaxHealth(this.id, this.max_health);
		callEvent("onPlayerUpdate", this.id, statupdate.max_health);
	}
	function getMaxHealth(){
		return this.max_health;
	}
	function restoreHealth(amount){
		amount = convert(amount, "integer");

		local restore = this.health + amount;
		if(restore <= this.max_health){
			this.setHealth(restore);
		} else {
			this.setHealth(this.max_health);
		}
	}

	function setMana(mana){
		this.mana = convert(mana, "integer");

		setPlayerMana(this.id, this.mana);
		callEvent("onPlayerUpdate", this.id, statupdate.mana);
	}
	function getMana(){
		return this.mana;
	}
	function setMaxMana(max_mana){
		this.max_mana = convert(max_mana, "integer");

		setPlayerMaxMana(this.id, this.max_mana);
		callEvent("onPlayerUpdate", this.id, statupdate.max_mana);
	}
	function getMaxMana(){
		return this.max_mana;
	}
	function restoreMana(amount){
		amount = convert(amount, "integer");

		local restore = this.mana + amount;
		if(restore <= this.max_mana){
			setPlayerMana(this.id, this.mana);
			this.mana = restore;
		} else {
			setPlayerMana(this.id, this.max_mana);
			this.mana = this.max_mana;
		}
	}

	function setStrength(strength){
		this.strength = convert(strength, "integer");

		setPlayerStrength(this.id, this.strength);
		callEvent("onPlayerUpdate", this.id, statupdate.strength);
	}
	function getStrength(){
		return this.strength;
	}

	function setDexterity(dexterity){
		this.dexterity = convert(dexterity, "integer");

		setPlayerDexterity(this.id, this.dexterity);
		callEvent("onPlayerUpdate", this.id, statupdate.dexterity);
	}
	function getDexterity(){
		return this.dexterity;
	}

	function setOneHandSkill(onehand){
		onehand = convert(onehand, "integer");

		if(onehand > 100) onehand = 100;
		this.onehand = onehand;

		setPlayerSkillWeapon(this.id, WEAPON_1H, onehand);
		callEvent("onPlayerUpdate", this.id, statupdate.onehand);
	}
	function getOneHandSkill(){
		return this.onehand;
	}

	function setTwoHandSkill(twohand){
		twohand = convert(twohand, "integer");

		if(twohand > 100) twohand = 100;
		this.twohand = twohand;

		setPlayerSkillWeapon(this.id, WEAPON_2H, this.twohand);
		callEvent("onPlayerUpdate", this.id, statupdate.twohand);
	}
	function getTwoHandSkill(){
		return this.twohand;
	}

	function setBowSkill(bow){
		bow = convert(bow, "integer");

		if(bow > 100) bow = 100;
		this.bow = bow;

		setPlayerSkillWeapon(this.id, WEAPON_BOW, this.bow);
		callEvent("onPlayerUpdate", this.id, statupdate.bow);
	}
	function getBowSkill(){
		return this.bow;
	}

	function setCrossbowSkill(crossbow){
		crossbow = convert(crossbow, "integer");

		if(crossbow > 100) crossbow= 100;
		this.crossbow = crossbow;

		setPlayerSkillWeapon(this.id, WEAPON_CBOW, this.crossbow);
		callEvent("onPlayerUpdate", this.id, statupdate.cbow);
	}
	function getCrossbowSkill(){
		return this.crossbow;
	}

	function setMagicCircle(magic_circle){
		magic_circle = convert(magic_circle, "integer");

		if(magic_circle > 7) magic_circle = 7;
		this.magic_circle = magic_circle;

		setPlayerMagicLevel(this.id, this.magic_circle);
		callEvent("onPlayerUpdate", this.id, statupdate.magic_circle);
	}
	function getMagicCircle(){
		return this.magic_circle;
	}

	function setSneakSkill(level){
		level = convert(level, "integer");

		if(level > 5) level = 5;

		if(level == 0){
			setPlayerTalent(this.id, TALENT_SNEAK, false);
		} else setPlayerTalent(this.id, TALENT_SNEAK, true);

		this.sneak = level;

		callEvent("onPlayerUpdate", this.id, statupdate.sneaking);
	}
	function getSneakSkill(){
		return this.sneak;
	}

	function setPicklockSkill(level){
		level = convert(level, "integer");

		if(level > 5) level = 5;

		if(level == 0){
			setPlayerTalent(this.id, TALENT_PICK_LOCKS, false);
		} else setPlayerTalent(this.id, TALENT_PICK_LOCKS, true);

		this.picklock = level;

		callEvent("onPlayerUpdate", this.id, statupdate.picklock);
	}
	function getPicklockSkill(){
		return this.picklock;
	}

	function setPickpocketSkill(level){
		level = convert(level, "integer");

		if(level > 5) level = 5;

		if(level == 0){
			setPlayerTalent(this.id, TALENT_PICKPOCKET, false);
		} else setPlayerTalent(this.id, TALENT_PICKPOCKET, true);

		this.pickpocket = level;

		callEvent("onPlayerUpdate", this.id, statupdate.pickpocket);
	}
	function getPickpocketSkill(){
		return this.pickpocket;
	}

	function setRuneSkill(level){
		level = convert(level, "integer");

		if(level > 5) level = 5;

		if(level == 0){
			setPlayerTalent(this.id, TALENT_RUNES, false);
		} else setPlayerTalent(this.id, TALENT_RUNES, true);

		this.runes = level;

		callEvent("onPlayerUpdate", this.id, statupdate.runes);
	}
	function getRuneSkill(){
		return this.runes;
	}

	function setAlchemySkill(level){
		level = convert(level, "integer");

		if(level > 5) level = 5;

		if(level == 0){
			setPlayerTalent(this.id, TALENT_ALCHEMY, false);
		} else setPlayerTalent(this.id, TALENT_ALCHEMY, true);

		this.alchemy = level;

		callEvent("onPlayerUpdate", this.id, statupdate.alchemy);
	}
	function getAlchemySkill(){
		return this.alchemy;
	}

	function setSmithSkill(level){
		level = convert(level, "integer");

		if(level > 5) level = 5;

		if(level == 0){
			setPlayerTalent(this.id, TALENT_SMITH, false);
		} else setPlayerTalent(this.id, TALENT_SMITH, true);

		this.smith = level;

		callEvent("onPlayerUpdate", this.id, statupdate.smith);
	}
	function getSmithSkill(){
		return this.smith;
	}

	function setTrophySkill(level){
		level = convert(level, "integer");

		if(level > 5) level = 5;

		if(level == 0){
			setPlayerTalent(this.id, TALENT_THROPHY, false);
		} else setPlayerTalent(this.id, TALENT_THROPHY, true);

		this.trophy = level;

		callEvent("onPlayerUpdate", this.id, statupdate.trophy);
	}
	function getTrophySkill(){
		return this.trophy;
	}

	function setAcrobaticSkill(level){
		level = convert(level, "integer");

		if(level > 5) level = 5;

		if(level == 5){
			setPlayerTalent(this.id, TALENT_ACROBATIC, true);
		} else setPlayerTalent(this.id, TALENT_ACROBATIC, false);

		this.acrobatic = level;

		callEvent("onPlayerUpdate", this.id, statupdate.acrobatic);
	}
	function getAcrobaticSkill(){
		return this.acrobatic;
	}

	function setProfession(profession){
		profession = convert(profession, "string");

		if(!prof.rawin(profession)) profession = prof.NONE;

		this.profession = profession;
	}
	function getProfession(){
		return this.profession;

		callEvent("onPlayerUpdate", this.id, statupdate.profession_name);
	}

	function setProfessionLevel(level){
		this.profession_level = convert(level, "integer");
	}
	function getProfessionLevel(){
		return this.profession_level;

		callEvent("onPlayerUpdate", this.id, statupdate.profession_lvl);
	}

	function setProfessionExp(exp){
		this.profession_exp = convert(exp, "integer");
	}
	function getProfessionExp(){
		return this.profession_exp;

		callEvent("onPlayerUpdate", this.id, statupdate.profession_exp);
	}

	function setMiningSkill(skill){
		this.mining = convert(skill, "integer");

		callEvent("onPlayerUpdate", this.id, statupdate.mining);
	}
	function getMiningSkill(){
		return this.mining;
	}

	function setHuntingSkill(skill){
		this.hunting = convert(skill, "integer");

		callEvent("onPlayerUpdate", this.id, statupdate.hunting);
	}
	function getHuntingSkill(){
		return this.hunting;
	}

	function setHerbalismSkill(skill){
		this.herbalism = convert(skill, "integer");

		callEvent("onPlayerUpdate", this.id, statupdate.herbalism);
	}
	function getHerbalismSkill(){
		return this.herbalism;
	}

	function setStamina(stamina){
		stamina = convert(stamina, "integer");

		if(stamina > 100) stamina = 100;
		this.stamina = stamina;

		callEvent("onPlayerUpdate", this.id, statupdate.stamina);
	}
	function getStamina(){
		return this.stamina;
	}
	function restoreStamina(amount){
		amount = convert(amount, "integer");

		local restore = this.stamina + amount;
		if(restore <= 100){
			this.stamina = restore;
		} else {
			this.stamina = 100;
		}
	}

	function setVisual(bodyModel, bodyTexture, headModel, headTexture){
		this.visual.bm = convert(bodyModel, "string");
		this.visual.bt = convert(bodyTexture, "integer");
		this.visual.hm = convert(headModel, "string");
		this.visual.ht = convert(headTexture, "integer");

		setPlayerVisual(this.id, this.visual.bm, this.visual.bt, this.visual.hm, this.visual.ht);
	}
	function getVisual(){
		return this.visual;
	}

	function setScale(x, y, z, fatness){
		this.scale.x = convert(x, "float");
		this.scale.y = convert(y, "float");
		this.scale.z = convert(z, "float");
		this.scale.f = convert(fatness, "float");

		setPlayerScale(this.id, this.scale.x, this.scale.y, this.scale.z);
		setPlayerFatness(this.id, this.scale.f);
	}
	function getScale(){
		return this.scale;
	}

	function setWalkstyle(walk){
		this.walk = convert(walk, "string");

		applyPlayerOverlay(this.id, Mds.id(this.walk));
	}
	function getWalkstyle(){
		return this.walk;
	}
	function resetWalkstyle(){
		removePlayerOverlay(this.id, Mds.id(this.walk));

		this.walk = "HUMANS.MDS";
	}

	function setPosition(x, y, z, angle){
		this.pos.x = convert(x, "float");
		this.pos.y = convert(y, "float");
		this.pos.z = convert(z, "float");
		this.pos.a = convert(angle, "float");

		setPlayerPosition(this.id, this.pos.x, this.pos.y, this.pos.z);
		setPlayerAngle(this.id, this.pos.a);
	}
	function getPosition(){
		local gamepos = getPlayerPosition(this.id);
		local gameang = getPlayerAngle(this.id);

		this.pos.x = gamepos.x;
		this.pos.y = gamepos.y;
		this.pos.z = gamepos.z;
		this.pos.a = gameang;

		return this.pos;
	}

	function setWorld(world){
		world = convert(world, "string").toupper();

		if(this.world != world){
			this.world = world;
			setPlayerWorld(this.id, this.world);
		}
	}
	function getWorld(){
		return this.world;
	}

	function setVirtualWorld(virtual_world){
		this.virtual_world = convert(virtual_world, "integer");

		setPlayerVirtualWorld(this.id, this.virtual_world);
	}
	function getVirtualWorld(){
		return this.virtual_world;
	}


	function setInvisibility(state){
		this.invisible = convert(state, "bool");

		setPlayerInvisible(this.id, this.invisible);
	}
	function isInvisible(){
		return this.invisible;
	}

	function setWhitelist(state){
		this.whitelist = convert(state, "bool");
	}
	function isOnWhitelist(){
		return this.whitelist;
	}

	function isLogged(){
		return this.logged;
	}

	function isAFK(){
		return this.afk;
	}

	function isConnected(){
		return isPlayerConnected(this.id);
	}

	function isDead(){
		return isPlayerDead(this.id);
	}

	function isUnconscious(){
		return isPlayerUnconscious(this.id);
	}

	function respawn(){
		spawnPlayer(this.id);

		this.setVisual(this.visual.bm, this.visual.bt, this.visual.hm, this.visual.ht);

		local class_pos = classes[this.class_id].spawn;
		this.setPosition(class_pos.x, class_pos.y, class_pos.z, class_pos.a);
	}
	function spawn(){
		spawnPlayer(this.id);

		local visual = this.getVisual();
		this.setVisual(this.visual.bm, this.visual.bt, this.visual.hm, this.visual.ht);
	}
	function unspawn(){
		unspawnPlayer(this.id);
	}
	function isSpawned(){
		return isPlayerSpawned(this.id);
	}

	function giveItem(instance, amount){
		instance = convert(instance, "string").toupper();
		amount = convert(amount, "integer");

		if(doesItemExist(instance)){
			local index = getItemIndex(instance);

			if(this.inventory.items.rawin(index)){
				this.inventory.items[index].amount += amount;
			} else {
				this.inventory.items[index] <- {instance = instance, amount = amount, equipped = false};
			}

			callEvent("onGiveItem", this.id, instance, amount);
			_giveItem(this.id, instance, amount);
		}
	}
	function removeItem(instance, amount){
		instance = convert(instance, "string").toupper();
		amount = convert(amount, "integer");

		if(doesItemExist(instance)){
			local index = getItemIndex(instance);

			if(this.inventory.items.rawin(index)){
				if(this.inventory.items[index].amount >= 0){
					this.inventory.items[index].amount -= amount;
				}
				if(this.inventory.items[index].amount <= 0){
					this.inventory.items.rawdelete(index);
				}

				callEvent("onRemoveItem", this.id, instance, amount);
				_removeItem(this.id, instance, amount);
			}
		}
	}
	function equipItem(instance){
		instance = convert(instance, "string").toupper();

		if(doesItemExist(instance)){
			local index = getItemIndex(instance);

			if(this.inventory.items.rawin(index)){
				_equipItem(this.id, instance);
				this.inventory.items[index].equipped = true;
			}
		}
	}
	function unequipItem(instance){
		instance = convert(instance, "string").toupper();

		if(doesItemExist(instance)){
			local index = getItemIndex(instance);

			if(this.inventory.items.rawin(index)){
				_unequipItem(this.id, instance);
				this.inventory.items[index].equipped = false;
			}
		}
	}
	function useItem(instance){
		instance = convert(instance, "string").toupper();

		if(doesItemExist(instance)){
			local index = getItemIndex(instance);

			if(this.inventory.items.rawin(index)){
				if(this.inventory.items[index].amount > 0){
					--this.inventory.items[index].amount;
				}
				_useItem(this.id, instance);
				if(this.inventory.items[index].amount <= 0){
					this.inventory.items.rawdelete(index);
				}
			}
		}
	}
	function hasItem(instance){
		instance = convert(instance, "string").toupper();

		if(doesItemExist(instance)){
			local index = getItemIndex(instance);

			return this.inventory.items.rawin(index);
		}
	}
	function isItemEquipped(instance){
		if(instance == null) return;
		instance = convert(instance, "string").toupper();

		if(doesItemExist(instance)){
			local index = getItemIndex(instance);

			if(this.inventory.items.rawin(index)){
				return this.inventory.items[index].equipped;
			} else return null;
		}
	}

	function getNextLevelExp(){
		return 250 * this.level * (this.level + 1);
	}

	function getNextProfessionLevelExp(){
		return (250 * this.profession_level) * (this.profession_level ^ 2);
	}

	function isLevelCapped(){
		if(this.level == classes[this.class_id].level_cap){
			return true;
		} else return false;
	}

	function isExcavating(){
		return this.excavating;
	}

	function isGathering(){
		return this.gathering;
	}

	function isSalvaging(){
		return this.salvaging;
	}

	function isResting(){
		return this.resting;
	}

	function hasGainedExperienceToday(){
		return this.gained_exp;
	}

	function bulkSendStats(){
		local statsUpdate = PlayerStatsMessage(this.id,
			this.guild,
			classes[this.class_id].name,
			this.level,
			this.experience,
			this.getNextLevelExp(),
			this.learnpoints,
			this.stamina,
			this.strength,
			this.dexterity,
			this.mana,
			this.max_mana,
			this.health,
			this.max_health,
			this.onehand,
			this.twohand,
			this.bow,
			this.crossbow,
			this.profession,
			this.profession_level,
			this.profession_exp,
			this.getNextProfessionLevelExp(),
			this.mining,
			this.hunting,
			this.herbalism,
			this.sneak,
			this.picklock,
			this.pickpocket,
			this.runes,
			this.alchemy,
			this.smith,
			this.trophy,
			this.acrobatic,
			this.magic_circle
			).serialize();
		statsUpdate.send(this.id, RELIABLE_ORDERED);
	}


	function kick(reason){
		kick(this.id, reason);

	}

	function ban(duration, reason){
		ban(this.id, duration, reason);

	}

	function jail(duration, reason){

	}

	function characterKill(){
		local result_items = MySQL.query("SELECT * FROM Player_Items WHERE Player_ID = '" + this.db_id + "'");
		local result_items_arr = [];
			if(result_items != null){
				for(local i = 0, end = MySQL.numRows(result_items); i < end; i++){
					result_items_arr.append(MySQL.fetchAssoc(result_items));
				}
				MySQL.freeResult(result_items);

				local myfile = io.file("database/" + this.name + ".items", "w+");
					if(myfile.isOpen){
						for(local i = 0, end = result_items_arr.len(); i < end; i++){
							myfile.write(format("%s %d", result_items_arr[i].Instance, result_items_arr[i].Amount) + "\n");
						}
					myfile.close();
					}
			}
		MySQL.query("DELETE FROM Player_Items WHERE Player_ID = '" + this.db_id + "'");

		this.ck = 1;
		this.kick(format("%s has drawn his final breath.", this.name));
	}


	function doesExist(){
		this.setSerial(getPlayerSerial(this.id));

		if(MySQL.isConnectedToDB()){
			local result = MySQL.query("SELECT * FROM Players WHERE Serial = '" + this.serial + "'");
			if(result != null){
				local row = MySQL.fetchAssoc(result);
				MySQL.freeResult(result);
				if(row != null){
					this.setLogin(row.Login);
					this.setPassword(row.Password);
					this.setDatabaseID(row.ID);
					return true;
				}
			} else return false;
		} else {
			local myfile = io.file("database/" + this.serial + ".acc", "r");
			if(myfile.isOpen){
				this.login = myfile.read(io_type.LINE);
				this.password = myfile.read(io_type.LINE);
				myfile.close();
				return true;
			} else return false;
		}
	}

	function findPlayerThroughDatabaseID(_id){
		if(_id == this.getDatabaseID()){
			return true;
		} else return false;
	}

	function getLastHero(){
		local result_hero = MySQL.query("SELECT * FROM Player_Hero WHERE Player_ID = '" + this.db_id + "'");
			local result_chars = [];
			for(local i = 0, end = MySQL.numRows(result_hero); i < end; i++){
				local char = MySQL.fetchAssoc(result_hero);
				if(char.CK == 1) {
					result_chars.append(char);
				} else {
					result_chars.append(char);
					break;
				}
			}
				MySQL.freeResult(result_hero);
			local lastChar = result_chars.top();

			return lastChar;
	}

	function save(){
		if(!this.isLogged()) return;

		if(MySQL.isConnectedToDB()){
			local result = MySQL.query("SELECT * FROM Players WHERE Serial = '" + this.serial + "'");
				local row = MySQL.fetchAssoc(result);
				MySQL.freeResult(result);

			if(row == null){
				MySQL.insert("Players", {
					Login = this.login,
					Password = this.password,

					Serial = this.serial,

					First_Login = format("%04d-%02d-%02d %02d:%02d:%02d", date().year, date().month + 1, date().day, date().hour, date().min, date().sec),
					Last_Login = format("%04d-%02d-%02d %02d:%02d:%02d", date().year, date().month + 1, date().day, date().hour, date().min, date().sec),

					First_Serial = this.serial,

					Perms = this.permissions,
					Color = this.getColorHex(),

					Whitelist = this.whitelist
				});

				this.setDatabaseID(MySQL.fetchAssoc(MySQL.query("SELECT ID FROM Players WHERE Serial = '" + this.serial + "'")).ID);
				MySQL.insert("Player_Hero", {
					Player_ID = this.db_id,
					Name = this.name,
					Description = this.description,

					Instance = this.instance,
					Class_ID = this.class_id,

					Level = this.level,
					Experience = this.experience,
					Learn_Points = this.learnpoints,
					Guild = this.guild,

					Health = this.health,
					Health_Max = this.max_health,
					Mana = this.mana,
					Mana_Max = this.max_mana,
					Strength = this.strength,
					Dexterity = this.dexterity,
					Skill_OneHand = this.onehand,
					Skill_TwoHand = this.twohand,
					Skill_Bow = this.bow,
					Skill_Crossbow = this.crossbow,

					Magic_Circle = this.magic_circle,

					Talent_Sneak = this.sneak,
					Talent_Picklock = this.picklock,
					Talent_Pickpocket = this.pickpocket,
					Talent_Runemaking = this.runes,
					Talent_Alchemy = this.alchemy,
					Talent_Smith = this.smith,
					Talent_Trophy = this.trophy,
					Talent_Acrobatic = this.acrobatic,

					Profession = this.profession,
					Profession_Level = this.profession_level,
					Profession_Exp = this.profession_exp,

					Skill_Mining = this.mining,
					Skill_Hunting = this.hunting,
					Skill_Herbalism = this.herbalism,

					Stamina = this.stamina,

					Visual_BodyModel = this.visual.bm,
					Visual_BodyTexture = this.visual.bt,
					Visual_HeadModel = this.visual.hm,
					Visual_HeadTexture = this.visual.ht,

					Visual_Scale_X = this.scale.x,
					Visual_Scale_Y = this.scale.y,
					Visual_Scale_Z = this.scale.z,
					Visual_Fatness = this.scale.f,

					Walk_Style = this.walk,

					Position_X = this.getPosition().x,
					Position_Y = this.getPosition().y,
					Position_Z = this.getPosition().z,
					Position_A = this.getPosition().a,

					World = this.world,
					World_Virtual = this.virtual_world,

					Invisible = this.invisible,
					Gained_Exp = this.gained_exp,
					CK = this.ck
				});
				foreach(item in this.inventory.items){
					MySQL.insert("Player_Items", {
						Player_ID = db_id,
						Instance = item.instance,
						Amount = item.amount,
						Equipped = item.equipped,
						Slot = itemDatabase[getItemIndex(item.instance)].wear
					});
				}
			} else {
				MySQL.update("Players", "Serial", this.serial, {
					Password = this.password,

					Serial = this.serial,

					Last_Login = format("%04d-%02d-%02d %02d:%02d:%02d", date().year, date().month + 1, date().day, date().hour, date().min, date().sec),

					Perms = this.permissions,
					Color = this.getColorHex(),

					Whitelist = this.whitelist
				});

				if(this.getLastHero().CK == 1){
					MySQL.insert("Player_Hero", {
						Player_ID = this.db_id,
						Name = this.name,
						Description = this.description,

						Instance = this.instance,
						Class_ID = this.class_id,

						Level = this.level,
						Experience = this.experience,
						Learn_Points = this.learnpoints,
						Guild = this.guild,

						Health = this.health,
						Health_Max = this.max_health,
						Mana = this.mana,
						Mana_Max = this.max_mana,
						Strength = this.strength,
						Dexterity = this.dexterity,
						Skill_OneHand = this.onehand,
						Skill_TwoHand = this.twohand,
						Skill_Bow = this.bow,
						Skill_Crossbow = this.crossbow,

						Magic_Circle = this.magic_circle,

						Talent_Sneak = this.sneak,
						Talent_Picklock = this.picklock,
						Talent_Pickpocket = this.pickpocket,
						Talent_Runemaking = this.runes,
						Talent_Alchemy = this.alchemy,
						Talent_Smith = this.smith,
						Talent_Trophy = this.trophy,
						Talent_Acrobatic = this.acrobatic,

						Profession = this.profession,
						Profession_Level = this.profession_level,
						Profession_Exp = this.profession_exp,

						Skill_Mining = this.mining,
						Skill_Hunting = this.hunting,
						Skill_Herbalism = this.herbalism,

						Stamina = this.stamina,

						Visual_BodyModel = this.visual.bm,
						Visual_BodyTexture = this.visual.bt,
						Visual_HeadModel = this.visual.hm,
						Visual_HeadTexture = this.visual.ht,

						Visual_Scale_X = this.scale.x,
						Visual_Scale_Y = this.scale.y,
						Visual_Scale_Z = this.scale.z,
						Visual_Fatness = this.scale.f,

						Walk_Style = this.walk,

						Position_X = this.getPosition().x,
						Position_Y = this.getPosition().y,
						Position_Z = this.getPosition().z,
						Position_A = this.getPosition().a,

						World = this.world,
						World_Virtual = this.virtual_world,

						Invisible = this.invisible,
						Gained_Exp = this.gained_exp,
						CK = this.ck
					});
					foreach(item in this.inventory.items){
						MySQL.insert("Player_Items", {
							Player_ID = db_id,
							Instance = item.instance,
							Amount = item.amount,
							Equipped = item.equipped,
							Slot = itemDatabase[getItemIndex(item.instance)].wear
						});
					}
				} else {
					MySQL.update("Player_Hero", "Player_ID", this.db_id.tostring(), {
						Name = this.name,
						Description = this.description,

						Instance = this.instance,
						Class_ID = this.class_id,

						Level = this.level,
						Experience = this.experience,
						Learn_Points = this.learnpoints,
						Guild = this.guild,

						Health = this.health,
						Health_Max = this.max_health,
						Mana = this.mana,
						Mana_Max = this.max_mana,
						Strength = this.strength,
						Dexterity = this.dexterity,
						Skill_OneHand = this.onehand,
						Skill_TwoHand = this.twohand,
						Skill_Bow = this.bow,
						Skill_Crossbow = this.crossbow,

						Magic_Circle = this.magic_circle,

						Talent_Sneak = this.sneak,
						Talent_Picklock = this.picklock,
						Talent_Pickpocket = this.pickpocket,
						Talent_Runemaking = this.runes,
						Talent_Alchemy = this.alchemy,
						Talent_Smith = this.smith,
						Talent_Trophy = this.trophy,
						Talent_Acrobatic = this.acrobatic,

						Profession = this.profession,
						Profession_Level = this.profession_level,
						Profession_Exp = this.profession_exp,

						Skill_Mining = this.mining,
						Skill_Hunting = this.hunting,
						Skill_Herbalism = this.herbalism,

						Stamina = this.stamina,

						Visual_BodyModel = this.visual.bm,
						Visual_BodyTexture = this.visual.bt,
						Visual_HeadModel = this.visual.hm,
						Visual_HeadTexture = this.visual.ht,

						Visual_Scale_X = this.scale.x,
						Visual_Scale_Y = this.scale.y,
						Visual_Scale_Z = this.scale.z,
						Visual_Fatness = this.scale.f,

						Walk_Style = this.walk,

						Position_X = this.getPosition().x,
						Position_Y = this.getPosition().y,
						Position_Z = this.getPosition().z,
						Position_A = this.getPosition().a,

						World = this.world,
						World_Virtual = this.virtual_world,

						Invisible = this.invisible,
						Gained_Exp = this.gained_exp,
						CK = this.ck
					});
					MySQL.query("DELETE FROM Player_Items WHERE Player_ID = '" + this.db_id + "'");
					foreach(item in this.inventory.items){
						MySQL.insert("Player_Items", {
							Player_ID = db_id,
							Instance = item.instance,
							Amount = item.amount,
							Equipped = item.equipped,
							Slot = itemDatabase[getItemIndex(item.instance)].wear
						});
					}
				}
			}
		} else {
			local myfile = io.file("database/" + this.serial + ".acc", "w+");

			if(myfile.isOpen){
				myfile.write(this.getLogin() + "\n");
				myfile.write(this.getPassword() + "\n");
				myfile.write(this.getSerial() + "\n");
				myfile.write(this.getPermissions() + "\n");
				myfile.write(this.getColor().r + " " + this.getColor().g + " " + this.getColor().b + "\n");
				myfile.write(this.getName() + "\n");
				myfile.write(this.getDescription() + "\n");
				myfile.write(this.getInstance() + "\n");
				myfile.write(this.getClass() + "\n");
				myfile.write(this.getLevel() + "\n");
				myfile.write(this.getExperience() + "\n");
				myfile.write(this.getLearnPoints() + "\n");
				myfile.write(this.getGuild() + "\n");
				myfile.write(this.getHealth() + "\n");
				myfile.write(this.getMaxHealth() + "\n");
				myfile.write(this.getMana() + "\n");
				myfile.write(this.getMaxMana() + "\n");
				myfile.write(this.getStrength() + "\n");
				myfile.write(this.getDexterity() + "\n");
				myfile.write(this.getOneHandSkill() + "\n");
				myfile.write(this.getTwoHandSkill() + "\n");
				myfile.write(this.getBowSkill() + "\n");
				myfile.write(this.getCrossbowSkill() + "\n");
				myfile.write(this.getMagicCircle() + "\n");
				myfile.write(this.getSneakSkill() + "\n");
				myfile.write(this.getPicklockSkill() + "\n");
				myfile.write(this.getPickpocketSkill() + "\n");
				myfile.write(this.getRuneSkill() + "\n");
				myfile.write(this.getAlchemySkill() + "\n");
				myfile.write(this.getSmithSkill() + "\n");
				myfile.write(this.getTrophySkill() + "\n");
				myfile.write(this.getAcrobaticSkill() + "\n");
				myfile.write(this.getProfession() + "\n");
				myfile.write(this.getProfessionLevel() + "\n");
				myfile.write(this.getProfessionExp() + "\n");
				myfile.write(this.getMiningSkill() + "\n");
				myfile.write(this.getHuntingSkill() + "\n");
				myfile.write(this.getHerbalismSkill() + "\n");
				myfile.write(this.getStamina() + "\n");
				myfile.write(this.getVisual().bm + " " + this.getVisual().bt + " " + this.getVisual().hm + " " + this.getVisual().ht + "\n");
				myfile.write(this.getScale().x + " " + this.getScale().y + " " + this.getScale().z + " " + this.getScale().f + "\n");
				myfile.write(this.getWalkstyle() + "\n");
				myfile.write(this.getPosition().x + " " + this.getPosition().y + " " + this.getPosition().z + " " + this.getPosition().a + "\n");
				myfile.write(this.getWorld() + "\n");
				myfile.write(this.getVirtualWorld() + "\n");
				myfile.write(this.isInvisible() + "\n");
				myfile.write(this.isOnWhitelist() + "\n");
			myfile.close();
			}
		}
	}

	function load(){
		if(MySQL.isConnectedToDB()){
			local result_player = MySQL.query("SELECT * FROM Players WHERE Serial = '" + this.serial + "'");

			if(result_player != null){
				local row_player = MySQL.fetchAssoc(result_player);
				MySQL.freeResult(result_player);

					this.setDatabaseID(row_player.ID);
					this.setLogin(row_player.Login);
					this.setPassword(row_player.Password);
					this.setPermissions(row_player.Perms);
					this.setColorHex(row_player.Color);
					this.whitelist = row_player.Whitelist;

				local row_hero = this.getLastHero();
					this.setName(row_hero.Name),
					this.setDescription(row_hero.Description),

					this.setInstance(row_hero.Instance),
					this.class_id = row_hero.Class_ID,

					this.setLevel(row_hero.Level),
					this.setExperience(row_hero.Experience),
					this.setLearnPoints(row_hero.Learn_Points),
					this.setGuild(row_hero.Guild),

					this.setHealth(row_hero.Health),
					this.setMaxHealth(row_hero.Health_Max),
					this.setMana(row_hero.Mana),
					this.setMaxMana(row_hero.Mana_Max),
					this.setStrength(row_hero.Strength),
					this.setDexterity(row_hero.Dexterity),
					this.setOneHandSkill(row_hero.Skill_OneHand),
					this.setTwoHandSkill(row_hero.Skill_TwoHand),
					this.setBowSkill(row_hero.Skill_Bow),
					this.setCrossbowSkill(row_hero.Skill_Crossbow),

					this.setMagicCircle(row_hero.Magic_Circle),

					this.setSneakSkill(row_hero.Talent_Sneak),
					this.setPicklockSkill(row_hero.Talent_Picklock),
					this.setPickpocketSkill(row_hero.Talent_Pickpocket),
					this.setRuneSkill(row_hero.Talent_Runemaking),
					this.setAlchemySkill(row_hero.Talent_Alchemy),
					this.setSmithSkill(row_hero.Talent_Smith),
					this.setTrophySkill(row_hero.Talent_Trophy),
					this.setAcrobaticSkill(row_hero.Talent_Acrobatic),

					this.setProfession(row_hero.Profession),
					this.setProfessionLevel(row_hero.Profession_Level),
					this.setProfessionExp(row_hero.Profession_Exp),

					this.setMiningSkill(row_hero.Skill_Mining),
					this.setHuntingSkill(row_hero.Skill_Hunting),
					this.setHerbalismSkill(row_hero.Skill_Herbalism),

					this.setStamina(row_hero.Stamina),

					this.setWalkstyle(row_hero.Walk_Style),
					this.setVisual(row_hero.Visual_BodyModel, row_hero.Visual_BodyTexture, row_hero.Visual_HeadModel, row_hero.Visual_HeadTexture),
					this.setScale(row_hero.Visual_Scale_X, row_hero.Visual_Scale_Y, row_hero.Visual_Scale_Z, row_hero.Visual_Fatness),

					this.setWorld(row_hero.World),
					this.setPosition(row_hero.Position_X, row_hero.Position_Y, row_hero.Position_Z, row_hero.Position_A),

					this.setVirtualWorld(row_hero.World_Virtual),

					this.invisible = row_hero.Invisible
					this.gained_exp = row_hero.Gained_Exp,
					this.ck = row_hero.CK

				local result_items = MySQL.query("SELECT * FROM Player_Items WHERE Player_ID = '" + this.db_id + "'");
				local result_items_arr = [];
					if(result_items != null){
						for(local i = 0, end = MySQL.numRows(result_items); i < end; i++){
							result_items_arr.append(MySQL.fetchAssoc(result_items));
						}
						MySQL.freeResult(result_items);
						for(local i = 0, end = result_items_arr.len(); i < end; i++){
								if(result_items_arr[i] == null) break;

							this.giveItem(result_items_arr[i].Instance, result_items_arr[i].Amount);
							if(result_items_arr[i].Equipped == 1) this.equipItem(result_items_arr[i].Instance);
						}
					}
			}
		} else {
			local myfile = io.file("database/" + this.serial + ".acc", "r");
			if(myfile.isOpen){
				local login = myfile.read(io_type.LINE);
				local passwd = myfile.read(io_type.LINE);
				local serial = myfile.read(io_type.LINE);
				if(login == this.login && passwd == this.password && serial == this.serial){
					this.setPermissions(myfile.read(io_type.LINE))
						local color = sscanf("ddd", myfile.read(io_type.LINE));
					this.setColor(color[0], color[1], color[2]);
					this.setName(myfile.read(io_type.LINE));
					this.setDescription(myfile.read(io_type.LINE));
					this.setInstance(myfile.read(io_type.LINE));
					this.class_id = myfile.read(io_type.LINE);
					this.setLevel(myfile.read(io_type.LINE));
					this.setExperience(myfile.read(io_type.LINE));
					this.setLearnPoints(myfile.read(io_type.LINE));
					this.setGuild(myfile.read(io_type.LINE));
					this.setHealth(myfile.read(io_type.LINE));
					this.setMaxHealth(myfile.read(io_type.LINE));
					this.setMana(myfile.read(io_type.LINE));
					this.setMaxMana(myfile.read(io_type.LINE));
					this.setStrength(myfile.read(io_type.LINE));
					this.setDexterity(myfile.read(io_type.LINE));
					this.setOneHandSkill(myfile.read(io_type.LINE));
					this.setTwoHandSkill(myfile.read(io_type.LINE));
					this.setBowSkill(myfile.read(io_type.LINE));
					this.setCrossbowSkill(myfile.read(io_type.LINE));
					this.setMagicCircle(myfile.read(io_type.LINE));
					this.setSneakSkill(myfile.read(io_type.LINE));
					this.setPicklockSkill(myfile.read(io_type.LINE));
					this.setPickpocketSkill(myfile.read(io_type.LINE));
					this.setRuneSkill(myfile.read(io_type.LINE));
					this.setAlchemySkill(myfile.read(io_type.LINE));
					this.setSmithSkill(myfile.read(io_type.LINE));
					this.setTrophySkill(myfile.read(io_type.LINE));
					this.setAcrobaticSkill(myfile.read(io_type.LINE));
					this.setProfession(myfile.read(io_type.LINE));
					this.setProfessionLevel(myfile.read(io_type.LINE));
					this.setProfessionExp(myfile.read(io_type.LINE));
					this.setMiningSkill(myfile.read(io_type.LINE));
					this.setHuntingSkill(myfile.read(io_type.LINE));
					this.setHerbalismSkill(myfile.read(io_type.LINE));
					this.setStamina(myfile.read(io_type.LINE));
						local vis = sscanf("sdsd", myfile.read(io_type.LINE));
					this.setVisual(vis[0], vis[1], vis[2], vis[3]);
						local scale = sscanf("ffff", myfile.read(io_type.LINE));
					this.setScale(scale[0], scale[1], scale[2], scale[3]);
					this.setWalkstyle(myfile.read(io_type.LINE));
						local pos = sscanf("ffff", myfile.read(io_type.LINE));
					this.setPosition(pos[0], pos[1], pos[2], pos[3]);
					this.setWorld(myfile.read(io_type.LINE));
					this.setVirtualWorld(myfile.read(io_type.LINE));
					this.setInvisibility(myfile.read(io_type.LINE));
					this.setWhitelist(myfile.read(io_type.LINE));
				}
			myfile.close();
			}
		}
		this.bulkSendStats();
	}
}

addEventHandler("onPlayerJoin", function(pid){
	if(isNpc(pid)) return;

	Players[pid] <- Player(pid);
});

addEventHandler("onPlayerDisconnect", function(pid, reason){
	if(isNpc(pid)) return;

	Players[pid].save();
	Players[pid].inventory.items.clear();
	Players.rawdelete(pid);
});

addEventHandler("onPlayerRegister", function(pid){
	if(isNpc(pid)) return;

	Players[pid].save();
});

addEventHandler("onPlayerDead", function(pid, kid){
	if(isNpc(pid)) return;

	Players[pid].unspawn();
});

addEventHandler("onPlayerRespawn", function(pid){
	if(isNpc(pid)) return;

	Players[pid].respawn();
});