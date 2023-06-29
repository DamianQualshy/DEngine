local window = GUI.Window(0, 0, anx(400), any(200), "MENU_INGAME.TGA", null, true)
local closeButton = GUI.Button(anx(350), 0, anx(50), any(25), "INV_SLOT_FOCUS.TGA", "X", window)
local msg = GUI.Draw(anx(70), any(80), "Would you like an update?", window)
local yesButton = GUI.Button(anx(125), any(120), anx(50), any(25), "INV_SLOT_FOCUS.TGA", "Yes", window)
local noButton = GUI.Button(anx(225), any(120), anx(50), any(25), "INV_SLOT_FOCUS.TGA", "No", window)

addEventHandler("onInit",function()
{
	setCursorVisible(true)

	window.setVisible(true)
})

addEventHandler("GUI.onClick", function(self)
{
	switch (self)
	{
		case closeButton:
			window.setVisible(false)
			break

		case yesButton:
			msg.setText("Update completed [#7676f7]successfully!")
			break

		case noButton:
			msg.setText("Nah.. [#F60005]that's a pitty")
			break
	}
})

addEventHandler("GUI.onMouseIn", function(self)
{
	if (!(self instanceof GUI.Button))
		return

	self.setColor(255, 0, 0)
})

addEventHandler("GUI.onMouseOut", function(self)
{
	if (!(self instanceof GUI.Button))
		return

	self.setColor(255, 255, 255)
})
