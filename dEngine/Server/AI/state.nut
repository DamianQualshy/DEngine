local attached = []
local states = {}

function AI_GetNPCState(npc_id) {
	if (npc_id in states) {
		return states[npc_id]
	}

	return null
}

function AI_GetAttachedNPCs() {
	return attached
}

function AI_SpawnNPC(npc_state) {
	attached.push(npc_state)
	states[npc_state.id] <- npc_state

	npc_state.Reset()
	npc_state.Spawn()
}

function AI_RemoveNPC(npc_state) {
	if (npc_id in states && states[npc_state.id]) {
		NPCs[npc_state.id].Destroy();
		states[npc_state.id] = null

		foreach (idx, state in npcs) {
			if (state.id == npc_state.id) {
				npcs[idx] = npcs[npcs.len() - 1]
				npcs.pop()
			}
		}
	}
}