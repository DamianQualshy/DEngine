function AI_GetDistancePlayers(from, to) {
	local from_pos = getPlayerPosition(from);
	local to_pos = getPlayerPosition(to);

	return getDistance3d(from_pos.x, from_pos.y, from_pos.z, to_pos.x, to_pos.y, to_pos.z);
}

function AI_GetAngleToPlayer(from, to) {
	local from_pos = getPlayerPosition(from);
	local to_pos = getPlayerPosition(to);

	return getVectorAngle(from_pos.x, from_pos.z, to_pos.x, to_pos.z);
}

function AI_TurnToPlayer(from, to) {
	local from_pos = getPlayerPosition(from);
	local to_pos = getPlayerPosition(to);

	setPlayerAngle(from, getVectorAngle(from_pos.x, from_pos.z, to_pos.x, to_pos.z));
}

function AI_Warn(npc_state, ts) {
	if (npc_state.warn_time == 0) {
		return false;
	}

	if (npc_state.warn_start == 0) {
		npc_state.warn_start = ts;
	}

	if ((ts - npc_state.warn_start) < npc_state.warn_time) {
		playAni(npc_state.id, "T_WARN");
		return true;
	}

	return false  ;
}

function AI_CollectNearestTarget(npc_state) {
	local streamed = getStreamedPlayersByPlayer(npc_state.id);
	local from_pos = getPlayerPosition(npc_state.id);

	local nearest_playerid = -1;
	local nearest_distance = 999999;

	foreach (pid in streamed) {
		if (isPlayerDead(pid)) {
			continue;
		}

		local to_pos = getPlayerPosition(pid);
		local distance = getDistance3d(from_pos.x, from_pos.y, from_pos.z, to_pos.x, to_pos.y, to_pos.z);

		if (distance < nearest_distance && distance <= npc_state.target_distance) {
			nearest_playerid = pid;
			nearest_distance = distance;
		}
	}

	return nearest_playerid;
}

function AI_GetDistanceToWP(from, wp){
	if(wp == null) return 0;

	local from_pos = getPlayerPosition(from);
	local to_pos = getWaypoint(getPlayerWorld(from), wp);

	return getDistance3d(from_pos.x, from_pos.y, from_pos.z, to_pos.x, to_pos.y, to_pos.z);
}

function AI_GetDistanceToPosition(from, pos){
	local from_pos = getPlayerPosition(from);
	local to_pos = getNearestWaypoint(getPlayerWorld(from), pos.x, pos.y, pos.z);

	return getDistance3d(from_pos.x, from_pos.y, from_pos.z, to_pos.x, to_pos.y, to_pos.z);
}

function AI_TurnToWP(from, wp){
	local from_pos = getPlayerPosition(from);
	local to_pos = getWaypoint(getPlayerWorld(from), wp);

	setPlayerAngle(from, getVectorAngle(from_pos.x, from_pos.z, to_pos.x, to_pos.z));
}

function AI_TurnToPosition(from, pos){
	local from_pos = getPlayerPosition(from);
	local to_pos = getNearestWaypoint(getPlayerWorld(from), pos.x, pos.y, pos.z);

	setPlayerAngle(from, getVectorAngle(from_pos.x, from_pos.z, to_pos.x, to_pos.z));
}

function AI_GetDistanceBetweenWaypoints(id, wp1, wp2){
	if(wp2 == null) return 0;

	local from_pos = getWaypoint(getPlayerWorld(id), wp1);
	local to_pos = getWaypoint(getPlayerWorld(id), wp2);
	return getDistance3d(from_pos.x, from_pos.y, from_pos.z, to_pos.x, to_pos.y, to_pos.z);
}

function AI_PlayIdleAnimation(id) {
	local animations = ["R_ROAM1", "R_ROAM2", "R_ROAM3"];
	local chosenAnimation = animations[random(0, animations.len() - 1)];
	playAni(this.id, chosenAnimation);
}