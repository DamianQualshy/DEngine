addEventHandler("onPacket", function(pid, packet){
	local packetId = packet.readUInt8();
	switch(packetId){
		case packets.login:
			//if(loginGUIvisible){
				local login = packet.readString();
				local passwd = packet.readString();
				if(Players[pid].doesExist()){
					if(Players[pid].getLogin() == login && Players[pid].getPassword() == md5(passwd)){
							spawnPlayer(pid);

						Players[pid].load();
						Players[pid].logged = true;

							packet.reset();
							packet.writeUInt8(packets.login_success);
							packet.send(pid, RELIABLE_ORDERED);
					} else {
						packet.reset();
						packet.writeUInt8(packets.login_fail);
						packet.send(pid, RELIABLE_ORDERED);
					}
				} else {
					Players[pid].setLogin(login);
					Players[pid].setPassword(md5(passwd));

						packet.reset();
						packet.writeUInt8(packets.login_register);
						packet.send(pid, RELIABLE_ORDERED);
				}
			//}
		break;
		case packets.creator_scale:
			//if(creatorGUIvisible){
				local height = packet.readFloat();
				setPlayerScale(pid, height, height, height);
			//}
		break;
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
});