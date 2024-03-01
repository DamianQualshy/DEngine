local horizontalBar = GUI.Bar({
	position = {x = 100, y = 7525}
	sizePx = {width = 180, height = 20}
	marginPx = [3, 7]
	file = "BAR_BACK.TGA"
	progress = {file = "BAR_MISC.TGA"}
	stretching = true
	visible = true
})

local verticalBar = GUI.Bar({
	position = {x = 100, y = 5000}
	sizePx = {width = 20, height = 180}
	marginPx = [10, 3], 
	file = "MENU_INGAME.TGA", 
	progress = {file = "INV_SLOT_EQUIPPED.TGA"}
	orientation = Orientation.Vertical
	align = Align.Right
	stretching = false
	visible = true
})

addEventHandler("onMouseDown",function(btn)
{
	if (btn != MOUSE_BUTTONRIGHT)
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
