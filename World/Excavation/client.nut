local excavationBar = GUI.Bar({
	position = {x = anx(800), y = any(830)}
	sizePx = {width = 180, height = 20}
	marginPx = [3, 7]
	file = "PROGRESS.TGA"
	progress = {file = "PROGRESS_BAR.TGA"}
	stretching = true
	visible = false
});

local oreDraw = GUI.Draw({
	position = {x = anx(760), y = any(850)}
	text = "You mined X ore and gained X exp!"
	font = "FONT_OLD_20_WHITE_HI.TGA"
});

local mob_;
local curr_stm;
local ore;
local exp;
local mineSkillMax = 1000000;

addEventHandler("onMobInteract", function(address, type, from, to){
	mob_ = MobInter(address);
	if(mob_.useWithItem != "ITMW_2H_AXE_L_01") return;

	if(OreManager.rawin(address)){
		if(from == 0){
				local stmCheck = ExcavationCheckMessage(heroId).serialize();
				stmCheck.send(RELIABLE_ORDERED);
			disableControls(true);
			Camera.movementEnabled = true;
		} else {
			if(isHeroExcavating == true){
				local oreFinished = ExcavationFinishedMessage(heroId).serialize();
				oreFinished.send(RELIABLE_ORDERED);
					isHeroExcavating = false;

					if(exp < mineSkillMax){
						oreDraw.setText(format("You mined %d Ore and gained %d Mining Experience!", ore, exp));
					} else {
						oreDraw.setText(format("You mined %d Ore!", ore));
					}
						oreDraw.setVisible(true);
						setTimer(function(){
							oreDraw.setVisible(false);
						}, 5000, 1);
			} else {
				oreDraw.setText("You are too tired to mine.");
			}
			disableControls(false);

			excavationBar.setValue(0);
			excavationBar.setVisible(false);
		}
	}
});

ExcavationResultMessage.bind(function(message){
	if(message.stamina > 2){
		excavationBar.setVisible(true);
			local mineOre = ExcavationOreMessage(heroId).serialize();
			mineOre.send(RELIABLE_ORDERED);
			isHeroExcavating = true;
	} else {
		useClosestMob(heroId, mob_.sceme, -1);
	}
});

ExcavationMiningMessage.bind(function(message){
	curr_stm = message.stamina;
	ore = message.ore_amount;
	exp = message.mine_exp;

	if(excavationBar.getValue() != excavationBar.getMaximum()){
		if(curr_stm > 2){
			local value = excavationBar.getValue();
			excavationBar.setValue(value + 10);
		} else {
			useClosestMob(heroId, mob_.sceme, -1);
		}
	} else {
		useClosestMob(heroId, mob_.sceme, -1);
	}
});