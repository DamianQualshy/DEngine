local _giveItem = giveItem;
local _removeItem = removeItem;
local _equipItem = equipItem;

Players <- {};
class Player {
	id = -1;

	login = "";
	password = "";
	serial = "";
	uid = "";

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

	items = {};

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
	}

	function setLogin(login){
		this.login = login;
	}
	function getLogin(){
		return this.login;
	}

	function setPassword(pass){
		this.password = pass;
	}
	function getPassword(){
		return this.password;
	}

	function setSerial(serial){
		this.serial = serial;
	}
	function getSerial(){
		return this.serial;
	}

	function setUID(uid){
		this.uid = uid;
	}
	function getUID(){
		return this.uid;
	}

	function setPermissions(perms){
		this.permissions = perms;
	}
	function getPermissions(){
		return this.permissions;
	}

	function setColor(r, g, b){
		setPlayerColor(this.id, r, g, b);

		this.color.r = r;
		this.color.g = g;
		this.color.b = b;
	}
	function setColorHex(hex){
		hex = hexToRgb(hex);

		this.color.r = hex.r;
		this.color.g = hex.g;
		this.color.b = hex.b;

		setPlayerColor(this.id, hex.r, hex.g, hex.b);
	}
	function getColor(){
		return this.color;
	}
	function getColorHex(){
		local rgb = this.color;
		local hex = rgbToHex(rgb.r, rgb.g, rgb.b);

		return hex;
	}

	function setName(name){
		setPlayerName(this.id, name);

		this.name = name;
	}
	function getName(){
		return this.name;
	}

	function setDescription(desc){
		this.description = desc;
	}
	function getDescription(){
		return this.description;
	}

	function setInstance(instance){
		setPlayerInstance(this.id, instance);

		this.instance = instance;

		callEvent("onPlayerUpdate", this.id, statupdate.instance);
	}
	function getInstance(){
		return this.instance;
	}

	function promote(class_id){
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
		this.level = level;

		callEvent("onPlayerUpdate", this.id, statupdate.level);
	}
	function getLevel(){
		return this.level;
	}

	function setExperience(experience){
		this.experience = experience;

		callEvent("onPlayerUpdate", this.id, statupdate.experience);
	}
	function getExperience(){
		return this.experience;
	}

	function setLearnPoints(learnpoints){
		this.learnpoints = learnpoints;

		callEvent("onPlayerUpdate", this.id, statupdate.learnpoints);
	}
	function getLearnPoints(){
		return this.learnpoints;
	}

	function setGuild(guild){
		this.guild = guild;

		callEvent("onPlayerUpdate", this.id, statupdate.guildname);
	}
	function getGuild(){
		return this.guild;
	}

	function setHealth(health){
		setPlayerHealth(this.id, health);

		this.health = health;

		callEvent("onPlayerUpdate", this.id, statupdate.health);
	}
	function getHealth(){
		return this.health;
	}
	function setMaxHealth(max_health){
		setPlayerMaxHealth(this.id, max_health);

		this.max_health = max_health;

		callEvent("onPlayerUpdate", this.id, statupdate.max_health);
	}
	function getMaxHealth(){
		return this.max_health;
	}
	function restoreHealth(amount){
		local restore = this.health + amount;
		if(restore <= this.max_health){
			this.setHealth(restore);
		} else {
			this.setHealth(this.max_health);
		}
		print(restore);
	}

	function setMana(mana){
		setPlayerMana(this.id, mana);

		this.mana = mana;

		callEvent("onPlayerUpdate", this.id, statupdate.mana);
	}
	function getMana(){
		return this.mana;
	}
	function setMaxMana(max_mana){
		setPlayerMaxMana(this.id, max_mana);

		this.max_mana = max_mana;

		callEvent("onPlayerUpdate", this.id, statupdate.max_mana);
	}
	function getMaxMana(){
		return this.max_mana;
	}
	function restoreMana(amount){
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
		setPlayerStrength(this.id, strength);

		this.strength = strength;

		callEvent("onPlayerUpdate", this.id, statupdate.strength);
	}
	function getStrength(){
		return this.strength;
	}

	function setDexterity(dexterity){
		setPlayerDexterity(this.id, dexterity);

		this.dexterity = dexterity;

		callEvent("onPlayerUpdate", this.id, statupdate.dexterity);
	}
	function getDexterity(){
		return this.dexterity;
	}

	function setOneHandSkill(onehand){
		if(onehand > 100) onehand = 100;

		setPlayerSkillWeapon(this.id, WEAPON_1H, onehand);

		this.onehand = onehand;

		callEvent("onPlayerUpdate", this.id, statupdate.onehand);
	}
	function getOneHandSkill(){
		return this.onehand;
	}

	function setTwoHandSkill(twohand){
		if(twohand > 100) twohand = 100;

		setPlayerSkillWeapon(this.id, WEAPON_2H, twohand);

		this.twohand = twohand;

		callEvent("onPlayerUpdate", this.id, statupdate.twohand);
	}
	function getTwoHandSkill(){
		return this.twohand;
	}

	function setBowSkill(bow){
		if(bow > 100) bow = 100;

		setPlayerSkillWeapon(this.id, WEAPON_BOW, bow);

		this.bow = bow;

		callEvent("onPlayerUpdate", this.id, statupdate.bow);
	}
	function getBowSkill(){
		return this.bow;
	}

	function setCrossbowSkill(crossbow){
		if(crossbow > 100) crossbow= 100;

		setPlayerSkillWeapon(this.id, WEAPON_CBOW, crossbow);

		this.crossbow = crossbow;

		callEvent("onPlayerUpdate", this.id, statupdate.cbow);
	}
	function getCrossbowSkill(){
		return this.crossbow;
	}

	function setMagicCircle(magic_circle){
		if(magic_circle > 7) magic_circle = 7;

		setPlayerMagicLevel(this.id, magic_circle);

		this.magic_circle = magic_circle;

		callEvent("onPlayerUpdate", this.id, statupdate.magic_circle);
	}
	function getMagicCircle(){
		return this.magic_circle;
	}

	function setSneakSkill(level){
		if(level > 5) level = 5;

		if(level == 0){
			setPlayerTalent(this.id, TALENT_SNEAK, false);
		} else setPlayerTalent(this.id, TALENT_SNEAK, true);

		this.sneak = sneak;

		callEvent("onPlayerUpdate", this.id, statupdate.sneaking);
	}
	function getSneakSkill(){
		return this.sneak;
	}

	function setPicklockSkill(level){
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
		this.profession = profession;
	}
	function getProfession(){
		return this.profession;

		callEvent("onPlayerUpdate", this.id, statupdate.profession_name);
	}

	function setProfessionLevel(level){
		this.profession_level = level;
	}
	function getProfessionLevel(){
		return this.profession_level;

		callEvent("onPlayerUpdate", this.id, statupdate.profession_lvl);
	}

	function setProfessionExp(exp){
		this.profession_exp = exp;
	}
	function getProfessionExp(){
		return this.profession_exp;

		callEvent("onPlayerUpdate", this.id, statupdate.profession_exp);
	}

	function setMiningSkill(skill){
		this.mining = skill;

		callEvent("onPlayerUpdate", this.id, statupdate.mining);
	}
	function getMiningSkill(){
		return this.mining;
	}

	function setHuntingSkill(skill){
		this.hunting = skill;

		callEvent("onPlayerUpdate", this.id, statupdate.hunting);
	}
	function getHuntingSkill(){
		return this.hunting;
	}

	function setHerbalismSkill(skill){
		this.herbalism = skill;

		callEvent("onPlayerUpdate", this.id, statupdate.herbalism);
	}
	function getHerbalismSkill(){
		return this.herbalism;
	}

	function setStamina(stamina){
		if(stamina > 100) stamina = 100;

		this.stamina = stamina;

		callEvent("onPlayerUpdate", this.id, statupdate.stamina);
	}
	function getStamina(){
		return this.stamina;
	}
	function restoreStamina(amount){
		local restore = this.stamina + amount;
		if(restore <= 100){
			this.stamina = restore;
		} else {
			this.stamina = 100;
		}
	}

	function setVisual(bodyModel, bodyTexture, headModel, headTexture){
		setPlayerVisual(this.id, bodyModel, bodyTexture, headModel, headTexture);

		this.visual.bm = bodyModel;
		this.visual.bt = bodyTexture;
		this.visual.hm = headModel;
		this.visual.ht = headTexture;
	}
	function getVisual(){
		return this.visual;
	}

	function setScale(x, y, z, fatness){
		x = x.tofloat();
		y = y.tofloat();
		z = z.tofloat();
		local f = fatness.tofloat();

		setPlayerScale(this.id, x, y, z);
		setPlayerFatness(this.id, f);

		this.scale.x = x;
		this.scale.y = y;
		this.scale.z = z;
		this.scale.f = f;
	}
	function getScale(){
		return this.scale;
	}

	function setWalkstyle(walk){
		applyPlayerOverlay(this.id, Mds.id(walk));

		this.walk = walk;
	}
	function getWalkstyle(){
		return this.walk;
	}
	function resetWalkstyle(){
		removePlayerOverlay(this.id, Mds.id(this.walk));

		this.walk = "HUMANS.MDS";
	}

	function setPosition(x, y, z, angle){
		x = x.tofloat();
		y = y.tofloat();
		z = z.tofloat();
		local a = angle.tofloat();

		setPlayerPosition(this.id, x, y, z);
		setPlayerAngle(this.id, a);

		this.pos.x = x;
		this.pos.y = y;
		this.pos.z = z;
		this.pos.a = a;
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
		world = world.toupper();

		if(this.world != world){
			setPlayerWorld(this.id, world);
			this.world = world;
		}
	}
	function getWorld(){
		return this.world;
	}

	function setVirtualWorld(virtual_world){
		setPlayerVirtualWorld(this.id, virtual_world);

		this.virtual_world = virtual_world;
	}
	function getVirtualWorld(){
		return this.virtual_world;
	}


	function setInvisibility(state){
		setPlayerInvisible(this.id, state);

		this.invisible = state;
	}
	function isInvisible(){
		return this.invisible;
	}

	function setWhitelist(state){
		this.whitelist = state;
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

		local visual = this.getVisual();
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
		instance = instance.toupper();

		if(this.items.rawin(instance)){
			this.items[instance].amount += amount;
		} else {
			this.items[instance] <- {instance = instance, amount = amount, equipped = false};
		}

		_giveItem(this.id, Items.id(instance), amount);
	}
	function removeItem(instance, amount){
		instance = instance.toupper();

		if(this.items.rawin(instance)){
			_removeItem(this.id, Items.id(instance), amount);

			if(this.items[instance].amount >= 0){
				this.items[instance].amount -= amount;
			}
			if(this.items[instance].amount <= 0){
				this.items[instance] = null;
			}
		}
	}
	function equipItem(instance){
		instance = instance.toupper();

		if(this.items.rawin(instance)){
			_equipItem(this.id, Items.id(instance));
			this.items[instance].equipped = true;
		}
	}
	function hasItem(instance){
		instance = instance.toupper();

		return this.items.rawin(instance);
	}
	function isItemEquipped(instance){
		instance = instance.toupper();

		if(this.items.rawin(instance)){
			return this.items[instance].equipped;
		} else return null;
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


	function doesExist(){
		this.setSerial(getPlayerSerial(this.id));
		this.setUID(getPlayerUID(this.id));

		if(MySQL.isConnectedToDB()){
			local result = MySQL.query("SELECT * FROM Players WHERE UID = '" + this.uid + "'");
			if(result != null){
				local row = MySQL.fetchAssoc(result);
				MySQL.freeResult(result);
				if(row != null){
					this.setLogin(row.Login);
					this.setPassword(row.Password);
					return true;
				}
			} else return false;
		} else {
			local myfile = io.file("database/" + this.uid + ".acc", "r");
			if(myfile.isOpen){
				this.login = myfile.read(io_type.LINE);
				this.password = myfile.read(io_type.LINE);
				myfile.close();
				return true;
			} else return false;
		}
	}

	function save(){
		if(!this.isLogged()) return;

		if(MySQL.isConnectedToDB()){
			local result = MySQL.query("SELECT * FROM Players WHERE Login = '" + this.login + "'");
			local row = MySQL.fetchAssoc(result);
			MySQL.freeResult(result);

			if(row == null){
				MySQL.insert("Players", {
					Login = this.login,
					Password = this.password,

					Serial = this.serial,
					UID = this.uid,

					FirstLogin = format("%04d-%02d-%02d %02d:%02d:%02d", date().year, date().month, date().day, date().hour, date().min, date().sec),
					LastLogin = format("%04d-%02d-%02d %02d:%02d:%02d", date().year, date().month, date().day, date().hour, date().min, date().sec),

					Perms = this.permissions,
					Color = this.getColorHex(),

					Name = this.name,
					Description = this.description,

					Instance = this.instance,
					Class_ID = this.class_id,

					Level = this.level,
					Experience = this.experience,
					LearnPoints = this.learnpoints,
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

					MagicCircle = this.magic_circle,

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

					WalkStyle = this.walk,

					Position_X = this.getPosition().x,
					Position_Y = this.getPosition().y,
					Position_Z = this.getPosition().z,
					Position_A = this.getPosition().a,

					World = this.world,
					World_Virtual = this.virtual_world,

					Invisible = this.invisible,
					Whitelist = this.whitelist,
					Gained_Exp = this.gained_exp,
					CK = this.ck
				});
				foreach(item in this.items){
					MySQL.insert("Player_Items", {
						UID = this.uid,
						Instance = item.instance,
						Amount = item.amount,
						Equipped = item.equipped
					});
				}
			} else {
				MySQL.update("Players", "Login", this.login, {
					Password = this.password,

					Serial = this.serial,
					UID = this.uid,

					LastLogin = format("%04d-%02d-%02d %02d:%02d:%02d", date().year, date().month, date().day, date().hour, date().min, date().sec),

					Perms = this.permissions,
					Color = this.getColorHex(),

					Name = this.name,
					Description = this.description,

					Instance = this.instance,
					Class_ID = this.class_id,

					Level = this.level,
					Experience = this.experience,
					LearnPoints = this.learnpoints,
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

					MagicCircle = this.magic_circle,

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

					WalkStyle = this.walk,

					Position_X = this.getPosition().x,
					Position_Y = this.getPosition().y,
					Position_Z = this.getPosition().z,
					Position_A = this.getPosition().a,

					World = this.world,
					World_Virtual = this.virtual_world,

					Invisible = this.invisible,
					Whitelist = this.whitelist,
					Gained_Exp = this.gained_exp,
					CK = this.ck
				});
				MySQL.query("DELETE FROM Player_Items WHERE UID = '" + this.uid + "'");
				foreach(item in this.items){
					MySQL.insert("Player_Items", {
						UID = this.uid,
						Instance = item.instance,
						Amount = item.amount,
						Equipped = item.equipped
					});
				}
			}
		} else {
			local myfile = io.file("database/" + this.uid + ".acc", "w+");

			if(myfile.isOpen){
				myfile.write(this.getLogin() + "\n");
				myfile.write(this.getPassword() + "\n");
				myfile.write(this.getSerial() + "\n");
				myfile.write(this.getUID() + "\n");
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
			local result = MySQL.query("SELECT * FROM Players WHERE Login = '" + this.login + "'");

			if(result){
				local row = MySQL.fetchAssoc(result);
				MySQL.freeResult(result);

				if(row != null){
					this.setPassword(row.Password),
					this.setPermissions(row.Perms),

					this.setColorHex(row.Color),

					this.setName(row.Name),
					this.setDescription(row.Description),

					this.setInstance(row.Instance),
					this.class_id = row.Class_ID,

					this.setLevel(row.Level),
					this.setExperience(row.Experience),
					this.setLearnPoints(row.LearnPoints),
					this.setGuild(row.Guild),

					this.setHealth(row.Health),
					this.setMaxHealth(row.Health_Max),
					this.setMana(row.Mana),
					this.setMaxMana(row.Mana_Max),
					this.setStrength(row.Strength),
					this.setDexterity(row.Dexterity),
					this.setOneHandSkill(row.Skill_OneHand),
					this.setTwoHandSkill(row.Skill_TwoHand),
					this.setBowSkill(row.Skill_Bow),
					this.setCrossbowSkill(row.Skill_Crossbow),

					this.setMagicCircle(row.MagicCircle),

					this.setSneakSkill(row.Talent_Sneak),
					this.setPicklockSkill(row.Talent_Picklock),
					this.setPickpocketSkill(row.Talent_Pickpocket),
					this.setRuneSkill(row.Talent_Runemaking),
					this.setAlchemySkill(row.Talent_Alchemy),
					this.setSmithSkill(row.Talent_Smith),
					this.setTrophySkill(row.Talent_Trophy),
					this.setAcrobaticSkill(row.Talent_Acrobatic),

					this.setProfession(row.Profession),
					this.setProfessionLevel(row.Profession_Level),
					this.setProfessionExp(row.Profession_Exp),

					this.setMiningSkill(row.Skill_Mining),
					this.setHuntingSkill(row.Skill_Hunting),
					this.setHerbalismSkill(row.Skill_Herbalism),

					this.setStamina(row.Stamina),

					this.setVisual(row.Visual_BodyModel, row.Visual_BodyTexture, row.Visual_HeadModel, row.Visual_HeadTexture),

					this.setScale(row.Visual_Scale_X, row.Visual_Scale_Y, row.Visual_Scale_Z, row.Visual_Fatness),

					this.setPosition(row.Position_X, row.Position_Y, row.Position_Z, row.Position_A),

					this.setWorld(row.World),
					this.setVirtualWorld(row.World_Virtual),

					this.invisible = row.Invisible,
					this.whitelist = row.Whitelist,
					this.gained_exp = row.Gained_Exp,
					this.ck = row.CK
				}
			}

			local result_items = MySQL.query("SELECT * FROM Player_Items WHERE UID = '" + this.uid + "'");
			local result_items_arr = [];
			for(local i = 0, end = MySQL.numRows(result_items); i < end; i++){
				result_items_arr.append(MySQL.fetchAssoc(result_items));
			}
				MySQL.freeResult(result_items);
			foreach(item in result_items_arr){
				this.giveItem(item.Instance, item.Amount);
				if(item.Equipped == 1) this.equipItem(item.Instance);
			}
		} else {
			local myfile = io.file("database/" + this.uid + ".acc", "r");
			if(myfile.isOpen){
				local login = myfile.read(io_type.LINE);
				local passwd = myfile.read(io_type.LINE);
				local serial = myfile.read(io_type.LINE);
				local uid = myfile.read(io_type.LINE);
				if(login == this.login && passwd == this.password && serial == this.serial && uid == this.uid){
					this.setPermissions(myfile.read(io_type.LINE).tointeger())
						local color = sscanf("ddd", myfile.read(io_type.LINE));
					this.setColor(color[0], color[1], color[2]);
					this.setName(myfile.read(io_type.LINE));
					this.setDescription(myfile.read(io_type.LINE));
					this.setInstance(myfile.read(io_type.LINE));
					this.class_id = myfile.read(io_type.LINE).tointeger();
					this.setLevel(myfile.read(io_type.LINE).tointeger());
					this.setExperience(myfile.read(io_type.LINE).tointeger());
					this.setLearnPoints(myfile.read(io_type.LINE).tointeger());
					this.setGuild(myfile.read(io_type.LINE));
					this.setHealth(myfile.read(io_type.LINE).tointeger());
					this.setMaxHealth(myfile.read(io_type.LINE).tointeger());
					this.setMana(myfile.read(io_type.LINE).tointeger());
					this.setMaxMana(myfile.read(io_type.LINE).tointeger());
					this.setStrength(myfile.read(io_type.LINE).tointeger());
					this.setDexterity(myfile.read(io_type.LINE).tointeger());
					this.setOneHandSkill(myfile.read(io_type.LINE).tointeger());
					this.setTwoHandSkill(myfile.read(io_type.LINE).tointeger());
					this.setBowSkill(myfile.read(io_type.LINE).tointeger());
					this.setCrossbowSkill(myfile.read(io_type.LINE).tointeger());
					this.setMagicCircle(myfile.read(io_type.LINE).tointeger());
					this.setSneakSkill(myfile.read(io_type.LINE).tointeger());
					this.setPicklockSkill(myfile.read(io_type.LINE).tointeger());
					this.setPickpocketSkill(myfile.read(io_type.LINE).tointeger());
					this.setRuneSkill(myfile.read(io_type.LINE).tointeger());
					this.setAlchemySkill(myfile.read(io_type.LINE).tointeger());
					this.setSmithSkill(myfile.read(io_type.LINE).tointeger());
					this.setTrophySkill(myfile.read(io_type.LINE).tointeger());
					this.setAcrobaticSkill(myfile.read(io_type.LINE).tointeger());
					this.setProfession(myfile.read(io_type.LINE));
					this.setProfessionLevel(myfile.read(io_type.LINE).tointeger());
					this.setProfessionExp(myfile.read(io_type.LINE).tointeger());
					this.setMiningSkill(myfile.read(io_type.LINE).tointeger());
					this.setHuntingSkill(myfile.read(io_type.LINE).tointeger());
					this.setHerbalismSkill(myfile.read(io_type.LINE).tointeger());
					this.setStamina(myfile.read(io_type.LINE).tointeger());
						local vis = sscanf("sdsd", myfile.read(io_type.LINE));
					this.setVisual(vis[0], vis[1], vis[2], vis[3]);
						local scale = sscanf("ffff", myfile.read(io_type.LINE));
					this.setScale(scale[0], scale[1], scale[2], scale[3]);
					this.setWalkstyle(myfile.read(io_type.LINE));
						local pos = sscanf("ffff", myfile.read(io_type.LINE));
					this.setPosition(pos[0], pos[1], pos[2], pos[3]);
					this.setWorld(myfile.read(io_type.LINE));
					this.setVirtualWorld(myfile.read(io_type.LINE).tointeger());
					this.setInvisibility(toBool(myfile.read(io_type.LINE)));
					this.setWhitelist(toBool(myfile.read(io_type.LINE)));
				}
			myfile.close();
			}
		}
		this.bulkSendStats();
	}
}

addEventHandler("onPlayerJoin", function(pid){
	Players[pid] <- Player(pid);
});

addEventHandler("onPlayerDisconnect", function(pid, reason){
	Players[pid].save();
	Players.rawdelete(pid);
});

addEventHandler("onPlayerDead", function(pid, kid){
	Players[pid].unspawn();
});

addEventHandler("onPlayerRespawn", function(pid){
	Players[pid].respawn();
});