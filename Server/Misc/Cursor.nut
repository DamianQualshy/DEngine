local coordinates = GUI.Draw({
	position = {x = 1000, y = 1000},
	text = "x / y ||| height / width",
	font = "FONT_DEFAULT.TGA"
});
coordinates.setVisible(true);
local coordinates2 = GUI.Draw({
	position = {x = 1000, y = 1100},
	text = "x / y ||| height / width",
	font = "FONT_DEFAULT.TGA"
});
coordinates2.setVisible(true);

addEventHandler("GUI.onMouseIn", function(self){
	if(!isCursorVisible()) return;

	if(self instanceof GUI.Button){
		self.setColor({r = 255, g = 0, b = 0});
		setCursorTxt("L.TGA");
	}

	if(self instanceof GUI.GridListVisibleCell){
		self.setColor({r = 132, g = 0, b = 255});
		self.setFile("Menu_Choice_Back.TGA");
	}

	if(self instanceof GUI.Input){
		setCursorTxt("L.TGA");
	}

	coordinates.setText(format("%d / %d ||| %d / %d", self.getPosition().x, self.getPosition().y, self.getSize().width, self.getSize().height));
	coordinates2.setText(format("%d / %d ||| %d / %d", nax(self.getPosition().x), nay(self.getPosition().y), nax(self.getSize().width), nay(self.getSize().height)));
});

addEventHandler("GUI.onMouseOut", function(self){
	if(!isCursorVisible()) return;

	if(self instanceof GUI.Button){
		self.setColor({r = 255, g = 255, b = 255});
		setCursorTxt("LO.TGA");
	}

	if(self instanceof GUI.GridListVisibleCell){
		self.setColor({r = 255, g = 255, b = 255});
		self.setFile("");
	}

	if(self instanceof GUI.Input){
		setCursorTxt("LO.TGA");
	}
});