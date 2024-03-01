local window = GUI.Window({
	positionPx = {x = 0, y = 0}
	sizePx = {width = 500, height = 300}
	file = "MENU_INGAME.TGA"
})

local msgDraw = GUI.Draw({
	relativePositionPx = {x = 70, y = 20}
	text = "Would you like to see some magic?\nHover over the gold coin!"
	collection = window
})

local itemRender = GUI.ItemRender({
	relativePositionPx = {x = 150, y = 60}
	sizePx = {width = 200, height = 200}
	instance = "ITMI_GOLD"
	collection = window
})

addEventHandler("onInit", function()
{
	setCursorVisible(true)
	window.setVisible(true)
})

itemRender.bind(EventType.MouseIn, function(self)
{
	self.setInstance("ITFO_CHEESE")
})

itemRender.bind(EventType.MouseOut, function(self)
{
	self.setInstance("ITMI_GOLD")
})
