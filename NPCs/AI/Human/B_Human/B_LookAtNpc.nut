function B_LookAtNpc(self, other){
	if(isValidTarget(other)){
		setPlayerFocus(self, other);
	}
}

function B_TurnToNpc(self, other){
	if(isValidTarget(other)){
		setPlayerFocus(self, other);
	}
}

function B_StopLookAt(self){

}