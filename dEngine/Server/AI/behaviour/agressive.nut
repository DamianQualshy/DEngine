class AIAgressive extends AIBase {
	enemy_id = -1;
	collect_target = AI_CollectNearestTarget;

	// AI vars
	max_distance = 0;
	warn_start = 0;

	function Reset() {
		base.Reset()
		this.wait_until = 0;
		this.warn_start = 0;
		this.max_distance = this.target_distance;
	}

	function ValidateEnemy() {
		if (this.enemy_id != -1) {
			if (!isPlayerConnected(this.enemy_id) || isPlayerDead(this.enemy_id)) {
				return false;
			}

			local distance = AI_GetDistancePlayers(this.id, this.enemy_id);
			return distance <= this.max_distance;
		}

		return false;
	}

	function Update(ts) {
		if (isPlayerDead(this.id)) {
			return;
		}

		if (!this.ValidateEnemy() && this.collect_target) {
			local last_enemy_id = this.enemy_id;
			this.enemy_id = this.collect_target(this);

			if (last_enemy_id != this.enemy_id) {
				this.OnFocusChange(last_enemy_id, this.enemy_id);
			}
		}

		if (this.enemy_id != -1) {
			this.AttackRoutine(ts);
		} else {
			this.DailyRoutine(ts);
		}
	}

	function AttackRoutine(ts) {
		// Triggered when NPC has a valid enemy target
	}

	function DailyRoutine(ts) {
		// Triggered when NPC has no enemy
	}

	function OnFocusChange(from, to) {
		// Triggered when focused enemy has changed
	}
}