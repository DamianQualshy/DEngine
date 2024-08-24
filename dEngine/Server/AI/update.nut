local function AI_Update() {
	local current_ts = getTickCount();
	local npcs = AI_GetAttachedNPCs();

	foreach (state in npcs) {
		state.Update(current_ts);
	}

	randomseed(current_ts);
}
setTimer(AI_Update, 500, 0);

local function AI_HitNPC(pid, kid, desc) {
	if (kid != -1 && pid >= getMaxSlots()) {
		local npc_state = AI_GetNPCState(pid);
		if (npc_state) {
			npc_state.OnHitReceived(kid, desc);
		}
	}
}
addEventHandler("onPlayerHit", AI_HitNPC);

local function AI_RespawnNPC(pid) {
	if (isNpc(pid)) {
		local npc_state = AI_GetNPCState(pid)
		if (npc_state) {
			npc_state.Reset()
			npc_state.Spawn()

			NPCs[npc_state.id].Respawn();
		}
	}
}
addEventHandler("onPlayerRespawn", AI_RespawnNPC);

