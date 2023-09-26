OreManager <- {};

class Ore {
	mob = null;

	visual = null;

	position = null;
	world = null;

	useWith = null;

	constructor(visual, world, x, y, z, a){
		this.mob = MobInter(visual);

		this.mob.setPosition(x, y, z);
		//this.mob.setHeadingAtWorld(a);

		this.mob.useWithItem = "ITMW_2H_AXE_L_01"
		this.mob.addToWorld();

		this.visual = visual;
		this.position = {x = x, y = y, z = z, a = a};
		this.world = world;

		this.useWith = mob.useWithItem;

		this.mob.cdDynamic = true;

		OreManager[this.mob.ptr] <- this;
	}

	function add(){
		this.mob.addToWorld();
	}
	function remove(){
		this.mob.removeFromWorld();
	}
}

addEventHandler("onWorldEnter", function(world){
	foreach(item in OreManager){
		if(item.world == world){
			item.add();
		} else {
			item.remove();
		}
	}
});