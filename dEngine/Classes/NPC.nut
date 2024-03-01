NPCs <- {};

class NPC extends PrototypeHero {
	voice = -1;

	npc_type = -1;
	fight_tactic = -1;

	daily_routine = -1;

	spawn_pos = {
		x = 0.0,
		y = 0.0,
		z = 0.0,
		a = 0.0
	};


		constructor(id, params){
			this.init(id, params);

			NPCs[this.id] <- this;
		}


	function setVoice(voice){
		this.voice = convert(voice, "integer");
	}

	function getVoice(){
		return this.voice;
	}


	function setNPCType(_type){
		this.npc_type = convert(_type, "integer");
	}

	function getNPCType(){
		return this.npc_type;
	}


	function setFightTactic(tactic){
		this.fight_tactic = convert(tactic, "integer");
	}

	function getFightTactic(){
		return this.fight_tactic;
	}


	function setRoutine(routine){
		this.daily_routine = routine;
	}

	function getRoutine(){
		return this.daily_routine;
	}


	function setSpawnPos(x, y, z, angle){
		this.spawn_pos = {
			x = convert(x, "float"),
			y = convert(y, "float"),
			z = convert(z, "float"),
			a = convert(angle, "float")
		};
	}

	function getSpawnPos(){
		return this.spawn_pos;
	}
}