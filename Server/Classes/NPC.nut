local _giveItem = giveItem;
local _removeItem = removeItem;
local _equipItem = equipItem;
local _createNpc = createNpc;

NPCs <- {};
class NPC {
	id = null;

	uid = null;

	color = {r = null, g = null, b = null};

	name = null;
	description = null;

	instance = null;
	class_id = null;

	level = null;
	guild = null;

	health = null;
	max_health = null;
	mana = null;
	max_mana = null;
	strength = null;
	dexterity = null;
	onehand = null;
	twohand = null;
	bow = null;
	crossbow = null;

	magic_circle = null;

	sneak = null;
	acrobatic = null;

	visual = {bm = null, bt = null, hm = null, ht = null};
	scale = {x = null, y = null, z = null, f = null};
	walk = null;
	pos = {x = null, y = null, z = null, a = null};

	world = null;
	virtual_world = null;

	constructor(id) {
		this.id = id;

		NPCs[this.id] <- this;
	}

	function setUID(){
		this.uid = sha512((this.id).tostring());
	}
	function getUID(){
		return this.uid;
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
	}
	function getInstance(){
		return this.instance;
	}

	function setLevel(level){
		this.level = level;
	}
	function getLevel(){
		return this.level;
	}

	function setGuild(guild){
		this.guild = guild;
	}
	function getGuild(){
		return this.guild;
	}

	function setHealth(health){
		setPlayerHealth(this.id, health);

		this.health = health;
	}
	function getHealth(){
		return this.health;
	}
	function setMaxHealth(max_health){
		setPlayerMaxHealth(this.id, max_health);

		this.max_health = max_health;
	}
	function getMaxHealth(){
		return this.max_health;
	}

	function setMana(mana){
		setPlayerMana(this.id, mana);

		this.mana = mana;
	}
	function getMana(){
		return this.mana;
	}
	function setMaxMana(max_mana){
		setPlayerMaxMana(this.id, max_mana);

		this.max_mana = max_mana;
	}
	function getMaxMana(){
		return this.max_mana;
	}

	function setStrength(strength){
		setPlayerStrength(this.id, strength);

		this.strength = strength;
	}
	function getStrength(){
		return this.strength;
	}

	function setDexterity(dexterity){
		setPlayerDexterity(this.id, dexterity);

		this.dexterity = dexterity;
	}
	function getDexterity(){
		return this.dexterity;
	}

	function setOneHandSkill(onehand){
		if(onehand > 100) onehand = 100;

		setPlayerSkillWeapon(this.id, WEAPON_1H, onehand);

		this.onehand = onehand;
	}
	function getOneHandSkill(){
		return this.onehand;
	}

	function setTwoHandSkill(twohand){
		if(twohand > 100) twohand = 100;

		setPlayerSkillWeapon(this.id, WEAPON_2H, twohand);

		this.twohand = twohand;
	}
	function getTwoHandSkill(){
		return this.twohand;
	}

	function setBowSkill(bow){
		if(bow > 100) bow = 100;

		setPlayerSkillWeapon(this.id, WEAPON_BOW, bow);

		this.bow = bow;
	}
	function getBowSkill(){
		return this.bow;
	}

	function setCrossbowSkill(crossbow){
		if(cbow > 100) cbow = 100;

		setPlayerSkillWeapon(this.id, WEAPON_CBOW, crossbow);

		this.crossbow = crossbow;
	}
	function getCrossbowSkill(){
		return this.crossbow;
	}

	function setMagicCircle(magic_circle){
		if(magic_circle > 7) magic_circle = 7;

		setPlayerMagicLevel(this.id, magic_circle);

		this.magic_circle = magic_circle;
	}
	function getMagicCircle(){
		return this.magic_circle;
	}

	function setSneakSkill(sneak){
		setPlayerTalent(this.id, TALENT_SNEAK, sneak);

		this.sneak = sneak;
	}
	function getSneakSkill(){
		return this.sneak;
	}

	function setAcrobaticSkill(acrobatic){
		setPlayerTalent(this.id, TALENT_ACROBATIC, acrobatic);

		this.acrobatic = acrobatic;
	}
	function getAcrobaticSkill(){
		return this.acrobatic;
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

	function isConnected(){
		return isPlayerConnected(this.id);
	}

	function isDead(){
		return isPlayerDead(this.id);
	}

	function isUnconscious(){
		return isPlayerUnconscious(this.id);
	}

	function getClass(){
		return this.class_id;
	}


	function respawn(){
		spawnNPC(this.id);

		local visual = this.getVisual();
		this.setVisual(this.visual.bm, this.visual.bt, this.visual.hm, this.visual.ht);

		local class_pos = classes[this.class_id].spawn;
		this.setPosition(class_pos.x, class_pos.y, class_pos.z, class_pos.a);
	}
	function spawn(){
		spawnNPC(this.id);

		local visual = this.getVisual();
		this.setVisual(this.visual.bm, this.visual.bt, this.visual.hm, this.visual.ht);
	}
	function unspawn(){
		unspawnNPC(this.id);
	}
	function isSpawned(){
		return isPlayerSpawned(this.id);
	}

	function createNPC(name, instance, color_hex, class_id, level, bm, bt, hm, ht, scale){
		this.id = _createNpc(name);

		this.setName(name);
		this.setInstance(instance);
		this.setColorHex(color_hex);

		if(class_id <= classes.len() && class_id >= 0){
			classes[class_id].func(this.id);

			this.setGuild(classes[class_id].guild);
			this.class_id = class_id;
		}

		this.setLevel(level);

		this.setHealth(this.health + (this.level * 0.5));
		this.setMaxHealth(this.max_health + (this.level * 0.5));
		this.setMana(this.mana + (this.level * 0.5));
		this.setMaxMana(this.max_mana + (this.level * 0.5));
		this.setStrength(this.strength + (this.level * 0.5));
		this.setDexterity(this.dexterity + (this.level * 0.5));
		this.setOneHandSkill(this.onehand + (this.level * 0.5));
		this.setTwoHandSkill(this.twohand + (this.level * 0.5));
		this.setBowSkill(this.bow + (this.level * 0.5));
		this.setCrossbowSkill(this.cbow + (this.level * 0.5));

		this.setSneakSkill(false);
		this.setAcrobaticSkill(false);

		this.setVisual(bm, ht, hm, ht);
		this.setScale(scale, scale, scale, scale);
		this.setWalkstyle("HUMANS.MDS");
		this.setPosition(0.0, 0.0, 0.0, 0.0);

		this.world = "NEWWORLD\\NEWWORLD.ZEN";
		this.virtual_world = virtualworlds.TESTING;

		this.spawn();
	}


	function save(){
		local result = MySQL.query("SELECT * FROM npcs WHERE uid = '" + this.uid + "'");

		if(!result){
			MySQL.insert("npcs", {
				uid = this.uid,

				color_r = this.color.r,
				color_g = this.color.g,
				color_b = this.color.b,

				name = this.name,

				instance = this.instance,
				class_id = this.class_id,

				level = this.level,
				guild = this.guild,

				health = this.health,
				max_health = this.max_health,
				mana = this.mana,
				max_mana = this.max_mana,
				strength = this.strength,
				dexterity = this.dexterity,
				onehand = this.onehand,
				twohand = this.twohand,
				bow = this.bow,
				crossbow = this.crossbow,

				magic_circle = this.magic_circle,

				sneak = this.sneak,
				acrobatic = this.acrobatic,

				visual_bm = this.visual.bm,
				visual_bt = this.visual.bt,
				visual_hm = this.visual.hm,
				visual_ht = this.visual.ht,

				scale_x = this.scale.x,
				scale_y = this.scale.y,
				scale_z = this.scale.z,
				scale_f = this.scale.f,

				walk = this.walk,

				pos_x = this.pos.x,
				pos_y = this.pos.y,
				pos_z = this.pos.z,
				pos_a = this.pos.a,

				world = this.world,
				virtual_world = this.virtual_world
			});
		} else {
			MySQL.update("npcs", "uid", this.uid, {
				color_r = this.color.r,
				color_g = this.color.g,
				color_b = this.color.b,

				name = this.name,

				instance = this.instance,
				class_id = this.class_id,

				level = this.level,
				guild = this.guild,

				health = this.health,
				max_health = this.max_health,
				mana = this.mana,
				max_mana = this.max_mana,
				strength = this.strength,
				dexterity = this.dexterity,
				onehand = this.onehand,
				twohand = this.twohand,
				bow = this.bow,
				crossbow = this.crossbow,

				magic_circle = this.magic_circle,

				sneak = this.sneak,
				acrobatic = this.acrobatic,

				visual_bm = this.visual.bm,
				visual_bt = this.visual.bt,
				visual_hm = this.visual.hm,
				visual_ht = this.visual.ht,

				scale_x = this.scale.x,
				scale_y = this.scale.y,
				scale_z = this.scale.z,
				scale_f = this.scale.f,

				walk = this.walk,

				pos_x = this.pos.x,
				pos_y = this.pos.y,
				pos_z = this.pos.z,
				pos_a = this.pos.a,

				world = this.world,
				virtual_world = this.virtual_world
			});
		}
	}

	function load(){
		local result = MySQL.query("SELECT * FROM npcs WHERE uid = '" + this.uid + "'");

		if(result){
			local row = MySQL.fetchAssoc(result);
			MySQL.freeResult(result);

			if(row != null){
				this.setColor(row.color_r, row.color_g, row.color_b),

				this.setName(row.name),
				this.setInstance(row.instance),

				this.class_id = row.class_id,

				this.setLevel(row.level),
				this.setGuild(row.guild),

				this.setHealth(row.health),
				this.setMaxHealth(row.max_health),
				this.setMana(row.mana),
				this.setMaxMana(row.max_mana),
				this.setStrength(row.strength),
				this.setDexterity(row.dexterity),
				this.setOneHandSkill(row.onehand),
				this.setTwoHandSkill(row.twohand),
				this.setBowSkill(row.bow),
				this.setCrossbowSkill(row.crossbow),

				this.setMagicCircle(row.magic_circle),

				this.setSneakSkill(row.sneak),
				this.setAcrobaticSkill(row.acrobatic),

				this.setVisual(row.visual_bm, row.visual_bt, row.visual_hm, row.visual_ht),

				this.setScale(row.scale_x, row.scale_y, row.scale_z, row.scale_f),

				this.setPosition(row.pos_x, row.pos_y, row.pos_z, row.pos_a),

				this.setWorld(row.world),
				this.setVirtualWorld(row.virtual_world)
			}
		}
	}
}

addEventHandler("onNPCCreate", function(nid){
	NPCs[nid] <- NPC(nid);
	spawnNPC(nid);
});

addEventHandler("onNPCDestroy", function(nid, reason){
	NPCs.rawdelete(nid);
});

addEventHandler("onNPCDead", function(nid, kid){
	NPCs[nid].unspawn();
});

addEventHandler("onNPCRespawn", function(nid){
	NPCs[nid].respawn();
});