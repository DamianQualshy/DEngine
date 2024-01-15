local minOre = 1;
local maxOre = 10;
local oreChance;
local minOreBonus;
local maxOreBonus;
local bonusOreChance;

local learnSkill;
local mineSkill;
local mineSkillMax = 1000000;

local curr_stm;
local excavateTimer;

ExcavationCheckMessage.bind(function(pid, message){
	local stmCheck = ExcavationResultMessage(pid,
		Players[pid].getStamina()
		).serialize();
	stmCheck.send(pid, RELIABLE_ORDERED);
});

ExcavationOreMessage.bind(function(pid, message){
	Players[pid].excavating = true;

	mineSkill = Players[pid].getMiningSkill();

	local moduloSkill = mineSkill % 10;
	minOreBonus = moduloSkill;
	maxOreBonus = minOreBonus * 5;
	bonusOreChance = randomRange(minOreBonus, maxOreBonus).tointeger();

	oreChance = randomRange(minOre, maxOre).tointeger() + bonusOreChance;
	learnSkill = (oreChance * 5).tointeger();

	curr_stm = Players[pid].getStamina();

	excavateTimer = setTimer(function(){
		local oreMine = ExcavationMiningMessage(pid,
			curr_stm,
			oreChance,
			learnSkill
			).serialize();
		oreMine.send(pid, RELIABLE_ORDERED);
	}, 1000, 11);
});

ExcavationFinishedMessage.bind(function(pid, message){
	Players[pid].excavating = false;

	Players[pid].setStamina(curr_stm - 5);

	Players[pid].giveItem("ITMI_NUGGET", oreChance);

	if(mineSkill < mineSkillMax){
		if(mineSkill + learnSkill > mineSkillMax) {
			Players[pid].setMiningSkill(mineSkillMax);
		} else Players[pid].setMiningSkill(mineSkill + learnSkill);
	}
});