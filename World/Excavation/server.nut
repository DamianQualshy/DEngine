local minOre;
local learnSkill;
local mineSkill;
local mineSkillMax = 1000000;
local excavateTimer;
local oreChance;

local curr_stm;

ExcavationCheckMessage.bind(function(pid, message){
	local stmCheck = ExcavationResultMessage(pid,
		Players[pid].getStamina()
		).serialize();
	stmCheck.send(pid, RELIABLE_ORDERED);
});

ExcavationOreMessage.bind(function(pid, message){
	Players[pid].excavating = true;

	minOre = randomRange(1, 10);

	mineSkill = Players[pid].getMiningSkill();
	learnSkill = (minOre * 5).tointeger();
	oreChance = randomRange(learnSkill, mineSkill / 2).tointeger();

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

	Players[pid].setStamina(curr_stm - 2);

	Players[pid].giveItem("ITMI_NUGGET", oreChance);

	if(mineSkill < mineSkillMax){
		if(mineSkill + learnSkill > mineSkillMax) {
			Players[pid].setMiningSkill(mineSkillMax);
		} else Players[pid].setMiningSkill(mineSkill + learnSkill);
	}
});