DialogueChoiceMessage.bind(function(pid, message){

});

DialogueInitMessage.bind(function(pid, message){
	local npc = message.npcID;

		if(NPCs[npc].waynet.movement == AIWaynetMovement.Walking) stopAni(npc, "S_FISTWALKL");
		if(NPCs[npc].waynet.movement == AIWaynetMovement.Running) stopAni(npc, "S_FISTRUNL");

	NPCs[npc].setNPCState(AIState.Talk);
	AI_TurnToPlayer(npc, pid);
});

DialogueExitMessage.bind(function(pid, message){
	NPCs[message.npcID].setNPCState(AIState.Idle);
});