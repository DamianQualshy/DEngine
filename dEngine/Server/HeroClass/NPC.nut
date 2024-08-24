NPCs <- {};

class NPC extends PrototypeHero {
	voice = -1;
	npctype = -1;
	fight_tactic = -1;

	npc_state = -1;

	daily_routine = null;

	roam_distance = -1;

	attack_distance = -1;
	target_distance = -1;
	chase_distance = -1;

	warn_distance = -1;
	warn_time = -1;

	weapon_mode = -1;

	waypoint = "";

	spawn_pos = {
		x = 0.0,
		y = 0.0,
		z = 0.0,
		a = 0.0
	};

	ai = null;
	waynet = null;


		constructor(params){
			local _id = createNpc(params.name, params.instance);

			this.Init(_id, params);
			NPCs[this.id] <- this;

			this.setVoice("voice" in params ? params.voice : 0);
			this.setNPCType("npctype" in params ? params.npctype : NPC_TYPE_NEUTRAL);
			this.setFightTactic("fight_tactic" in params ? params.fight_tactic : FIGHT_TACTIC_COWARD);

			this.setNPCState("npc_state" in params ? params.npc_state : AIState.Idle);

			this.setDailyRoutine("daily_routine" in params ? params.daily_routine : null);

			this.setRoamDistance("roam_distance" in params ? params.roam_distance : 1000);

			this.setAttackDistance("attack_distance" in params ? params.attack_distance : 300);
			this.setTargetDistance("target_distance" in params ? params.target_distance : 1500);
			this.setChaseDistance("chase_distance" in params ? params.chase_distance : 1500);

			this.setWarnDistance("warn_distance" in params ? params.warn_distance : 800);
			this.setWarnTime("warn_time" in params ? params.warn_time : 0);

			this.setWeaponMode("weapon_mode" in params ? params.weapon_mode : WEAPONMODE_FIST);

			this.setWaypoint("waypoint" in params ? params.waypoint : "TOT");

			this.AI_Spawn();
			this.waynet = Waynet(_id);
		}


	function setVoice(voice){
		this.voice = convert(voice, "integer");
	}
	function getVoice(){
		return this.voice;
	}

	function setNPCType(npctype){
		this.npctype = convert(npctype, "integer");
	}
	function getNPCType(){
		return this.npctype;
	}

	function setFightTactic(fight_tactic){
		this.fight_tactic = convert(fight_tactic, "integer");
	}
	function getFightTactic(){
		return this.fight_tactic;
	}

	function setNPCState(state){
		this.npc_state = convert(state, "integer");
	}
	function getNPCState(){
		return this.npc_state;
	}

	function setDailyRoutine(daily_routine){
		this.daily_routine = daily_routine;
	}
	function getDailyRoutine(){
		return this.daily_routine;
	}

	function setWaypoint(waypoint){
		this.waypoint = convert(waypoint, "string");

		local _wpPos = getWaypoint(this.getWorld(), this.waypoint);
		this.setPosition(
			convert(_wpPos.x, "float"),
			convert(_wpPos.y, "float"),
			convert(_wpPos.z, "float"),
			0.0
		);

		this.spawn_pos = this.getPosition();
	}
	function getSpawnWaypoint(){
		return this.waypoint;
	}

	function setSpawnPosition(x, y, z, a){
		this.spawn_pos = {
			x = convert(x, "float"),
			y = convert(y, "float"),
			z = convert(z, "float"),
			a = convert(a, "float")
		}
	}
	function getSpawnPosition(){
		return this.spawn_pos;
	}

	function setRoamDistance(distance){
		this.roam_distance = convert(distance, "integer");
	}
	function getRoamDistance(){
		return this.roam_distance;
	}

	function setAttackDistance(distance){
		this.attack_distance = convert(distance, "integer");
	}
	function getAttackDistance(){
		return this.attack_distance;
	}

	function setTargetDistance(distance){
		this.target_distance = convert(distance, "integer");
	}
	function getTargetDistance(){
		return this.target_distance;
	}

	function setChaseDistance(distance){
		this.chase_distance = convert(distance, "integer");
	}
	function getChaseDistance(){
		return this.chase_distance;
	}

	function setWarnDistance(distance){
		this.warn_distance = convert(distance, "integer");
	}
	function getWarnDistance(){
		return this.warn_distance;
	}

	function setWarnTime(_time){
		this.warn_time = convert(_time, "integer");
	}
	function getWarnTime(){
		return this.warn_time;
	}

	function setWeaponMode(weapon_mode){
		this.weapon_mode = convert(weapon_mode, "integer");
	}
	function getWeaponMode(){
		return this.weapon_mode;
	}
}

function NPC::Respawn(){
	this.respawn();

	local _spawn = this.spawn_pos;
	this.setPosition(_spawn.x, _spawn.y, _spawn.z, _spawn.a)
}

function NPC::Destroy(){
	destroyNpc(this.id);
	NPCs.rawdelete(this.id);
}

function NPC::AI_Spawn(){
	switch(this.npctype){
		case NPC_TYPE_NEUTRAL:
			AI_SpawnNPC(AINeutral.Create(this.id));
		break;
		case NPC_TYPE_AGRESSIVE:
			AI_SpawnNPC(AIAgressive.Create(this.id));
		break;
		case NPC_TYPE_MONSTER:
			AI_SpawnNPC(AIMonster.Create(this.id));
		break;
		case NPC_TYPE_HUMANOID:
			AI_SpawnNPC(AIHumanoid.Create(this.id));
		break;
	}
}