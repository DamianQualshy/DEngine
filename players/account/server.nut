Players <- {};
class Player {
	id = null;

	username = null;
	password = null;
	permissions = null;
	color = {r = null, g = null, b = null};

	instance = null;

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
	picklock = null;
	pickpocket = null;
	runes = null;
	alchemy = null;
	smith = null;
	trophy = null;
	acrobatic = null;

	vis = {bm = null, bt = null, hm = null, ht = null};
	scale = {x = null, y = null, z = null, f = null};
	walk = null;
	pos = {x = null, y = null, z = null, a = null};

	items = {};

	logged = null;
	afk = null;
	invisible = null;
	whitelist = null;

	constructor(id) {
		this.id = id;

		Players[this.id] <- this;
	}

	function setUsername(name){
		setPlayerName(this.id, name);

		this.username = name;
	}
	function getUsername(){
		return this.username;
	}

	function setPassword(pass){
		this.password = md5(pass);
	}
	function getPassword(){
		return this.password;
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
	}
	function getColor(){
		return this.color;
	}
	function getColorHex(){
		local rgb = this.color;
		local hex = rgbToHex(rgb.r, rgb.g, rgb.b);

		return hex;
	}

	function setInstance(instance){
		setPlayerInstance(this.id, instance);

		this.instance = instance;
	}
	function getInstance(){
		return this.instance;
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
		setPlayerSkillWeapon(this.id, WEAPON_1H, onehand);

		this.onehand = onehand;
	}
	function getOneHandSkill(){
		return this.onehand;
	}

	function setTwoHandSkill(twohand){
		setPlayerSkillWeapon(this.id, WEAPON_2H, twohand);

		this.twohand = twohand;
	}
	function getTwoHandSkill(){
		return this.twohand;
	}

	function setBowSkill(bow){
		setPlayerSkillWeapon(this.id, WEAPON_BOW, bow);

		this.bow = bow;
	}
	function getBowSkill(){
		return this.bow;
	}

	function setCrossbowSkill(crossbow){
		setPlayerSkillWeapon(this.id, WEAPON_CBOW, crossbow);

		this.crossbow = crossbow;
	}
	function getCrossbowSkill(){
		return this.crossbow;
	}

	function setMagicCircle(magic_circle){
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

	function setPicklockSkill(picklock){
		setPlayerTalent(this.id, TALENT_PICK_LOCKS, picklock);

		this.picklock = picklock;
	}
	function getPicklockSkill(){
		return this.picklock;
	}

	function setPickpocketSkill(pickpocket){
		setPlayerTalent(this.id, TALENT_PICKPOCKET, pickpocket);

		this.pickpocket = pickpocket;
	}
	function getPickpocketSkill(){
		return this.pickpocket;
	}

	function setRuneSkill(runes){
		setPlayerTalent(this.id, TALENT_RUNES, runes);

		this.runes = runes;
	}
	function getRuneSkill(){
		return this.runes;
	}

	function setAlchemySkill(alchemy){
		setPlayerTalent(this.id, TALENT_ALCHEMY, alchemy);

		this.alchemy = alchemy;
	}
	function getAlchemySkill(){
		return this.alchemy;
	}

	function setSmithSkill(smith){
		setPlayerTalent(this.id, TALENT_SMITH, smith);

		this.smith = smith;
	}
	function getSmithSkill(){
		return this.smith;
	}

	function setTrophySkill(trophy){
		setPlayerTalent(this.id, TALENT_THROPHY, trophy);

		this.trophy = trophy;
	}
	function getTrophySkill(){
		return this.trophy;
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

		this.vis.bm = bodyModel;
		this.vis.bt = bodyTexture;
		this.vis.hm = headModel;
		this.vis.ht = headTexture;
	}
	function getVisual(){
		return this.vis;
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
		return this.pos;
	}


	function setInvisibility(state){
		setPlayerInvisible(this.id, state);

		this.invisible = state;
	}
	function isInvisible(){
		return this.invisible;
	}

	function isLogged(){
		return this.logged;
	}

	function isAFK(){
		return this.afk;
	}

	function changeWhitelist(state){
		this.whitelist = state;
	}
	function isOnWhitelist(){
		return this.whitelist;
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

	function spawnPlayer(){
		spawnPlayer(this.id);

		local vis = getVisual(this.id);
		setVisual(this.vis.bm, this.vis.bt, this.vis.hm, this.vis.ht);
	}
	function unspawnPlayer(){
		unspawnPlayer(this.id);
	}
	function isSpawned(){
		return isPlayerSpawned(this.id);
	}

	function giveItem(instance, amount){
		instance = instance.toupper();

		giveItem(this.id, Items.id(instance), amount);

		this.items <- {instance = instance, amount = amount, equipped = false};
	}
	function removeItem(instance, amount){
		instance = instance.toupper();

		removeItem(this.id, Items.id(instance), amount);

		this.items
	}
	function equipItem(instance){
		instance = instance.toupper();

		if(!instance.rawin(this.items)) return;

		equipItem(this.id, Items.id(instance));
	}


	function kick(reason){
		kick(this.id, reason);

	}

	function ban(duration, reason){
		ban(this.id, duration, reason);

	}

	function jail(duration, reason){

	}


	function init(){
		this.setUsername("Username");
		this.setPassword("password");
		this.setPermissions(perm.ADMIN);
		this.setColor(255, 255, 255);
		this.setColorHex("FFFFFF");

		this.setInstance("PC_HERO");

		this.setHealth(500);
		this.setMaxHealth(500);
		this.setMana(500);
		this.setMaxMana(500);
		this.setStrength(100);
		this.setDexterity(100);
		this.setOneHandSkill(100);
		this.setTwoHandSkill(100);
		this.setBowSkill(100);
		this.setCrossbowSkill(100);

		this.setMagicCircle(6);

		this.setSneakSkill(true);
		this.setPicklockSkill(true);
		this.setPickpocketSkill(true);
		this.setRuneSkill(true);
		this.setAlchemySkill(true);
		this.setSmithSkill(true);
		this.setTrophySkill(true);
		this.setAcrobaticSkill(true);

		this.logged = true;
		this.afk = false;
		this.invisible = false;
		this.whitelist = false;

		this.setVisual("Hum_Body_Naked0", 9, "Hum_Head_Pony", 18);
		this.setScale(1.0, 1.0, 1.0, 1.0);
		this.setWalkstyle("HUMANS.MDS");
		this.setPosition(0.0, 0.0, 0.0, 0.0);
	}


	function save(){

	}

	function load(){

	}
}

addEventHandler("onPlayerJoin", function(pid){
	Players[pid] <- Player(pid);

	Players[pid].init();
});

addEventHandler("onPlayerDisconnect", function(pid, reason){
	Players.rawdelete(pid);
});

addEventHandler("onPlayerDead", function(pid, kid){
	Players[pid].unspawnPlayer();
});

addEventHandler("onPlayerRespawn", function(pid){
	Players[pid].spawnPlayer();
});