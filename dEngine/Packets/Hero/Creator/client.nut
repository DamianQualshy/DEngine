function heroUpdateHeight(height){
	local heightPacket = HeroHeightMessage(heroId,
		height
		).serialize();
	heightPacket.send(RELIABLE_ORDERED);
}

function heroCreate(params){
	local creatorFinish = HeroCreatorMessage(heroId,
		params.bodyModel,
		params.bodyTex,
		params.headModel,
		params.headTex,
		params.walkAni,
		params.height,
		params.fatness
		).serialize();
	creatorFinish.send(RELIABLE_ORDERED);
}