guiOpened <- null;

enum guiCheck {
	login,
	creator,
	anim,
	stats,
	inventory,
	trade
}

loginGUIvisible <- null;
creatorGUIvisible <- null;
animGUIvisible <- null;
statsGUIvisible <- null;
statsGUIswitch_num <- null;
inventoryGUIvisible <- null;
tradeGUIvisible <- null;

enum animations {
	ACTIVE,
	REACTION,
	IDLE
}