function B_Say(self, other, text){
	playAni(self, format("T_DIALOGGESTURE_%02d", (rand() % 10) + 1));

	AI_OutputSVM(self, other, text);
}