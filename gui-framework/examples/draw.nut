local draw = GUI.Draw(1000, 1000, "[#F60005]E[#aadd20]x[#aaffff]a[#ed00ef]m[#ff7800]p[#2900ff]l[#F60005]e [#50cc29]T[#cc298a]e[#F60005]x[#50cc29]t")
local draw2 = GUI.Draw(1000, 1250, "HOVER me")

local function draw_onMouseIn(self)
{
	self.setColor(255, 0, 0)
}

local function draw_onMouseOut(self)
{
	self.setText("[#F60005]E[#aadd20]x[#aaffff]a[#ed00ef]m[#ff7800]p[#2900ff]l[#F60005]e [#50cc29]T[#cc298a]e[#F60005]x[#50cc29]t")
}

local function draw2_onMouseIn(self)
{
	self.setText("[#FFFFFF]HOVE[#FF0000]RED")
}

local function draw2_onMouseOut(self)
{
	self.setText("HOVER me")
}

addEventHandler("onInit",function()
{
	draw.setFont("FONT_OLD_20_WHITE_HI.TGA")

	draw.bind(EventType.MouseIn, draw_onMouseIn)
	draw.bind(EventType.MouseOut, draw_onMouseOut)

	draw2.bind(EventType.MouseIn, draw2_onMouseIn)
	draw2.bind(EventType.MouseOut, draw2_onMouseOut)

	draw.setVisible(true)
	draw2.setVisible(true)
	setCursorVisible(true)
})
