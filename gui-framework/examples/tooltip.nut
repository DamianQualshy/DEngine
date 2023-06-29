/*
	TODO:
		1.setMarginPx powinno ustawiaæ margines na brzegach, oraz setText/setSize/setSizePx te¿ to powinno wspieraæ?

*/

local redButton = GUI.Button(0, 0, anx(120), any(50), "RED.TGA")
local greenButton = GUI.Button(anx(20), any(20), anx(120), any(50), "GREEN.TGA")
local blueButton = GUI.Button(anx(40), any(40), anx(120), any(50), "BLUE.TGA")
local whiteButton = GUI.Button(anx(60), any(60), anx(120), any(50), "WHITE.TGA")
local blackButton = GUI.Button(anx(80), any(80), anx(120), any(50), "BROWN.TGA")

local button = GUI.Button(2048, 2048, 4096, 4096, "BROWN.TGA")
local button2 = GUI.Button(4096, 4096, 8192, 8192, "GREEN.TGA")

local infoDraw = GUI.Draw(anx(160), 0, "Hover me, for more info...")
infoDraw.setFont("FONT_OLD_20_WHITE_HI.TGA")
infoDraw.toolTip = GUI.ToolTip(anx(10), any(5), "BROWN.TGA", "This buttons shows, how Framework\nworks with depth feature.\nYou can hover the buttons or click them,\nto test the behaviour.")

local toolTip = GUI.ToolTip(anx(4), any(2), "MENU_INGAME.TGA", "")
toolTip.setToolTip(redButton, "[#FF0000]Red")
toolTip.setToolTip(greenButton, "[#00FF00]Green")
toolTip.setToolTip(blueButton, "[#00CCFF]Blue")
toolTip.setToolTip(whiteButton, "[#FFFFFF]White")
toolTip.setToolTip(blackButton, "[#B26630]Brown")

addEventHandler("onInit",function()
{
		redButton.setVisible(true)
		greenButton.setVisible(true)
		blueButton.setVisible(true)
		whiteButton.setVisible(true)
		blackButton.setVisible(true)

		infoDraw.setVisible(true)

		setCursorVisible(true)
})

addEventHandler("GUI.onMouseIn",function(self)
{
	if (!(self instanceof GUI.Button))
		return

	self.setAlpha(125)
})

addEventHandler("GUI.onMouseOut",function(self)
{
	if (!(self instanceof GUI.Button))
		return

	self.setAlpha(255)
})

addEventHandler("GUI.onClick", function(self)
{
	if (!(self instanceof GUI.Button))
		return

		self.top()
})
