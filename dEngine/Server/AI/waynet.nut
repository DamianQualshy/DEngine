class Waynet {
	id = -1;
	world = "";
	way = null;

	movement = -1;
	roaming = false;

	idleDuration = -1;
	nextActionTime = -1;

	currentIndex = -1;
	stuckCtr = -1;

	constructor(id){
		this.id = id;
		this.world = NPCs[id].getWorld();

		this.movement = AIWaynetMovement.Walking;
		this.roaming = false;

        this.idleDuration = 5 * 1000;
        this.nextActionTime = getTickCount();

		this.way = null;
	}

	function createWay(startWP, endWP){
		this.currentIndex = 0;
		this.way = Way(this.world, startWP, endWP);

			if(this.way.getCountWaypoints() <= 0){
				print(format("Failed to find Way for %s (%d)\nstartWP: %s\nendWP: %s\nwaypoint_count: %d",
					NPCs[this.id].getName(),
					this.id,
					startWP,
					endWP,
					this.way.getCountWaypoints()
				));
					NPCs[this.id].setWaypoint(endWP);
			} else {
				this.moveToClosestWaypoint();
			}
	}

	function removeWay(){
		this.currentIndex = -1;
		this.way = null;
	}


	function getCurrentWaypoint(){
		if(this.currentIndex < this.way.getWaypoints().len()){
			return this.way.getWaypoints()[this.currentIndex];
		}
		return null;
	}

	function getNextWaypoint(){
		if(this.currentIndex + 1 < this.way.getWaypoints().len()){
			return this.way.getWaypoints()[this.currentIndex + 1];
		}
		return null;
	}


	function hasReachedWaypoint(){
		local target = this.getNextWaypoint();
		if(target){
			return AI_GetDistanceToWP(this.id, target) <= 150;
		}
		return false;
	}

	function hasReachedGoal(){
		try {
			return this.currentIndex >= this.way.getWaypoints().len() - 1;
		} catch (e) {
			return true;
		}
	}


	function moveToClosestWaypoint(){
		local closestIndex = -1;
		local closestDistance = null;
		local waypoints = this.way.getWaypoints();

		foreach (index, waypoint in waypoints) {
			local distance = AI_GetDistanceToWP(this.id, waypoint);
			if (closestDistance == null || distance < closestDistance) {
				closestDistance = distance;
				closestIndex = index;
			}
		}

		if (closestIndex != -1) {
			this.currentIndex = closestIndex;
		}
	}

	function moveToNextWaypoint(){
		if(!this.hasReachedGoal()){
			if(this.hasReachedWaypoint()){
				this.currentIndex++;
				this.stuckCtr = -1;
			} else {
					if(this.stuckCtr > 50){
						local _stuckPos = getWaypoint(getPlayerWorld(this.id), this.getNextWaypoint());
							setPlayerPosition(this.id, _stuckPos.x, _stuckPos.y, _stuckPos.z);
							this.stuckCtr = -1;
						return;
					}
				this.stuckCtr++;
			}

			if(AI_GetDistanceToWP(this.id, this.getCurrentWaypoint()) < AI_GetDistanceToWP(this.id, this.getNextWaypoint())){
				AI_TurnToWP(this.id, this.getNextWaypoint());
				if(this.movement == AIWaynetMovement.Walking) playAni(this.id, "S_FISTWALKL");
				if(this.movement == AIWaynetMovement.Running) playAni(this.id, "S_FISTRUNL");
			}
		}
	}


	function moveToNextPosition(targetPos){
		if(!this.hasReachedPosition()){
			if(AI_GetDistanceToPosition(this.id, getPlayerPosition(this.id)) <= AI_GetDistanceToPosition(this.id, targetPos)){
				AI_TurnToPosition(this.id, targetPos);
				playAni(this.id, "S_FISTWALKL");
			}
		}
	}



	function startRoaming(){
		this.roaming = true;
		this.nextActionTime = getTickCount() + this.idleDuration;

		this.moveToRandomPosition();
	}

	function stopRoaming(){
		this.roaming = false;
	}

	function hasReachedPosition(threshold = 200){
		local targetPos = generateRandomPosition(this.id);

		local distance = AI_GetDistanceToPosition(this.id, targetPos);
		return distance <= threshold;
	}

	function moveToRandomPosition() {
		local targetPos = generateRandomPosition(this.id);

		this.moveToNextPosition(targetPos);
		this.nextActionTime = getTickCount() + this.idleDuration;
	}
}