function setPlayerFocus(id, target){
	local targetPos = getPlayerPosition(target);
	local mainPos = getPlayerPosition(id);

	local targetAngle = getVectorAngle(mainPos.x, mainPos.z, targetPos.x, targetPos.z);
	local mainAngle = getPlayerAngle(id);

	if(mainAngle != targetAngle) {
		setPlayerAngle(id, targetAngle);
	} else {
		playAni(id, "S_RUN");
	}
}