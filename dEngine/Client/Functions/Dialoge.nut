local dialogue = {};

local dialogueMenuCollection = GUI.Collection({positionPx = {x = 0, y = 0}});
local dialogueConvoCollection = GUI.Collection({positionPx = {x = 0, y = 0}});


local dialogueMenu = {
	choiceBG = GUI.Texture({
		positionPx = {x = 397, y = 867}
		sizePx = {width = 1126, height = 216}
		file = "DLG_AMBIENT.TGA"
		scaling = true
		collection = dialogueMenuCollection
	}),

	choices = [
		GUI.Draw({
			positionPx = {x = 410, y = 880}
			text = ""
			collection = dialogueMenuCollection
		}),
		GUI.Draw({
			positionPx = {x = 410, y = 910}
			text = ""
			collection = dialogueMenuCollection
		}),
		GUI.Draw({
			positionPx = {x = 410, y = 940}
			text = ""
			collection = dialogueMenuCollection
		}),
		GUI.Draw({
			positionPx = {x = 410, y = 970}
			text = ""
			collection = dialogueMenuCollection
		}),
		GUI.Draw({
			positionPx = {x = 410, y = 1000}
			text = "END"
			collection = dialogueMenuCollection
		})
	]
}

local dialogueConvo = {
	textBG = GUI.Texture({
		positionPx = {x = 536, y = 20}
		sizePx = {width = 846, height = 145}
		file = "DLG_AMBIENT.TGA"
		scaling = true
		collection = dialogueConvoCollection
	}),

	output = [
		GUI.Note({
			positionPx = {x = 560, y = 50}
			sizePx = {width = 798, height = 40}
			text = ""
			align = Align.Center
			collection = dialogueConvoCollection
		}),
		GUI.Note({
			positionPx = {x = 560, y = 75}
			sizePx = {width = 798, height = 64}
			text = ""
			align = Align.Center
			collection = dialogueConvoCollection
		})
	]
}

dialogueConvo.output[0].scrollbar.setDisabled(true);
dialogueConvo.output[1].scrollbar.setDisabled(true);

class DialogueManager {
	isTalking = false;
	npc_id = -1;

	selectedOption = -1;
	selectedMenu = null;
	menuStack = [];

	menuChoices = [];
	conversation = [];

	currentLine = -1;
	currentLineFile = "";
	soundTimer = null;

	offset = 0;

	function render(){
		this.menuChoices.sort(@(first, second) first.nr <=> second.nr);

		for(local i = 0, end = 5; i < end; ++i){
			if(i < this.menuChoices.len()){
				local idx = i + this.offset;
				dialogueMenu.choices[i].setText(this.menuChoices[idx].name);

				if(selectedOption == i){
					dialogueMenu.choices[i].setColor({r = 233, g = 206, b = 159});
				} else {
					dialogueMenu.choices[i].setColor({r = 144, g = 129, b = 97});
				}
			} else {
				dialogueMenu.choices[i].setText("");
			}
		}
	}

	function select() {
		local _selectedOption = this.menuChoices[this.selectedOption];

		if(this.menuChoices.len() != 0){
			local choiceDIA = DialogueChoiceMessage(
				this.selectedMenu.id,
				_selectedOption.nr
			).serialize()
			choiceDIA.send(RELIABLE)

			switch(_selectedOption.nr){
				case DIALOG_BACK:
					if(this.menuStack.len() > 0){
						updateDialogMenu(this.npc_id, this.menuStack.pop());
					} else {
						updateDialogMenu(this.npc_id, 0);
					}
				break;
				case DIALOG_ENDE:
					hideDialogMenu();
				break;
			}

			if("submenu" in _selectedOption && _selectedOption.submenu != null){
					this.menuStack.push(this.selectedMenu.id);
					updateDialogMenu(this.npc_id, _selectedOption.submenu.id);
				return;
			} else {
				if("dialog" in _selectedOption && _selectedOption.dialog.len() > 0){
					dialogueMenuCollection.setVisible(false);
					dialogueConvoCollection.setVisible(true);

					this.currentLine = 0;
					handleDialogue(_selectedOption.dialog[this.currentLine]);
				}
			}
		}
	}
}

local dialogueManager = DialogueManager();

local startTimerTime = 0;
local endTimerTime = 5000;
local talkingID = -1;

local function navigate(key) {
	if(chatInputIsOpen()) return;

	if(dialogueMenuCollection.getVisible() && !dialogueConvoCollection.getVisible()){
		local choicesLen = dialogueManager.menuChoices.len();

		switch(key){
			case KEY_UP:
			case KEY_W:
			case MOUSE_WHEELUP:
				--dialogueManager.selectedOption;
				if(dialogueManager.selectedOption < 0){
					dialogueManager.selectedOption = choicesLen - 1;
					dialogueManager.offset = choicesLen < 5 ? 0 : choicesLen - 5;
				}

				if(dialogueManager.selectedOption < dialogueManager.offset){
					dialogueManager.offset--;
				}
			break;

			case KEY_DOWN:
			case KEY_S:
			case MOUSE_WHEELDOWN:
				++dialogueManager.selectedOption;
				if(dialogueManager.selectedOption == choicesLen){
					dialogueManager.selectedOption = 0;
					dialogueManager.offset = 0;
				}

				if(dialogueManager.selectedOption == 5){
					++dialogueManager.offset;
				}
			break;

			case KEY_RETURN:
			case KEY_LCONTROL:
			case MOUSE_BUTTONLEFT:
				dialogueManager.select();
			break;
		}

		if(dialogueManager.menuChoices != null) dialogueManager.render();
	}
	if(!dialogueMenuCollection.getVisible() && dialogueConvoCollection.getVisible()){
		switch(key){
			case KEY_RETURN:
			case KEY_LCONTROL:
			case MOUSE_BUTTONLEFT:
			case KEY_ESCAPE:
				if(dialogueManager.soundTimer != null){
					killTimer(dialogueManager.soundTimer);
					dialogueManager.soundTimer = null;
				}

				if((dialogueManager.currentLineFile.playingTime > 50 && dialogueManager.currentLineFile.isPlaying())){
					dialogueManager.currentLineFile.stop();
				}
				if((getTickCount() < startTimerTime + endTimerTime)){
					startTimerTime = 0;
				}

				dialogueManager.currentLine++;

				if(dialogueManager.currentLine < dialogueManager.menuChoices[dialogueManager.selectedOption].dialog.len()){
					handleDialogue(dialogueManager.menuChoices[dialogueManager.selectedOption].dialog[dialogueManager.currentLine]);
				} else {
					if(dialogueManager.menuStack.len() > 0){
						updateDialogMenu(dialogueManager.npc_id, dialogueManager.menuStack.pop());
					} else {
						hideDialogMenu();
					}
					stopFaceAni(talkingID, "VISEME");
				}
			break;
		}
	}
}

local function dialogueTimer(){
	if((dialogueManager.currentLineFile.playingTime > 50 && !dialogueManager.currentLineFile.isPlaying()) || (getTickCount() > startTimerTime + endTimerTime)){
		startTimerTime = 0;
		dialogueManager.currentLine++;

		if(dialogueManager.currentLine < dialogueManager.menuChoices[dialogueManager.selectedOption].dialog.len()){
			handleDialogue(dialogueManager.menuChoices[dialogueManager.selectedOption].dialog[dialogueManager.currentLine]);
		} else {
			if(dialogueManager.menuStack.len() > 0){
				updateDialogMenu(dialogueManager.npc_id, dialogueManager.menuStack.pop());
			} else {
				hideDialogMenu();
			}
			stopFaceAni(talkingID, "VISEME");
		}
	}
}

function handleDialogue(dialogLine){
	if(dialogueManager.soundTimer != null){
		killTimer(dialogueManager.soundTimer);
		dialogueManager.soundTimer = null;
	}

		local from_id = ((dialogLine.from == self) ? heroId : dialogueManager.npc_id);
		local to_id = ((dialogLine.to == other) ? dialogueManager.npc_id : heroId);

		if(from_id == heroId){
			dialogueConvo.output[0].setText("");
			dialogueConvo.output[1].setText(dialogLine.text)
			foreach(line in dialogueConvo.output[0].lines){
				line.setColor({r = 255, g = 255, b = 255});
			}
		} else {
			dialogueConvo.output[0].setText(getPlayerName(from_id));
			dialogueConvo.output[1].setText(dialogLine.text)
			foreach(line in dialogueConvo.output[1].lines){
				line.setColor({r = 210, g = 200, b = 70});
			}
		}

		if(getPlayerInstance(to_id) == "PC_HERO"){
			stopFaceAni(to_id, "VISEME");
		}

		if(getPlayerInstance(from_id) == "PC_HERO"){
			stopAni(from_id);
			playFaceAni(from_id, "VISEME");
			playGesticulation(from_id);
		}

		talkingID = from_id;

		Camera.setMode("CAMMODDIALOG", [getPlayerPtr(from_id), getPlayerPtr(to_id)]);

			dialogueManager.currentLineFile = Sound(dialogLine.file);
			dialogueManager.currentLineFile.play();

		startTimerTime = getTickCount();
	dialogueManager.soundTimer = setTimer(dialogueTimer, 500, 0);
}

function showDialogMenu(npc, dialogMenuID = null){
	if(dialogMenuID == null) return;

	dialogueManager.npc_id = npc;
	dialogueManager.selectedOption = 0;
	dialogueManager.selectedMenu = Dialogues[npc][dialogMenuID];
	dialogueManager.menuChoices = Dialogues[npc][dialogMenuID].options;

	dialogueMenuCollection.setVisible(true);
	disableControls(true);

	addEventHandler("onKeyDown", navigate);
}

function updateDialogMenu(npc, dialogMenuID = null){
	if(dialogMenuID == null) return;

	dialogueManager.npc_id = -1;
	dialogueManager.selectedOption = -1;
	dialogueManager.selectedMenu = null;
	dialogueManager.menuChoices = null;

	dialogueManager.currentLine = -1;
	if(dialogueManager.soundTimer != null){
		killTimer(dialogueManager.soundTimer);
		dialogueManager.soundTimer = null;
	}

	dialogueManager.npc_id = npc;
	dialogueManager.selectedOption = 0;
	dialogueManager.selectedMenu = Dialogues[npc][dialogMenuID];
	dialogueManager.menuChoices = Dialogues[npc][dialogMenuID].options;
}

function hideDialogMenu(){
	local exitDIA = DialogueExitMessage(dialogueManager.npc_id).serialize()
	exitDIA.send(RELIABLE)

	dialogueManager.npc_id = -1;
	dialogueManager.selectedOption = -1;
	dialogueManager.selectedMenu = null;
	dialogueManager.menuStack = [];
	dialogueManager.menuChoices = null;

	dialogueManager.currentLine = -1;
	if(dialogueManager.soundTimer != null){
		killTimer(dialogueManager.soundTimer);
		dialogueManager.soundTimer = null;
	}

	dialogueMenuCollection.setVisible(false);
	dialogueConvoCollection.setVisible(false);

	setTimer(function(){
		disableControls(false);
		Camera.setMode("CAMMODNORMAL", [getPlayerPtr(heroId)]);
	}, 50, 1)

	removeEventHandler("onKeyDown", navigate);
}

local assesTalk = ["$SC_HEYWAITASECOND", "$SC_HEYTURNAROUND", "$SC_HEYTURNAROUND02", "$SC_HEYTURNAROUND03", "$SC_HEYTURNAROUND04"];
function initDialogue(npc, menuID = 0){
	if(npc == -1) return;
	if(!Dialogues.rawin(npc) || !Dialogues[npc].rawin(menuID)) return;
	if((dialogueMenuCollection.getVisible() || dialogueConvoCollection.getVisible()) || chatInputIsOpen()) return;

	Daedalus.call("B_Say", getPlayerPtr(heroId), getPlayerPtr(npc), assesTalk[rand() % assesTalk.len()]);

	setTimer(function(){
		showDialogMenu(npc, menuID);
		dialogueManager.render();
	}, 1000, 1)

	local initDIA = DialogueInitMessage(npc).serialize()
	initDIA.send(RELIABLE)

	Camera.setMode("CAMMODDIALOG", [getPlayerPtr(heroId), getPlayerPtr(npc)]);
}