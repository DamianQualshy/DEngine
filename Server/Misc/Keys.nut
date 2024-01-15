local disabled_game_keys = array(255, false);

//disabled_game_keys[KEY_ESCAPE] = true;
disabled_game_keys[KEY_B] = true;
disabled_game_keys[KEY_C] = true;
disabled_game_keys[KEY_N] = true;
disabled_game_keys[KEY_L] = true;
disabled_game_keys[KEY_M] = true;
disabled_game_keys[KEY_TAB] = true;

local coordinates = GUI.Draw({
	position = {x = 1000, y = 2000},
	text = "x y z",
	font = "FONT_DEFAULT.TGA"
});
coordinates.setVisible(true);

addEventHandler("onKeyDown", function(key){
	if(chatInputIsOpen()) return;

	if(key in disabled_game_keys && disabled_game_keys[key]){
		cancelEvent();
	}

	if(loginGUIvisible || creatorGUIvisible || animGUIvisible || statsGUIvisible) return;

	switch(key){
		case KEY_K:
			//enableFreeCam(!isFreeCamEnabled());
		break;
		case KEY_J:
			local campos = Camera.getPosition();
			local pos = getPlayerPosition(heroId);
			coordinates.setText(format("%f %f %f", campos.x - pos.x, campos.y - pos.y, campos.z - pos.z));
		break;
	}
});