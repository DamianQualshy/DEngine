local texture = GUI.Texture({
	position = {x = 0, y = 0}
	size = {width = 2048, height = 2048}
	file = "INV_TITEL.TGA"
	scaling = true
})

local animTexture = GUI.Texture({
	position = {x = 2048, y = 4096}
	size = {width = 4096, height = 4096}
	file = "OWODWFALL_HITSURFACE_A0.TGA"
	scaling = true
	beginFrame = 0
	endFrame = 14
	FPS = 10
})

addEventHandler("onInit", function()
{
	texture.setVisible(true)
	animTexture.setVisible(true)

	setCursorVisible(true)
})

texture.bind(EventType.MouseIn, function(self)
{
	self.setColor({r = 255, g = 255, b = 0})
	animTexture.stop()
})

texture.bind(EventType.MouseOut, function(self)
{
	self.setColor({r = 255, g = 255, b = 255})
	animTexture.play()
})

texture.bind(EventType.MouseDown, function(self, btn)
{
	self.setColor(0, 255, 0)
})

texture.bind(EventType.MouseUp, function(self, btn)
{
	if (self.isMouseAt())
		self.setColor({r = 255, g = 255, b = 0})
	else
		self.setColor({r = 255, g = 255, b = 255})
})
