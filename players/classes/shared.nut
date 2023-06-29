classes <- [
	{
		name = "Podró¿nik",
		guild = "Brak",
		spawn = [38609.4, 3910.47, -1259.92, 142.253],
		func = function(id) {
			setPlayerHealth(id, 100);
			setPlayerMaxHealth(id, 100);
			setPlayerMana(id, 10);
			setPlayerMaxMana(id, 10);
			setPlayerStrength(id, 20);
			setPlayerDexterity(id, 20);
			setPlayerSkillWeapon(id, WEAPON_1H, 10);
			setPlayerSkillWeapon(id, WEAPON_2H, 10);
			setPlayerSkillWeapon(id, WEAPON_BOW, 10);
			setPlayerSkillWeapon(id, WEAPON_CBOW, 10);
			setPlayerTalent(id, 0, 1);
		addItem(id, "ITAR_LEATHER_L", 1);
		addItem(id, "ITMW_NAGELKNUEPPEL", 1);
		}
	}
];
