Player <- {};

local _setLearnPoints = setLearnPoints;
local _giveItem = giveItem;
local _equipItem = equipItem;

class LocalPlayer {
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


		constructor(id){
			this.id = id;

			Player[id] <- this;
		}


	function setName(name){
		this.name = convert(name, "string");
	}
	function getName(){
		return this.name;
	}

	function setGuild(guild){
		this.guild = convert(guild, "integer");

		setPlayerGuild(this.id, this.guild);
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

		_setLearnPoints(this.lp);
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
		this.world = convert(world, "string");

		changeWorld(this.world);
	}
	function getWorld(){
		return this.world;
	}

	function setVirtualWorld(vworld){
		this.vworld = convert(vworld, "integer");
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


	function giveItem(instance, amount){
		_giveItem(this.id, convert(instance, "string").toupper(), convert(amount, "integer"));
	}

	function equipItem(instance){
		_giveItem(this.id, convert(instance, "string").toupper(), 1);
		_equipItem(this.id, convert(instance, "string").toupper());
	}
}