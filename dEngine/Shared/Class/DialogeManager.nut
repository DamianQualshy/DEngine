Dialogues <- {};

class DialogueOutput {
	from = -1;
	to = -1;

	file = "";
	text = "";

		constructor(speaker, receiver, file, text){
			this.from = speaker;
			this.to = receiver;

			this.file = format("%s.WAV", file);
			this.text = text;
		}
}

class DialogueOption {
	name = "";

	nr = -1;
	condition = null;

	dialog = [];
	submenu = null;

		constructor(params){
			this.name = params.name;

			this.nr = params.nr;
			this.condition = params.condition;

			this.dialog = "dialog" in params ? params.dialog : [];
			this.submenu = "submenu" in params ? params.submenu : null;
		}
}

class DialogueMenu {
	name = "";

	npc = -1;
	id = -1;

	condition = null;

	options = [];

		constructor(params){
			this.name = params.name;

			this.npc = (typeof(params.npc) == "integer") ? params.npc : params.npc.id;

			this.condition = params.condition;

			this.options = "options" in params ? params.options : [];

			if(!(this.npc in Dialogues)){
				Dialogues[this.npc] <- {};
				this.id = 0;
			} else {
				this.id = Dialogues[this.npc].len();
			}

			Dialogues[this.npc][this.id] <- this;
		}

	function addOption(params){
		this.options.push(DialogueOption(params));
	}
}