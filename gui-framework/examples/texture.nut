local texture = GUI.Texture(0, 0, 2048, 2048, "INV_TITEL.TGA")
texture.setScaling(true)

local animTexture = GUI.Texture(2048, 4096, 4096, 4096, "OWODWFALL_HITSURFACE_A0.TGA")

animTexture.setFPS(10)
animTexture.setBeginFrame(0)
animTexture.setEndFrame(14)

addEventHandler("onInit", function()
{
	texture.setVisible(true)
	animTexture.setVisible(true)

	setCursorVisible(true)
})

addEventHandler("GUI.onMouseIn", function(self)
{
	if (self != texture)
		return

	texture.setColor(255, 255, 0)
	animTexture.stop()
})

addEventHandler("GUI.onMouseOut", function(self)
{
	if (self != texture)
		return

	texture.setColor(255, 255, 255)
	animTexture.play()
})

addEventHandler("GUI.onMouseDown", function(self, btn)
{
	if (self != texture)
		return

	texture.setColor(0, 255, 0)
})

addEventHandler("GUI.onMouseUp", function(self, btn)
{
	if (self != texture)
		return

	if (self.isMouseAt())
		texture.setColor(255, 255, 0)
	else
		texture.setColor(255, 255, 255)
})
