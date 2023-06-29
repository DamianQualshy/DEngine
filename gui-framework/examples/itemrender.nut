// This example assume that ITMI_GOLD & ITFO_CHEESE are listed inside items.xml

local window = GUI.Window(0, 0, anx(600), any(400), "MENU_INGAME.TGA", null, true)
local msg = GUI.Draw(anx(70), any(80), "Would you like too see some magic?\nHover over the gold coin!", window)
local item = GUI.ItemRender(anx(200), any(150), anx(200), any(200), "ITMI_GOLD", window)

addEventHandler("onInit", function()
{
	setCursorVisible(true)

	window.setVisible(true)
})

addEventHandler("GUI.onMouseIn", function(self)
{
	if (!(self instanceof GUI.ItemRender))
		return

	self.setInstance("ITFO_CHEESE")
})

addEventHandler("GUI.onMouseOut", function(self)
{
	if (!(self instanceof GUI.ItemRender))
		return

	self.setInstance("ITMI_GOLD")
})
