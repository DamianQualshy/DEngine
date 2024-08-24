local stuckCtr = 0;
local roamCtr = 0;

local function goBackToSpawn(id){
	local _currPos = NPCs[id].getPosition();
	local _currWP = getNearestWaypoint(NPCs[id].getWorld(), _currPos.x, _currPos.y, _currPos.z).name;
		NPCs[id].waynet.createWay(_currWP, NPCs[id].getSpawnWaypoint());

		NPCs[id].setNPCState(AIState.Walk);
}

class AINeutral extends AIBase {
	function Reset() {
		base.Reset()
	}

	function Update(ts) {
		if (isPlayerDead(this.id)) {
			return;
		}

		this.DailyRoutine(ts)
	}

	function DailyRoutine(ts) {
		switch(NPCs[this.id].getNPCState()){
			case AIState.Idle:
				if(AI_GetDistanceToWP(this.id, NPCs[this.id].getSpawnWaypoint()) > this.roam_distance){
					goBackToSpawn(this.id);
				} else {
					NPCs[this.id].setNPCState(AIState.Roam);
					NPCs[this.id].waynet.startRoaming();
				}
			break;
			case AIState.Talk:
				//
			break;
			case AIState.Walk:
				if(!NPCs[this.id].waynet.hasReachedGoal()){
					NPCs[this.id].waynet.moveToNextWaypoint();
				} else {
					stopAni(this.id);
					NPCs[this.id].setNPCState(AIState.Idle);
					NPCs[this.id].waynet.removeWay();
				}
			break;
			case AIState.Roam:
				if(NPCs[this.id].waynet.roaming){
					if(AI_GetDistanceToWP(this.id, NPCs[this.id].getSpawnWaypoint()) > this.roam_distance){
						stopAni(this.id);
							NPCs[this.id].waynet.stopRoaming();
							goBackToSpawn(this.id);
						return;
					}
					if(NPCs[this.id].waynet.hasReachedPosition()){
						stopAni(this.id, "S_FISTWALKL");
						if(ts <= NPCs[this.id].waynet.nextActionTime){
							if(random(0, 100) < 20){
								AI_PlayIdleAnimation(this.id);
							}

							if(roamCtr >= 10) {
								NPCs[this.id].waynet.moveToRandomPosition();
								roamCtr = 0;
							}
							roamCtr++;
						}

					} else {
						if(stuckCtr > 10) {
							stopAni(this.id, "S_FISTWALKL");
								NPCs[this.id].waynet.stopRoaming();
								goBackToSpawn(this.id);
								stuckCtr = 0;
							return;
						}
						stuckCtr++;
					}
				} else {
					stopAni(this.id);
					NPCs[this.id].setNPCState(AIState.Idle);
				}
			break;
		}
		/* print(format("%s (%d) state: %d\nroaming: %d\nreachedposition: %d\ntickrate (%d) nextaction (%d)",
			NPCs[this.id].getName(),
			this.id,
			NPCs[this.id].getNPCState(),
			NPCs[this.id].waynet.roaming,
			NPCs[this.id].waynet.hasReachedPosition(),
			ts, NPCs[this.id].waynet.nextActionTime
		)); */
	}
}