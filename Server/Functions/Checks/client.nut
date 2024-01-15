function isGUIOpened(check){
	guiOpened = false;

	local guiElements = array(255, false);

	guiElements[guiCheck.login] = loginGUIvisible;
	guiElements[guiCheck.creator] = creatorGUIvisible;
	guiElements[guiCheck.anim] = animGUIvisible;
	guiElements[guiCheck.stats] = statsGUIvisible;
	guiElements[guiCheck.inventory] = inventoryGUIvisible;
	guiElements[guiCheck.trade] = tradeGUIvisible;

	foreach(element, visible in guiElements){
		if(element != check && visible){
			guiOpened = true;
			break;
		} else {
			guiOpened = false;
		}
	}

	return guiOpened;
}

function isPlayerBusy(){
	if(isHeroResting || isHeroAFK || isHeroExcavating){
		stateBusy = true;
	} else {
		stateBusy = false;
	}

	return stateBusy;
}