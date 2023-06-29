local allowed_damage = {DAMAGE_BLUNT = 0, DAMAGE_EDGE = 1, DAMAGE_POINT = 2, DAMAGE_MAGIC = 3}; //Allowed types of Damage
local total_dmg = null; //Amount which will be taken from Player's Health
local kStr = null; //Strength of the Killer
local kMP = null; //Percentage of available Mana of the Killer
local kWeapon = null; //Weapon Mode of the Killer
local kSkill = null; //Weapon Skill of the Killer
local kDmg = null; //Damage dealt by the weapon or spell Killer is wielding
local kMagic = null; //Magic Circle of the Killer
local pHP = null; //Health of the Player
local pProt = null; //Protection the Player

addEventHandler("onInit", function(){
		kMP = (rand() % 500)*0.1;
		kStr = rand() % 500;
		kWeapon = rand() % 4;
		pHP = rand() % 1000;
		pProt = rand() % 200;

		local dmg = 0;
		kDmg = rand() % 50;
			if(kWeapon == allowed_damage.DAMAGE_BLUNT){
				kSkill = rand() % 100;

				dmg = ((kSkill/10) * kStr) / 1.5;
				print("BLUNT ((" + kSkill + ") * " + kStr + ") / 1.5");
			}

			if(kWeapon == allowed_damage.DAMAGE_EDGE){
				kSkill = rand() % 100;

				dmg = ((kSkill/10) * kStr) / 1.5;
				print("EDGE ((" + kSkill + ") * " + kStr + ") / 1.5");
			}

			if(kWeapon == allowed_damage.DAMAGE_POINT){
				kSkill = rand() % 100;

				dmg = ((kSkill/10) * kStr) / 1.5;
				print("POINT ((" + kSkill + ") * " + kStr + ") / 1.5");
			}

			if(kWeapon == allowed_damage.DAMAGE_MAGIC){
				kMagic = rand() % 5 + 1;

				dmg = (kMagic * kMP) / 1.5;
				print("MAGIC (" + kMagic + " * " + kMP + ") / 1.5");
			}

				total_dmg = ((dmg + (kDmg*1.2)) - pProt).tointeger();
				print("TOTAL_DMG ((" + dmg + " + (" + kDmg + "))" + " - " + pProt + ") = " + total_dmg);
				if(total_dmg < 5) total_dmg = 5;

			print(pHP - total_dmg);
			print("Damage " + total_dmg);

			print("Strength " + kStr);
			print("Mana " + kMP);
			print("Weapon " + kWeapon);
			print("Weapon Skill " + kSkill);
			print("Weapon Damage " + kDmg);
			print("Magic Circle " + kMagic);
			print("Health " + pHP);
			print("Protection " + pProt);
});

addEventHandler("onPlayerHit", function(pid, kid, dmg, dmgtype){
	if(kid != -1){
		kMP = getPlayerMaxMana(kid);
		kStr = getPlayerStrength(kid);
		kWeapon = getPlayerWeaponMode(kid);
		pHP = getPlayerHealth(pid);

		dmg = 0;
		kDmg = 1;
			if(dmgtype == DAMAGE_BLUNT){
				if(kWeapon = WEAPONMODE_1HS) kSkill = getPlayerWeaponSkill(WEAPON_1H);
				if(kWeapon = WEAPONMODE_2HS) kSkill = getPlayerWeaponSkill(WEAPON_2H);

				dmg = ((kSkill/100) * kStr) / 1.5;
			}

			if(dmgtype == DAMAGE_EDGE){
				if(kWeapon = WEAPONMODE_1HS) kSkill = getPlayerWeaponSkill(WEAPON_1H);
				if(kWeapon = WEAPONMODE_2HS) kSkill = getPlayerWeaponSkill(WEAPON_2H);

				dmg = ((kSkill/100) * kStr) / 1.5;
			}

			if(dmgtype == DAMAGE_POINT){
				if(kWeapon = WEAPONMODE_BOW) kSkill = getPlayerWeaponSkill(WEAPON_BOW);
				if(kWeapon = WEAPONMODE_CBOW) kSkill = getPlayerWeaponSkill(WEAPON_CBOW);

				dmg = ((kSkill/100) * kStr) / 1.5;
			}

			if(dmgtype == DAMAGE_MAGIC){
				kMagic = getPlayerMagicLevel(kid);

				dmg = (kMagic * kMP) / 1.5;
			}

				total_dmg = (dmg + (kDmg*1.2) / pProt);
				if(total_dmg < 5) total_dmg = 5;

			setPlayerHealth(pid, pHP - total_dmg);
			print("Damage " + total_dmg);
	}
	else print("Killer is not a Player!");
});