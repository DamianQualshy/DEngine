class AIBase {
	id = -1;
	spawn = null;
	daily_routine = null;

	roam_distance = -1;

	wait_until = 0;

	attack_distance = -1;
	target_distance = -1;
	chase_distance = -1;

	warn_distance = -1;
	warn_time = -1;

	weapon_mode = -1;

		constructor(npc_id) {
			this.id = npc_id;

			this.daily_routine = NPCs[npc_id].getDailyRoutine();

			this.roam_distance = NPCs[npc_id].getRoamDistance();

			this.attack_distance = NPCs[npc_id].getAttackDistance();
			this.target_distance = NPCs[npc_id].getTargetDistance();
			this.chase_distance = NPCs[npc_id].getChaseDistance();

			this.warn_distance = NPCs[npc_id].getWarnDistance();
			this.warn_time = NPCs[npc_id].getWarnTime();

			this.weapon_mode = NPCs[npc_id].getWeaponMode();
		}

	function Create(npc_id){
		local state = this(npc_id);
		state.Setup()

		return state
	}

	function Reset() {
		this.wait_until = 0;
	}

	function Update(ts) {
		// Triggered every AI update tick
	}

	function Setup() {
		// Triggered only once while creating NPC
	}

	function Spawn() {
		// Triggered after NPC respawn
	}

	function OnHitReceived(kid, desc) {
		// Triggered when NPC receives damage
	}
}