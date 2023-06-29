local horizontalBar = GUI.Bar(100, 7525, anx(180), any(20), anx(7), any(3), "BAR_BACK.TGA", "BAR_MISC.TGA", Orientation.Horizontal)
local verticalBar = GUI.Bar(100, 5000, anx(20), any(180), anx(3), any(10), "MENU_INGAME.TGA", "INV_SLOT_EQUIPPED.TGA", Orientation.Vertical, Align.Right)

addEventHandler("onInit",function()
{
	horizontalBar.setVisible(true)
	horizontalBar.setStretching(false)

	verticalBar.setVisible(true)
	verticalBar.setStretching(false)
})

addEventHandler("onMouseClick",function(btn)
{
	if (btn != MOUSE_RMB)
		return

	local value = horizontalBar.getValue()

	if (value >= horizontalBar.getMaximum())
		value = horizontalBar.getMinimum()

	horizontalBar.setValue(value + 10)

	value = verticalBar.getValue()

	if (value >= verticalBar.getMaximum())
		value = verticalBar.getMinimum()

	verticalBar.setValue(value + 10)
})
