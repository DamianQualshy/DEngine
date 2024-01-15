PlayerHeightMessage.bind(function(pid, message){
	local height = message.height;
	setPlayerScale(pid, height, height, height);
});

PlayerLoginMessage.bind(function(pid, message){
	if(Players[pid].doesExist()){
		if(Players[pid].getLogin() == message.login && Players[pid].getPassword() == md5(message.password)){
			if(Players[pid].getLastHero().CK == 0){
				spawnPlayer(pid);

				Players[pid].load();
				Players[pid].logged = true;

				local successPacket = PlayerLoginSuccessMessage(pid).serialize();
				successPacket.send(pid, RELIABLE_ORDERED);

				callEvent("onPlayerLogin", pid);
			} else {
				local registerPacket = PlayerRegisterMessage(pid).serialize();
				registerPacket.send(pid, RELIABLE_ORDERED);
			}
		} else {
			local failPacket = PlayerLoginFailMessage(pid).serialize();
			failPacket.send(pid, RELIABLE_ORDERED);
		}
	} else {
		Players[pid].setLogin(message.login);
		Players[pid].setPassword(md5(message.password));

		local registerPacket = PlayerRegisterMessage(pid).serialize();
		registerPacket.send(pid, RELIABLE_ORDERED);
	}
});

PlayerCreatorMessage.bind(function(pid, message){
	if(Players[pid].isLogged()) return;

		spawnPlayer(pid);
			Players[pid].setName(message.charaName);
			Players[pid].setDescription(message.charaDesc);

		Players[pid].setColor(255, 255, 255);
		Players[pid].promote(0);

			Players[pid].setVisual(message.visBodyM, message.visBodyT, message.visHeadM, message.visHeadT);

			Players[pid].setWalkstyle(message.walk);

			Players[pid].setScale(message.height, message.height, message.height, message.fatness);

			Players[pid].setMaxHealth(message.health);
			Players[pid].setHealth(message.health);
			Players[pid].setMaxMana(message.mana);
			Players[pid].setMana(message.mana);
			Players[pid].setStrength(message.strength);
			Players[pid].setDexterity(message.dexterity);
			Players[pid].setOneHandSkill(message.onehand);
			Players[pid].setTwoHandSkill(message.twohand);
			Players[pid].setBowSkill(message.bow);
			Players[pid].setCrossbowSkill(message.cbow);
			Players[pid].setMagicCircle(message.magiccircle);
				switch(message.talent){
					case "Sneaking":
						Players[pid].setSneakSkill(1);
					break;
					case "Pick Locks":
						Players[pid].setPicklockSkill(1);
					break;
					case "Pickpocket":
						Players[pid].setPickpocketSkill(1);
					break;
					case "Runemaking":
						Players[pid].setRuneSkill(1);
					break;
					case "Alchemy":
						Players[pid].setAlchemySkill(1);
					break;
					case "Smithing":
						Players[pid].setSmithSkill(1);
					break;
					case "Collecting Trophies":
						Players[pid].setTrophySkill(1);
					break;
					case "Agility":
						Players[pid].setAcrobaticSkill(1);
					break;
				}

	local class_spawn = classes[Players[pid].getClass()].spawn;
		Players[pid].setPosition(class_spawn.x, class_spawn.y, class_spawn.z, class_spawn.a);
		Players[pid].setVirtualWorld(virtualworlds.TESTING);

		Players[pid].bulkSendStats();
		Players[pid].logged = true;

		//Players[pid].save();

		callEvent("onPlayerRegister", pid);
});