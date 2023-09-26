local tweenDraw = GUI.Draw({
	position = {x = 0, y = any(500)}
	text = "zoneName"
	font = "FONT_OLD_20_WHITE_HI.TGA",
})
local tweenDrawPos = {x = 0, y = any(500)};
local tweenAni = null;

local soundEnter = Sound("ANVILHIT01.WAV");
local soundExit = Sound("ANVILHIT02.WAV");

addEventHandler("onInit", function(){
	foreach(zone in zones){
		AreaManager.add(zone);
	}
});

addEventHandler("onEnterZone", function(area){
	tweenDrawPos.x = 0;
	tweenDraw.setVisible(true);
		tweenDraw.setText(area.name);
		soundEnter.play();
	tweenAni = Tween(3, tweenDrawPos, {x = anx(getResolution().x - 200), y = any(500)}, Tween.easing.outInCubic);
});

addEventHandler("onExitZone", function(area){
	tweenDrawPos.x = 0;
	tweenDraw.setVisible(true);
		tweenDraw.setText("Wilderness");
		soundExit.play();
	tweenAni = Tween(3, tweenDrawPos, {x = anx(getResolution().x - 200), y = any(500)}, Tween.easing.outInCubic);
});

addEventHandler("Tween.onEnded", function(tween){
	if(tween == tweenAni){
		tweenDraw.setVisible(false);
		tweenDrawPos.x = 0;
	}
});

addEventHandler("onRender", function(){
	if(tweenDraw.getVisible()){
		tweenDraw.setPosition(tweenDrawPos.x, tweenDrawPos.y);
	}
});