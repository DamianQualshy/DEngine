SVMMessage.bind(function(message){
	local svmSound = Sound3d(message.dialoge);

	svmSound.setTargetPlayer(message.npcId);

	svmSound.play();
});