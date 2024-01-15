addEventHandler("onPlayerHit", function(pid, kid, desc){
	calculateDamage(pid, kid, desc.damage);
	updateFocusHealth(kid, pid);

	cancelEvent();
});

FocusHitMessage.bind(function(pid, message){
	calculateDamage(message.focusId, pid, message.damage);
	updateFocusHealth(pid, message.focusId);
});

function calculateDamage(pid, kid, dmg){
	if(isNpc(pid)){
		local curr_hp = NPCs[pid].getHealth();

		NPCs[pid].setHealth(curr_hp - dmg);
	} else {
		local curr_hp = Players[pid].getHealth();

		//local g2_damage = max(5, weaponDmg + str - armor);
		//eventValue(g2_damage);

		Players[pid].setHealth(curr_hp - dmg);
	}
}