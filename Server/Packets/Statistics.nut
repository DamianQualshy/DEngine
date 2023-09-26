class PlayerStatsMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketString />
	guildname = ""

	</ type = BPacketString />
	classname = ""

	</ type = BPacketInt32 />
	level = -1

	</ type = BPacketInt32 />
	experience = -1

	</ type = BPacketInt32 />
	experience_next = -1

	</ type = BPacketInt32 />
	learnpoints = -1

	</ type = BPacketInt32 />
	stamina = -1

	</ type = BPacketInt32 />
	strength = -1

	</ type = BPacketInt32 />
	dexterity = -1

	</ type = BPacketInt32 />
	mana = -1

	</ type = BPacketInt32 />
	max_mana = -1

	</ type = BPacketInt32 />
	health = -1

	</ type = BPacketInt32 />
	max_health = -1

	</ type = BPacketInt32 />
	onehand = -1

	</ type = BPacketInt32 />
	twohand = -1

	</ type = BPacketInt32 />
	bow = -1

	</ type = BPacketInt32 />
	cbow = -1

	</ type = BPacketString />
	profession_name = ""

	</ type = BPacketInt32 />
	profession_lvl = -1

	</ type = BPacketInt32 />
	profession_exp = -1

	</ type = BPacketInt32 />
	profession_exp_next = -1

	</ type = BPacketInt32 />
	mining = -1

	</ type = BPacketInt32 />
	hunting = -1

	</ type = BPacketInt32 />
	herbalism = -1

	</ type = BPacketInt32 />
	sneaking = -1

	</ type = BPacketInt32 />
	picklocks = -1

	</ type = BPacketInt32 />
	pickpocket = -1

	</ type = BPacketInt32 />
	runes = -1

	</ type = BPacketInt32 />
	alchemy = -1

	</ type = BPacketInt32 />
	smithing = -1

	</ type = BPacketInt32 />
	trophies = -1

	</ type = BPacketInt32 />
	acrobatic = -1

	</ type = BPacketInt32 />
	magiccircle = -1
}

class PlayerClassMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketString />
	guildname = ""

	</ type = BPacketString />
	classname = ""
}

class PlayerHealthMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketInt32 />
	health = -1

	</ type = BPacketInt32 />
	max_health = -1
}

class PlayerManaMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketInt32 />
	mana = -1

	</ type = BPacketInt32 />
	max_mana = -1
}

class PlayerStaminaMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketInt32 />
	stamina = -1
}

class PlayerExpMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketInt32 />
	level = -1

	</ type = BPacketInt32 />
	experience = -1

	</ type = BPacketInt32 />
	experience_next = -1

	</ type = BPacketInt32 />
	learnpoints = -1
}

class PlayerProfessionMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketString />
	profession_name = ""
}

class PlayerProfessionExpMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketInt32 />
	profession_lvl = -1

	</ type = BPacketInt32 />
	profession_exp = -1

	</ type = BPacketInt32 />
	profession_exp_next = -1
}

class PlayerStrengthMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketInt32 />
	strength = -1
}

class PlayerDexterityMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketInt32 />
	dexterity = -1
}

class PlayerOneHandMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketInt32 />
	onehand = -1
}

class PlayerTwoHandMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketInt32 />
	twohand = -1
}

class PlayerBowMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketInt32 />
	bow = -1
}

class PlayerCBowMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketInt32 />
	cbow = -1
}

class PlayerMCircleMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketInt32 />
	magiccircle = -1
}

class PlayerMiningMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketInt32 />
	mining = -1
}

class PlayerHuntingMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketInt32 />
	hunting = -1
}

class PlayerHerbalismMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketInt32 />
	herbalism = -1
}

class PlayerSneakingMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketInt32 />
	sneaking = -1
}

class PlayerPicklockMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketInt32 />
	picklocks = -1
}

class PlayerPickpocketMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketInt32 />
	pickpocket = -1
}

class PlayerRunemakingMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketInt32 />
	runes = -1
}

class PlayerAlchemyMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketInt32 />
	alchemy = -1
}

class PlayerSmithingMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketInt32 />
	smithing = -1
}

class PlayerTrophiesMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketInt32 />
	trophies = -1
}

class PlayerAcrobaticMessage extends BPacketMessage {
	</ type = BPacketInt32 />
	playerId = -1

	</ type = BPacketInt32 />
	acrobatic = -1
}