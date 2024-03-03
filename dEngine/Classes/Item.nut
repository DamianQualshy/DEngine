Items <- {};

class Item {
	id = -1;
	instance = -1;

	name = "";

	mainflag = -1;
	flags = -1

	value = -1;

	owner = -1;
	ownerGuild = -1;
	disguiseGuild = -1;

	file = "";
	effectName = "";

	material = -1;

	description = "";

	inv_zbias = -1;
	inv_rotx = -1;
	inv_roty = -1;
	inv_rotz = -1;
	inv_animate = -1;


	function initItem(params){
		this.id = Daedalus.index(this.instance);

		this.mainflag = params.mainflag;
		this.flags = params.flags;

		this.value = params.value;

		this.owner = "owner" in params ? params.owner : null;
		this.ownerGuild = "ownerGuild" in params ? params.ownerGuild : null;
		this.disguiseGuild = "disguiseGuild" in params ? params.disguiseGuild : null;

		this.file = params.file;
		this.effectName = "effectName" in params ? params.effectName : "";

		this.material = params.material;

		this.description = "description" in params ? params.description : params.name;
	}
}

class IT_MeleeWeapon extends Item {
	damageTypes = -1;
	damageTotal = -1;

	range = -1;

	constructor(instance, params){
		this.instance = instance;

		this.damageTypes = params.damageTypes;
		this.damageTotal = params.damageTotal;

		this.range = params.range;

		this.initItem(params);
		Items[this.instance] <- this;
	}
}

class IT_RangedWeapon extends Item {
	damageTypes = -1;
	damageTotal = -1;

	munition = -1;

	constructor(instance, params){
		this.instance = instance;

		this.damageTypes = params.damageTypes;
		this.damageTotal = params.damageTotal;

		this.munition = params.munition;

		this.initItem(params);
		Items[this.instance] <- this;
	}
}

class IT_Armor extends Item {
	wear = -1;

	visual_change = "";
	visual_skin = -1;

	constructor(instance, params){
		this.instance = instance;

		this.wear = params.wear;

		this.visual_change = params.visual_change;
		this.visual_skin = params.visual_skin;

		this.initItem(params);
		Items[this.instance] <- this;
	}
}

class IT_Potion extends Item {
	nutrition = -1;

	scemeName = "";

	constructor(instance, params){
		this.instance = instance;

		this.nutrition = params.nutrition;

		this.scemeName = params.scemeName;

		this.initItem(params);
		Items[this.instance] <- this;
	}
}

class IT_Food extends Item {
	nutrition = -1;

	scemeName = "";

	constructor(instance, params){
		this.instance = instance;

		this.nutrition = params.nutrition;

		this.scemeName = params.scemeName;

		this.initItem(params);
		Items[this.instance] <- this;
	}
}

class IT_Plant extends Item {
	nutrition = -1;

	scemeName = "";

	constructor(instance, params){
		this.instance = instance;

		this.nutrition = params.nutrition;

		this.scemeName = params.scemeName;

		this.initItem(params);
		Items[this.instance] <- this;
	}
}

class IT_Scroll extends Item {
	spell = -1;

	mag_circle = -1;

	constructor(instance, params){
		this.instance = instance;

		this.spell = params.spell;

		this.mag_circle = params.mag_circle;

		this.initItem(params);
		Items[this.instance] <- this;
	}
}

class IT_Rune extends Item {
	spell = -1;

	mag_circle = -1;

	constructor(instance, params){
		this.instance = instance;

		this.spell = params.spell;

		this.mag_circle = params.mag_circle;

		this.initItem(params);
		Items[this.instance] <- this;
	}
}

class IT_Written extends Item {
	constructor(instance, params){
		this.instance = instance;

		this.initItem(params);
		Items[this.instance] <- this;
	}
}

class IT_Trophy extends Item {
	constructor(instance, params){
		this.instance = instance;

		this.initItem(params);
		Items[this.instance] <- this;
	}
}

class IT_Mission extends Item {
	constructor(instance, params){
		this.instance = instance;

		this.initItem(params);
		Items[this.instance] <- this;
	}
}

class IT_Misc extends Item {
	constructor(instance, params){
		this.instance = instance;

		this.initItem(params);
		Items[this.instance] <- this;
	}
}