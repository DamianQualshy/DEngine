function B_Say_Smalltalk(self, other){
	local randVoice = rand() % 16 + 1;
	local randFile = (rand() % 30) + 1;

	local randSVM = format("SVM_%d_SMALLTALK%02d.WAV", randVoice, randFile);

	B_Say(self, other, randSVM);
}