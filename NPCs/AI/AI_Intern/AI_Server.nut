function AI_OutputSVM(self, other, text){
	for(local i = 0, end = getMaxSlots(); i < end; ++i){
		if(!Players.rawin(i)) continue;
		if(!Players[i].isLogged()) continue;

		if(getPlayerDistanceToNpc(i, self) > 1000) continue;

		local OutputSVM = SVMMessage(i,
			self,
			text
			).serialize();
		OutputSVM.send(i, RELIABLE_ORDERED);
	}
}