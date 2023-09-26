addEventHandler("onPlayerUpdate", function(pid, stat){
	if(!Players[pid].isLogged()) return;

	switch(stat){
		case statupdate.guildname:
		case statupdate.classid:
			local updateClass = PlayerClassMessage(pid,
				Players[pid].getGuild(),
				classes[Players[pid].getClass()].name
				).serialize();
			updateClass.send(pid, RELIABLE_ORDERED);
		break;
		case statupdate.health:
		case statupdate.max_health:
			local updateHealth = PlayerHealthMessage(pid,
				Players[pid].getHealth(),
				Players[pid].getMaxHealth()
				).serialize();
			updateHealth.send(pid, RELIABLE_ORDERED);
		break;
		case statupdate.mana:
		case statupdate.max_mana:
			local updateMana = PlayerManaMessage(pid,
				Players[pid].getMana(),
				Players[pid].getMaxMana()
				).serialize();
			updateMana.send(pid, RELIABLE_ORDERED);
		break;
		case statupdate.stamina:
			local updateStamina = PlayerStaminaMessage(pid,
				Players[pid].getStamina()
				).serialize();
			updateStamina.send(pid, RELIABLE_ORDERED);
		break;
		case statupdate.experience:
			if(!Players[pid].isLevelCapped()){
				if(Players[pid].getExperience() >= Players[pid].getNextLevelExp()){
					Players[pid].setLevel(Players[pid].getLevel() + 1);
					Players[pid].setLearnPoints(Players[pid].getLearnPoints() + 10);

					Players[pid].setMaxHealth(Players[pid].getMaxHealth() + 25);
					Players[pid].setHealth(Players[pid].getMaxHealth());
				}
			} else if(Players[pid].getExperience() < Players[pid].getNextLevelExp()) {
				Players[pid].setLevel(Players[pid].getLevel() - 1);
				Players[pid].setLearnPoints(Players[pid].getLearnPoints() - 10);

				Players[pid].setMaxHealth(Players[pid].getMaxHealth() - 25);
				Players[pid].setHealth(Players[pid].getMaxHealth());
			}
			local updateExp = PlayerExpMessage(pid,
				Players[pid].getLevel(),
				Players[pid].getExperience(),
				Players[pid].getNextLevelExp(),
				Players[pid].getLearnPoints()
				).serialize();
			updateExp.send(pid, RELIABLE_ORDERED);
		break;
		case statupdate.profession_name:
			local updateProfession = PlayerProfessionMessage(pid,
				Players[pid].getProfession()
				).serialize();
			updateProfession.send(pid, RELIABLE_ORDERED);
		break;
		case statupdate.profession_exp:
			if(Players[pid].getProfessionExp() >= Players[pid].getNextProfessionLevelExp()){
				Players[pid].setProfessionLevel(Players[pid].getProfessionLevel() + 1);
			} else {
				Players[pid].setProfessionLevel(Players[pid].getProfessionLevel() - 1);
			}
			local updateProfessionExp = PlayerProfessionExpMessage(pid,
				Players[pid].getProfessionLevel(),
				Players[pid].getProfessionExp(),
				Players[pid].getNextProfessionLevelExp()
				).serialize();
			updateProfessionExp.send(pid, RELIABLE_ORDERED);
		break;
		case statupdate.strength:
			local updateStrength = PlayerStrengthMessage(pid,
				Players[pid].getStrength()
				).serialize();
			updateStrength.send(pid, RELIABLE_ORDERED);
		break;
		case statupdate.dexterity:
			local updateDexterity = PlayerDexterityMessage(pid,
				Players[pid].getDexterity()
				).serialize();
			updateDexterity.send(pid, RELIABLE_ORDERED);
		break;
		case statupdate.onehand:
			local updateOneHand = PlayerOneHandMessage(pid,
				Players[pid].getOneHandSkill()
				).serialize();
			updateOneHand.send(pid, RELIABLE_ORDERED);
		break;
		case statupdate.twohand:
			local updateTwoHand = PlayerTwoHandMessage(pid,
				Players[pid].getTwoHandSkill()
				).serialize();
			updateTwoHand.send(pid, RELIABLE_ORDERED);
		break;
		case statupdate.bow:
			local updateBow = PlayerBowMessage(pid,
				Players[pid].getBowSkill()
				).serialize();
			updateBow.send(pid, RELIABLE_ORDERED);
		break;
		case statupdate.cbow:
			local updateCBow = PlayerCBowMessage(pid,
				Players[pid].getCrossbowSkill()
				).serialize();
			updateCBow.send(pid, RELIABLE_ORDERED);
		break;
		case statupdate.magic_circle:
			local updateMCircle = PlayerMCircleMessage(pid,
				Players[pid].getMagicCircle()
				).serialize();
			updateMCircle.send(pid, RELIABLE_ORDERED);
		break;
		case statupdate.mining:
			local updateMining = PlayerMiningMessage(pid,
				Players[pid].getMiningSkill()
				).serialize();
			updateMining.send(pid, RELIABLE_ORDERED);
		break;
		case statupdate.hunting:
			local updateHunting = PlayerHuntingMessage(pid,
				Players[pid].getHuntingSkill()
				).serialize();
			updateHunting.send(pid, RELIABLE_ORDERED);
		break;
		case statupdate.herbalism:
			local updateHerbalism = PlayerHerbalismMessage(pid,
				Players[pid].getHerbalismSkill()
				).serialize();
			updateHerbalism.send(pid, RELIABLE_ORDERED);
		break;
		case statupdate.sneaking:
			local updateSneaking = PlayerSneakingMessage(pid,
				Players[pid].getSneakSkill()
				).serialize();
			updateSneaking.send(pid, RELIABLE_ORDERED);
		break;
		case statupdate.picklock:
			local updatePicklock = PlayerPicklockMessage(pid,
				Players[pid].getPicklockSkill()
				).serialize();
			updatePicklock.send(pid, RELIABLE_ORDERED);
		break;
		case statupdate.pickpocket:
			local updatePickpocket = PlayerPickpocketMessage(pid,
				Players[pid].getPickpocketSkill()
				).serialize();
			updatePickpocket.send(pid, RELIABLE_ORDERED);
		break;
		case statupdate.runes:
			local updateRunemaking = PlayerRunemakingMessage(pid,
				Players[pid].getRuneSkill()
				).serialize();
			updateRunemaking.send(pid, RELIABLE_ORDERED);
		break;
		case statupdate.alchemy:
			local updateAlchemy = PlayerAlchemyMessage(pid,
				Players[pid].getAlchemySkill()
				).serialize();
			updateAlchemy.send(pid, RELIABLE_ORDERED);
		break;
		case statupdate.smith:
			local updateSmithing = PlayerSmithingMessage(pid,
				Players[pid].getSmithSkill()
				).serialize();
			updateSmithing.send(pid, RELIABLE_ORDERED);
		break;
		case statupdate.trophy:
			local updateTrophies = PlayerTrophiesMessage(pid,
				Players[pid].getTrophySkill()
				).serialize();
			updateTrophies.send(pid, RELIABLE_ORDERED);
		break;
		case statupdate.acrobatic:
			local updateAcrobatic = PlayerAcrobaticMessage(pid,
				Players[pid].getAcrobaticSkill()
				).serialize();
			updateAcrobatic.send(pid, RELIABLE_ORDERED);
		break;
	}
});