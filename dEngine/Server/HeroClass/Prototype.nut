class PrototypeHero {
	id = -1;

	name = "";
	guild = -1;

	instance = "";
	color = {
		r = 0,
		g = 0,
		b = 0
	};

	level = -1;
	exp = -1;
	lp = -1;

	attribute = [
		-1, // ATR_HITPOINTS
		-1, // ATR_HITPOINTS_MAX
		-1, // ATR_MANA
		-1, // ATR_MANA_MAX

		-1, // ATR_STRENGTH
		-1 // ATR_DEXTERITY
	];

	talent = array(TALENT_MAX);

	walkstyle = "HUMANS.MDS";

	visual = {
		bm = "HUM_BODY_NAKED0",
		bt = 9,
		hm = "HUM_HEAD_PONY",
		ht = 18
	};

	scale = {
		x = 1.0,
		y = 1.0,
		z = 1.0,
		f = 1.0
	};

	world = "NEWWORLD\\NEWWORLD.ZEN";
	vworld = -1;

	pos = {
		x = 0.0,
		y = 0.0,
		z = 0.0,
		a = 0.0
	};

	invisible = -1;



	function setName(name){
		this.name = convert(name, "string");
	}
	function getName(){
		return this.name;
	}

	function setGuild(guild){
		this.guild = convert(guild, "integer");
	}
	function getGuild(){
		return this.guild;
	}

	function setInstance(instance){
		this.instance = convert(instance, "string");

		setPlayerInstance(this.id, this.instance);
	}
	function getInstance(){
		return this.instance;
	}

	function setColor(rgb){
		this.color = {
			r = convert(rgb.r, "integer"),
			g = convert(rgb.g, "integer"),
			b = convert(rgb.b, "integer")
		}

		setPlayerColor(this.id, this.color.r, this.color.g, this.color.b);
	}
	function getColor(){
		return this.color;
	}

	function setLevel(level){
		this.level = convert(level, "integer");
	}
	function getLevel(){
		return this.level;
	}

	function setExperience(exp){
		this.exp = convert(exp, "integer");
	}
	function getExperience(){
		return this.exp;
	}

	function setLearnPoints(lp){
		this.lp = convert(lp, "integer");
	}
	function getLearnPoints(){
		return this.lp;
	}

	function setAttribute(atr, am){
		atr = convert(atr, "integer");
		this.attribute[atr] = convert(am, "integer");

		switch(atr){
			case ATR_HITPOINTS:
				setPlayerHealth(this.id, this.attribute[atr]);
			break;
			case ATR_HITPOINTS_MAX:
				setPlayerMaxHealth(this.id, this.attribute[atr]);
			break;
			case ATR_MANA:
				setPlayerMana(this.id, this.attribute[atr]);
			break;
			case ATR_MANA_MAX:
				setPlayerMaxMana(this.id, this.attribute[atr]);
			break;
			case ATR_STRENGTH:
				setPlayerStrength(this.id, this.attribute[atr]);
			break;
			case ATR_DEXTERITY:
				setPlayerDexterity(this.id, this.attribute[atr]);
			break;
		}
	}
	function getAttribute(atr){
		return this.attribute[atr];
	}

	function setSkill(val, am){
		val = convert(val, "integer");
		this.talent[val] = convert(am, "integer");

		setPlayerSkillWeapon(this.id, val, this.talent[val]);
	}
	function getSkill(val){
		return this.talent[val];
	}

	function setTalent(tal, am){
		tal = convert(tal, "integer");
		this.talent[tal] = convert(am, "integer");

		setPlayerTalent(this.id, tal, this.talent[tal]);
	}
	function getTalent(tal){
		return this.talent[tal];
	}

	function setWalkstyle(walk){
		this.walkstyle = convert(walk, "string");

		applyPlayerOverlay(this.id, Mds.id(this.walkstyle));
	}
	function getWalkstyle(){
		return this.walkstyle;
	}

	function setVisual(bm, bt, hm, ht){
		this.visual = {
			bm = convert(bm, "string"),
			bt = convert(bt, "integer"),
			hm = convert(hm, "string"),
			ht = convert(ht, "integer")
		}

		setPlayerVisual(this.id, this.visual.bm, this.visual.bt, this.visual.hm, this.visual.ht);
	}
	function getVisual(){
		return this.visual;
	}

	function setScale(x, y, z, f){
		this.scale = {
			x = convert(x, "float"),
			y = convert(y, "float"),
			z = convert(z, "float"),
			f = convert(f, "float")
		}

		setPlayerScale(this.id, this.scale.x, this.scale.y, this.scale.z);
		setPlayerFatness(this.id, this.scale.f);
	}
	function getScale(){
		return this.scale;
	}

	function setWorld(world){
		if(world == this.world) return;

		this.world = convert(world, "string");

		setPlayerWorld(this.id, this.world);
	}
	function getWorld(){
		return this.world;
	}

	function setVirtualWorld(vworld){
		this.vworld = convert(vworld, "integer");

		setPlayerVirtualWorld(this.id, this.vworld);
	}
	function getVirtualWorld(){
		return this.vworld;
	}

	function setPosition(x, y, z, a){
		this.pos = {
			x = convert(x, "float"),
			y = convert(y, "float"),
			z = convert(z, "float"),
			a = convert(a, "float")
		}

		setPlayerPosition(this.id, this.pos.x, this.pos.y, this.pos.z);
		setPlayerAngle(this.id, this.pos.a);
	}
	function getPosition(){
		local _pos = getPlayerPosition(this.id);
		this.pos = {
			x = convert(_pos.x, "float"),
			y = convert(_pos.y, "float"),
			z = convert(_pos.z, "float"),
			a = convert(getPlayerAngle(this.id), "float")
		}

		return this.pos;
	}

	function setInvisible(state){
		this.invisible = convert(state, "bool");

		setPlayerInvisible(this.id, this.invisible);
	}
	function getInvisible(){
		return this.invisible;
	}

	function spawn(){
		spawnPlayer(this.id);
		this.ReInit();
	}

	function respawn(){
		spawnPlayer(this.id);
		this.ReInit();

		setPlayerHealth(this.id, this.attribute[ATR_HITPOINTS_MAX]);
		setPlayerMana(this.id, this.attribute[ATR_MANA_MAX]);
	}
}

function PrototypeHero::ReInit(){
	setPlayerName(this.id, this.name);
	setPlayerInstance(this.id, this.instance);

	this.RetainStats();
	this.RetainVisual();
}

function PrototypeHero::RetainStats(){
	setPlayerHealth(this.id, this.attribute[ATR_HITPOINTS]);
	setPlayerMaxHealth(this.id, this.attribute[ATR_HITPOINTS_MAX]);
	setPlayerMana(this.id, this.attribute[ATR_MANA]);
	setPlayerMaxMana(this.id, this.attribute[ATR_MANA_MAX]);
	setPlayerStrength(this.id, this.attribute[ATR_STRENGTH]);
	setPlayerDexterity(this.id, this.attribute[ATR_DEXTERITY]);
}

function PrototypeHero::RetainVisual(){
	local _vis = this.visual;
	if(this.getInstance() == "PC_HERO")	setPlayerVisual(this.id, _vis.bm, _vis.bt, _vis.hm, _vis.ht);

	local _scale = this.scale;
		setPlayerScale(this.id, _scale.x, _scale.y, _scale.z);
		setPlayerFatness(this.id, _scale.f);
}

function PrototypeHero::Init(id, params){
	this.id = id;

	this.setName("name" in params ? params.name : getPlayerName(id));
	this.setGuild("guild" in params ? params.guild : 0);

	this.setInstance("instance" in params ? params.instance : getPlayerInstance(id));
	this.setColor("color" in params ? params.color : {
		r = 255,
		g = 255,
		b = 255
	});

	this.setLevel("level" in params ? params.level : 1);
	this.setExperience(250 * pow(this.getLevel(), 2));
	this.setLearnPoints(10 * this.getLevel());

	this.setAttribute(ATR_HITPOINTS, "health" in params ? params.health : 40);
	this.setAttribute(ATR_HITPOINTS_MAX, "health" in params ? params.health : 40);
	this.setAttribute(ATR_MANA, "mana" in params ? params.mana : 10);
	this.setAttribute(ATR_MANA_MAX, "mana" in params ? params.mana : 10);
	this.setAttribute(ATR_STRENGTH, "strength" in params ? params.strength : 20);
	this.setAttribute(ATR_DEXTERITY, "dexterity" in params ? params.dexterity : 20);

	this.setSkill(WEAPON_1H, "one_hand" in params ? params.one_hand : 10);
	this.setSkill(WEAPON_2H, "two_hand" in params ? params.two_hand : 10);
	this.setSkill(WEAPON_BOW, "bow" in params ? params.bow : 10);
	this.setSkill(WEAPON_CBOW, "crossbow" in params ? params.crossbow : 10);

	this.setTalent(TALENT_SNEAK, "sneaking" in params ? params.sneaking : false);
	this.setTalent(TALENT_PICK_LOCKS, "picklocks" in params ? params.picklocks : false);
	this.setTalent(TALENT_PICKPOCKET, "pickpocket" in params ? params.pickpocket : false);
	this.setTalent(TALENT_RUNES, "runemaking" in params ? params.runemaking : false);
	this.setTalent(TALENT_ALCHEMY, "alchemy" in params ? params.alchemy : false);
	this.setTalent(TALENT_SMITH, "smithing" in params ? params.smithing : false);
	this.setTalent(TALENT_THROPHY, "throphies" in params ? params.throphies : false);
	this.setTalent(TALENT_ACROBATIC, "acrobatic" in params ? params.acrobatic : false);
	this.setTalent(TALENT_MAGE, "mage_circle" in params ? params.mage_circle : 0);

	if(this.getInstance() == "PC_HERO"){
		this.setVisual(
			"visual" in params ? params.visual.bm : "HUM_BODY_NAKED0",
			"visual" in params ? params.visual.bt : 8,
			"visual" in params ? params.visual.hm : "HUM_HEAD_PONY",
			"visual" in params ? params.visual.ht : 18
		);
		this.setWalkstyle("walkstyle" in params ? params.walk : "HUMANS.MDS");
	}

		local _scale = "scale" in params ? params.scale : {x = 1.0, y = 1.0, z = 1.0};
	this.setScale(_scale.x, _scale.y, _scale.z, "fatness" in params ? params.fatness : 1.0);

	this.setWorld("world" in params ? params.world : getServerWorld());
	this.setVirtualWorld("vworld" in params ? params.vworld : 0);
	this.setPosition(
		"pos" in params ? params.pos.x : 0.0,
		"pos" in params ? params.pos.y : 0.0,
		"pos" in params ? params.pos.z : 0.0,
		"pos" in params ? params.pos.a : 0.0
	);

	this.spawn();
}