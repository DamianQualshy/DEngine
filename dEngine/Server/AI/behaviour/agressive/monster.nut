 class AIMonster extends AIAgressive {
	function AttackRoutine(ts) {
		AI_TurnToPlayer(this.id, this.enemy_id);

		if ((this.wait_until - ts) > 0) {
			return;
		}

		local distance = AI_GetDistancePlayers(this.id, this.enemy_id);
		if (distance > this.attack_distance) {
			if (!AI_Warn(this, ts)) {
				// Warn finished, run to enemy
				playAni(this.id, "S_FISTRUNL");
			}
		} else {
			npcAttackMelee(this.id, this.enemy_id, 1, 1);
			this.wait_until = getTickCount() + 1000;
		}
	}

	function OnFocusChange(from, to) {
		if (to == -1) {
			this.Reset();
		}
	}

	function OnHitReceived(kid, desc) {
		local change_action = rand() % 100;
		if (change_action > 60) {
			local action = rand() % 3
			switch (action) {
			case 0: playAni(this.id, "T_FISTPARADEJUMPB"); break
			case 1: playAni(this.id, "T_FISTRUNSTRAFER"); break
			case 2: playAni(this.id, "T_FISTRUNSTRAFEL"); break
			}

			this.wait_until = getTickCount() + 1000;
		}

		// Change target if killer is closer
		if (this.enemy_id != kid) {
			local enemy_distance = AI_GetDistancePlayers(this.id, this.enemy_id);
			local killer_distance = AI_GetDistancePlayers(this.id, kid);

			if (killer_distance < enemy_distance) {
				this.enemy_id = kid;
			}
		}
	}
 }