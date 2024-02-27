class PrototypeHero {
	id = -1;

	color = {
		r = -1,
		g = -1,
		b = -1
	};

	name = "";

	instance = "";
	guild = -1;

	level = -1;
	experience = -1;
	learnpoints = -1;

	health = -1;
	max_health = -1;
	mana = -1;
	max_mana = -1;
	strength = -1;
	dexterity = -1;

	onehand = -1;
	twohand = -1;
	bow = -1;
	cbow = -1;

	magic_circle = -1;

	sneaking = -1;
	picklock = -1;
	pickpocket = -1;
	runemaking = -1;
	alchemy = -1;
	smithing = -1;
	trophies = -1;
	acrobatic = -1;

	walk = "HUMANS.MDS";
	visual = {
		bm = "HUM_BODY_NAKED0",
		bt = 8,
		hm = "HUM_HEAD_PONY",
		ht = 18
	};
	scale = {
		x = 1.0,
		y = 1.0,
		z = 1.0,
		f = 1.0
	};

	world = "";
	virtual_world = -1;
	pos = {
		x = 0.0,
		y = 0.0,
		z = 0.0,
		a = 0.0
	};

	function setColor(r, g, b){
		this.color = {
			r = convert(r, "integer"),
			g = convert(g, "integer"),
			b = convert(b, "integer")
		};

		setPlayerColor(this.id, this.color.r, this.color.g, this.color.b);
	}

	function setColorHex(hex){
		hex = hexToRgb(convert(hex, "string"));

		this.color = {
			r = convert(hex.r, "integer"),
			g = convert(hex.g, "integer"),
			b = convert(hex.b, "integer")
		};

		setPlayerColor(this.id, this.color.r, this.color.g, this.color.b);
	}

	function getColor(){
		return this.color;
	}

	function getColorHex(){
		return rgbToHex(this.color.r, this.color.g, this.color.b);
	}


		// Hero Functions

	function setName(name){
		this.name = convert(name, "string");
	}

	function getName(){
		return this.name;
	}


	function setInstance(instance){
		this.instance = convert(instance, "string");
	}

	function getInstance(){
		return this.instance;
	}


	function setGuild(guild){
		this.guild = convert(guild, "integer");

		local setHeroGuild = HeroStatsMessage_Guild(this.id,
			this.guild
			).serialize();
		setHeroGuild.send(this.id, RELIABLE_ORDERED);
	}

	function getGuild(){
		return this.guild;
	}


	function setLevel(level){
		this.level = convert(level, "integer");

		local setHeroLevel = HeroStatsMessage_Level(this.id,
			this.level
			).serialize();
		setHeroLevel.send(this.id, RELIABLE_ORDERED);
	}

	function getLevel(){
		return this.level;
	}


	function setExperience(experience){
		this.experience = convert(experience, "integer");

		local setHeroEXP = HeroStatsMessage_EXP(this.id,
			this.experience
			).serialize();
		setHeroEXP.send(this.id, RELIABLE_ORDERED);
	}

	function getExperience(){
		return this.experience;
	}


	function setLearnPoints(learnpoints){
		this.learnpoints = convert(learnpoints, "integer");

		local setHeroLP = HeroStatsMessage_LP(this.id,
			this.learnpoints
			).serialize();
		setHeroLP.send(this.id, RELIABLE_ORDERED);
	}

	function getLearnPoints(){
		return this.learnpoints;
	}


	function setHealth(hp){
		this.health = convert(hp, "integer");

		setPlayerHealth(this.id, this.health);
	}

	function getHealth(){
		return this.health;
	}


	function setMaxHealth(max_hp){
		this.max_health = convert(max_hp, "integer");

		setPlayerMaxHealth(this.id, this.max_health);
	}

	function getMaxHealth(){
		return this.max_health;
	}


	function setMana(mp){
		this.mana = convert(mp, "integer");

		setPlayerMana(this.id, this.mana);
	}

	function getMana(){
		return this.mana;
	}


	function setMaxMana(max_mp){
		this.max_mana = convert(max_mp, "integer");

		setPlayerMaxMana(this.id, this.max_mana);
	}

	function getMaxMana(){
		return this.max_mana;
	}


	function setStrength(str){
		this.strength = convert(str, "integer");

		setPlayerStrength(this.id, this.strength);
	}

	function getStrength(){
		return this.strength;
	}


	function setDexterity(dex){
		this.dexterity = convert(dex, "integer");

		setPlayerDexterity(this.id, this.dexterity);
	}

	function getDexterity(){
		return this.dexterity;
	}


	function setOneHandSkill(onehand){
		if (onehand > 100) onehand = 100;
		this.onehand = convert(onehand, "integer");

		setPlayerSkillWeapon(this.id, WEAPON_1H, this.onehand);
	}

	function getOneHandSkill(){
		return this.onehand;
	}


	function setTwoHandSkill(twohand){
		if (twohand > 100) twohand = 100;
		this.twohand = convert(twohand, "integer");

		setPlayerSkillWeapon(this.id, WEAPON_2H, this.twohand);
	}

	function getTwoHandSkill(){
		return this.twohand;
	}


	function setBowSkill(bow){
		if (bow > 100) bow = 100;
		this.bow = convert(bow, "integer");

		setPlayerSkillWeapon(this.id, WEAPON_BOW, this.bow);
	}

	function getBowSkill(){
		return this.bow;
	}


	function setCrossbowSkill(cbow){
		if (cbow > 100) cbow = 100;
		this.cbow = convert(cbow, "integer");

		setPlayerSkillWeapon(this.id, WEAPON_CBOW, this.cbow);
	}

	function getCrossbowSkill(){
		return this.cbow;
	}


	function setMagicCircle(level){
		if (level > 6) level = 6;
		this.magic_circle = convert(level, "integer");

		setPlayerMagicLevel(this.id, this.magic_circle);
	}

	function getMagicCircle(){
		return this.magic_circle;
	}


	function setSneakTalent(arg){
		this.sneaking = convert(arg, "bool");

		setPlayerTalent(this.id, TALENT_SNEAK, this.sneaking);
	}

	function getSneakTalent(){
		return this.sneak;
	}


	function setPicklockTalent(arg){
		this.picklock = convert(arg, "bool");

		setPlayerTalent(this.id, TALENT_PICK_LOCKS, this.picklock);
	}

	function getPicklockTalent(){
		return this.picklock;
	}


	function setPickpocketTalent(arg){
		this.pickpocket = convert(arg, "bool");

		setPlayerTalent(this.id, TALENT_PICKPOCKET, this.pickpocket);
	}

	function getPickpocketTalent(){
		return this.pickpocket;
	}


	function setRunemakingTalent(arg){
		this.runemaking = convert(arg, "bool");

		setPlayerTalent(this.id, TALENT_RUNES, this.runemaking);
	}

	function getRunemakingTalent(){
		return this.runemaking;
	}


	function setAlchemyTalent(arg){
		this.alchemy = convert(arg, "bool");

		setPlayerTalent(this.id, TALENT_ALCHEMY, this.alchemy);
	}

	function getAlchemyTalent(){
		return this.alchemy;
	}


	function setSmithingTalent(arg){
		this.smithing = convert(arg, "bool");

		setPlayerTalent(this.id, TALENT_SMITH, this.smithing);
	}

	function getSmithingTalent(){
		return this.smithing;
	}


	function setTrophiesTalent(arg){
		this.trophies = convert(arg, "bool");

		setPlayerTalent(this.id, TALENT_THROPHY, this.trophies);
	}

	function getTrophiesTalent(){
		return this.trophies;
	}


	function setAcrobaticTalent(arg){
		this.acrobatic = convert(arg, "bool");

		setPlayerTalent(this.id, TALENT_ACROBATIC, this.acrobatic);
	}

	function getAcrobaticTalent(){
		return this.acrobatic;
	}


	function setWalkstyle(walk){
		this.walk = convert(walk, "string");

		applyPlayerOverlay(this.id, Mds.id(this.walk));
	}

	function resetWalkstyle(){
		removePlayerOverlay(this.id, Mds.id(this.walk));

		this.walk = "HUMANS.MDS"
	}

	function getwalkstyle(){
		return this.walk;
	}


	function setVisual(bodyModel, bodyTexture, headModel, headTexture){
		this.visual = {
			bm = convert(bodyModel, "string"),
			bt = convert(bodyTexture, "integer"),
			hm = convert(headModel, "string"),
			ht = convert(headTexture, "integer")
		};

		setPlayerVisual(this.id, this.visual.bm, this.visual.bt, this.visual.hm, this.visual.ht);
	}

	function getVisual(){
		return this.visual;
	}


	function setScale(x, y, z, fatness){
		this.scale = {
			x = convert(x, "float"),
			y = convert(y, "float"),
			z = convert(z, "float"),
			f = convert(fatness, "float")
		};

		setPlayerScale(this.id, this.scale.x, this.scale.y, this.scale.z);
		setPlayerFatness(this.id, this.scale.f);
	}

	function getScale(){
		return this.scale;
	}


	function setWorld(world){
		if (this.world !=  world){
			this.world = convert(world, "string");

			setPlayerWorld(this.id, this.world);
		}
	}

	function getWorld(){
		return this.world;
	}


	function setVirtualWorld(vworld){
		this.virtual_world = convert(vworld, "integer");

		setPlayerVirtualWorld(this.id, this.virtual_world);
	}

	function getVirtualWorld(){
		return this.virtual_world;
	}


	function setPosition(x, y, z, angle){
		this.pos = {
			x = convert(x, "float"),
			y = convert(y, "float"),
			z = convert(z, "float"),
			a = convert(angle, "float")
		};

		setPlayerPosition(this.id, this.pos.x, this.pos.y, this.pos.z);
		setPlayerAngle(this.id, this.pos.a);
	}

	function getPosition(){
		local gamepos = getPlayerPosition(this.id);
		local gameang = getPlayerAngle(this.id)

		this.pos = {
			x = convert(gamepos.x, "float"),
			y = convert(gamepos.y, "float"),
			z = convert(gamepos.z, "float"),
			a = convert(gameang, "float")
		};

		return this.pos;
	}



	function init(id){
		this.id = id;

		this.setName(getPlayerName(id));

		this.setInstance(getPlayerInstance(id));
		this.setGuild(2)

		this.setLevel(100)
		this.setExperience(250 * this.getLevel())
		this.setLearnPoints(10 * this.getLevel());

		this.setHealth(1000);
		this.setMaxHealth(1000);
		this.setMana(500);
		this.setMaxMana(500);
		this.setStrength(200);
		this.setDexterity(200);

		this.setOneHandSkill(100);
		this.setTwoHandSkill(100);
		this.setBowSkill(100);
		this.setCrossbowSkill(100);

		this.setMagicCircle(6);

		this.setSneakTalent(true);
		this.setPicklockTalent(true);
		this.setPickpocketTalent(true);
		this.setRunemakingTalent(true);
		this.setAlchemyTalent(true);
		this.setSmithingTalent(true);
		this.setTrophiesTalent(true);
		this.setAcrobaticTalent(true);

		this.setWalkstyle("HUMANS.MDS");
		this.setVisual("HUM_BODY_NAKED0", 8, "HUM_HEAD_PONY", 18);
		this.setScale(1.0, 1.0, 1.0, 1.0);

		this.setWorld("NEWWORLD\\NEWWORLD.ZEN");
		this.setVirtualWorld(0);
		this.setPosition(0.0, 0.0, 0.0, 0.0);
	}
}