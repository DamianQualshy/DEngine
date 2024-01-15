local _giveItem = giveItem;
local _removeItem = removeItem;
local _equipItem = equipItem;
local _createNpc = createNpc;

NPCs <- {};
class NPC {
	id = -1;
	db_id = -1;

	color = {r = 0, g = 0, b = 0};

	name = "";

	voice = -1;
	npc_type = -1;
	fight_tactic = -1;
	daily_routine = -1;

	instance = "PC_HERO";
	class_id = 0;

	level = 1;
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

	visual = {bm = "HUM_BODY_NAKED0", bt = 8, hm = "HUM_HEAD_PONY", ht = 18};
	scale = {x = 1.0, y = 1.0, z = 1.0, f = 1.0};
	walk = "HUMANS.MDS";
	pos = {x = 0.0, y = 0.0, z = 0.0, a = 0.0};

	world = "NEWWORLD\\NEWWORLD.ZEN";
	virtual_world = virtualworlds.VOID;

	spawnpos = {x = 0.0, y = 0.0, z = 0.0, a = 0.0};

	items = {};

	constructor(id) {
		this.id = id;

		NPCs[this.id] <- this;
	}

	function setDatabaseID(_id){
		this.db_id = _id;
	}
	function getDatabaseID(){
		return this.db_id;
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

	function setInstance(instance){
		this.instance = convert(instance, "string");

		setPlayerInstance(this.id, this.instance);
	}
	function getInstance(){
		return this.instance;
	}

	function setClass(class_id){
		class_id = convert(class_id, "integer");

		if(class_id <= classesNPC.len() && class_id >= 0){
			classesNPC[class_id].func(this.id);

			this.setGuild(classesNPC[class_id].guild);
			this.class_id = class_id;
		}
	}
	function getClass(){
		return this.class_id;
	}

	function setLevel(level){
		this.level = convert(level, "integer");
	}
	function getLevel(){
		return this.level;
	}

	function setGuild(guild){
		this.guild = convert(guild, "string");
	}
	function getGuild(){
		return this.guild;
	}

	function setHealth(health){
		this.health = convert(health, "integer");

		setPlayerHealth(this.id, this.health);
	}
	function getHealth(){
		return this.health;
	}
	function setMaxHealth(max_health){
		this.max_health = convert(max_health, "integer");

		setPlayerMaxHealth(this.id, this.max_health);
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
	}
	function getMana(){
		return this.mana;
	}
	function setMaxMana(max_mana){
		this.max_mana = convert(max_mana, "integer");

		setPlayerMaxMana(this.id, this.max_mana);
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
	}
	function getStrength(){
		return this.strength;
	}

	function setDexterity(dexterity){
		this.dexterity = convert(dexterity, "integer");

		setPlayerDexterity(this.id, this.dexterity);
	}
	function getDexterity(){
		return this.dexterity;
	}

	function setOneHandSkill(onehand){
		onehand = convert(onehand, "integer");

		if(onehand > 100) onehand = 100;
		this.onehand = onehand;

		setPlayerSkillWeapon(this.id, WEAPON_1H, onehand);
	}
	function getOneHandSkill(){
		return this.onehand;
	}

	function setTwoHandSkill(twohand){
		twohand = convert(twohand, "integer");

		if(twohand > 100) twohand = 100;
		this.twohand = twohand;

		setPlayerSkillWeapon(this.id, WEAPON_2H, this.twohand);
	}
	function getTwoHandSkill(){
		return this.twohand;
	}

	function setBowSkill(bow){
		bow = convert(bow, "integer");

		if(bow > 100) bow = 100;
		this.bow = bow;

		setPlayerSkillWeapon(this.id, WEAPON_BOW, this.bow);
	}
	function getBowSkill(){
		return this.bow;
	}

	function setCrossbowSkill(crossbow){
		crossbow = convert(crossbow, "integer");

		if(crossbow > 100) crossbow= 100;
		this.crossbow = crossbow;

		setPlayerSkillWeapon(this.id, WEAPON_CBOW, this.crossbow);
	}
	function getCrossbowSkill(){
		return this.crossbow;
	}

	function setMagicCircle(magic_circle){
		magic_circle = convert(magic_circle, "integer");

		if(magic_circle > 7) magic_circle = 7;
		this.magic_circle = magic_circle;

		setPlayerMagicLevel(this.id, this.magic_circle);
	}
	function getMagicCircle(){
		return this.magic_circle;
	}

	function setVisual(bodyModel, bodyTexture, headModel, headTexture){
		local bm = convert(bodyModel, "string");
		local bt = convert(bodyTexture, "integer");
		local hm = convert(headModel, "string");
		local ht = convert(headTexture, "integer");

		if(bm == "HUM_BODY_NAKED0"
			&& bt == 8
			&& hm == "HUM_HEAD_PONY"
			&& ht == 18){
				local randRace = rand() % 4;
				local randBody = rand() % bodies[creator_gender.MALE][randRace].len();
				local randHead = rand() % heads[creator_gender.MALE].len();
				local randFace = rand() % faces[creator_gender.MALE][randRace].len();

				hm = heads[creator_gender.MALE][randHead];

				local pickFace = faces[creator_gender.MALE][randRace][randFace];
				local vPos = pickFace.find("V");
				local c0Pos = pickFace.find("_C0.TGA");
				if (vPos != -1 && c0Pos != -1) {
					local substring = pickFace.slice(vPos + 1, c0Pos);
					local parts = split(substring, "_");
					ht = parts[0].tointeger();
				}

				local pickBody = bodies[creator_gender.MALE][randRace][randBody];
				local vPos = pickBody.find("V");
				local c0Pos = pickBody.find("_C0.TGA");
				if (vPos != -1 && c0Pos != -1) {
					local substring = pickBody.slice(vPos + 1, c0Pos);
					local parts = split(substring, "_");
					bt = parts[0].tointeger();
				}
		}

		this.visual.bm = bm;
		this.visual.bt = bt;
		this.visual.hm = hm;
		this.visual.ht = ht;

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

	function setSpawn(x, y, z, angle){
		this.spawnpos.x = convert(x, "float");
		this.spawnpos.y = convert(y, "float");
		this.spawnpos.z = convert(z, "float");
		this.spawnpos.a = convert(angle, "float");
	}
	function getSpawn(){
		return this.spawnpos;
	}

	function isDead(){
		return isPlayerDead(this.id);
	}

	function isUnconscious(){
		return isPlayerUnconscious(this.id);
	}

	function respawn(){
		spawnPlayer(this.id);

		this.setClass(this.class_id);

		this.setVisual(this.visual.bm, this.visual.bt, this.visual.hm, this.visual.ht);

		this.setPosition(this.spawnpos.x, this.spawnpos.y, this.spawnpos.z, this.spawnpos.a);
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

		if(this.items.rawin(instance)){
			this.items[instance].amount += amount;
		} else {
			this.items[instance] <- {instance = instance, amount = amount, equipped = false};
		}

		_giveItem(this.id, instance, amount);
	}
	function removeItem(instance, amount){
		instance = convert(instance, "string").toupper();
		amount = convert(amount, "integer");

		if(this.items.rawin(instance)){
			_removeItem(this.id, instance, amount);

			if(this.items[instance].amount >= 0){
				this.items[instance].amount -= amount;
			}
			if(this.items[instance].amount <= 0){
				this.items[instance] = null;
			}
		}
	}
	function equipItem(instance){
		instance = convert(instance, "string").toupper();

		if(this.items.rawin(instance)){
			_equipItem(this.id, instance);
			this.items[instance].equipped = true;
		}
	}
	function hasItem(instance){
		return this.items.rawin(convert(instance, "string").toupper());
	}
	function isItemEquipped(instance){
		instance = convert(instance, "string").toupper();

		if(this.items.rawin(instance)){
			return this.items[instance].equipped;
		} else return null;
	}


	function doesExist(){
		if(MySQL.isConnectedToDB()){
			local result = MySQL.query("SELECT * FROM NPCs WHERE ID = '" + this.db_id + "'");
			if(result != null){
				local row = MySQL.fetchAssoc(result);
				MySQL.freeResult(result);
				if(row != null){
					return true;
				}
			} else {
				return false;
			}
		}
	}

	function findNPCThroughDatabaseID(_id){
		if(_id == this.getDatabaseID()){
			return true;
		} else return false;
	}

	function save(){
		if(MySQL.isConnectedToDB()){
			local result = MySQL.query("SELECT * FROM NPCs WHERE ID = '" + this.db_id + "'");
			local row = MySQL.fetchAssoc(result);
			MySQL.freeResult(result);

			if(row == null){
				MySQL.insert("NPCs", {
					Color = this.getColorHex(),

					Name = this.name,

					Instance = this.instance,
					Class_ID = this.class_id,

					Level = this.level,
					Guild = this.guild,

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

					Spawn_X = this.getSpawn().x,
					Spawn_Y = this.getSpawn().y,
					Spawn_Z = this.getSpawn().z,
					Spawn_A = this.getSpawn().a,

					World = this.world,
					World_Virtual = this.virtual_world
				});

				local result_id = MySQL.query("SELECT * FROM NPCs");
				this.setDatabaseID(MySQL.numRows(result_id));
				MySQL.freeResult(result_id);
			} else {
				MySQL.update("NPCs", "ID", this.db_id.tostring(), {
					Color = this.getColorHex(),

					Name = this.name,

					Instance = this.instance,
					Class_ID = this.class_id,

					Level = this.level,
					Guild = this.guild,

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

					Spawn_X = this.getSpawn().x,
					Spawn_Y = this.getSpawn().y,
					Spawn_Z = this.getSpawn().z,
					Spawn_A = this.getSpawn().a,

					World = this.world,
					World_Virtual = this.virtual_world
				});
			}
		}
	}

	function load(){
		if(MySQL.isConnectedToDB()){
			local result = MySQL.query("SELECT * FROM NPCs WHERE ID = '" + this.db_id + "'");

			if(result){
				local row = MySQL.fetchAssoc(result);
				MySQL.freeResult(result);

				if(row != null){
					this.setColorHex(row.Color);

					this.setName(row.Name);

					this.setInstance(row.Instance);
					this.setClass(row.Class_ID);

					this.setLevel(row.Level);
					this.setGuild(row.Guild);

					this.setWalkstyle(row.Walk_Style);

					this.setVisual(row.Visual_BodyModel, row.Visual_BodyTexture, row.Visual_HeadModel, row.Visual_HeadTexture);

					this.setScale(row.Visual_Scale_X, row.Visual_Scale_Y, row.Visual_Scale_Z, row.Visual_Fatness);

					this.setWorld(row.World);
					this.setPosition(row.Position_X, row.Position_Y, row.Position_Z, row.Position_A);

					this.setSpawn(row.Spawn_X, row.Spawn_Y, row.Spawn_Z, row.Spawn_A);

					this.setVirtualWorld(row.World_Virtual);
				}
			}
		}
	}
}

function createNPC(npc){
	local nid = _createNpc(npc.Name, npc.Instance);
	NPCs[nid] <- NPC(nid);

	if(npc.ID != -1) NPCs[nid].setDatabaseID(npc.ID);

	if(!NPCs[nid].doesExist()){
		NPCs[nid].setName(npc.Name);
		NPCs[nid].setInstance(npc.Instance);

		NPCs[nid].setColor(255, 255, 255);

		NPCs[nid].setClass(npc.class_id);
		NPCs[nid].setLevel(npc.level);

		NPCs[nid].setWalkstyle(npc.walkstyle);
		NPCs[nid].setVisual(npc.visual.bm, npc.visual.bt, npc.visual.hm, npc.visual.ht);
		NPCs[nid].setScale(npc.scale.x, npc.scale.y, npc.scale.z, npc.scale.f);

		NPCs[nid].setWorld(npc.world);
		NPCs[nid].setPosition(npc.spawnpos.x, npc.spawnpos.y, npc.spawnpos.z, npc.spawnpos.a);

		NPCs[nid].setSpawn(npc.spawnpos.x, npc.spawnpos.y, npc.spawnpos.z, npc.spawnpos.a);
		NPCs[nid].setVirtualWorld(npc.virtual_world);

		NPCs[nid].save();
	} else {
		NPCs[nid].load();
	}

	NPCs[nid].spawn();

	callEvent("onNPCCreate", nid);
}

function destroyNPC(nid){
	NPCs[nid].unspawn();

	NPCs[nid].save();
	NPCs[nid].items.clear();

	destroyNpc(nid);

	callEvent("onNPCDestroy", nid);
}

addEventHandler("onInit", function(){
	local result = MySQL.query("SELECT * FROM NPCs");
	local row = MySQL.fetchAssoc(result);
	local result_npcs = [];

	if(row != null){
		for(local i = 0, end = MySQL.numRows(result); i < end; i++){
			result_npcs.append(MySQL.fetchAssoc(result));
		}
		MySQL.freeResult(result);
		for(local i = 0, end = result_npcs.len(); i < end; i++){
			if(result_npcs[i] == null) break;

			createNPC(result_npcs[i]);
		}
	} else {
		for(local i = 0, end = nonPlayables.len(); i < end; i++){
			createNPC(nonPlayables[i]);
		}
	}
});

addEventHandler("onExit", function(){
	/* foreach(npc in NPCs){
		destroyNPC(npc.id);
	} */
});

addEventHandler("onNPCCreate", function(nid){
	//print("created npc " + NPCs[nid].getName() + " with DB id " + NPCs[nid].db_id);
});

addEventHandler("onNPCDestroy", function(nid){
	//print("deleted npc " + NPCs[nid].getName() + " with DB id " + NPCs[nid].db_id);
	NPCs.rawdelete(nid);
});

addEventHandler("onPlayerSpawn", function(nid){
	if(!isNpc(nid)) return;

	NPCs[nid].spawn();
});

addEventHandler("onPlayerRespawn", function(nid){
	if(!isNpc(nid)) return;

	NPCs[nid].respawn();
});