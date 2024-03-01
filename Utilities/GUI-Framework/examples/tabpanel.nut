// style
addEventHandler("GUI.onSwitch", function(current, previous)
{
	if (previous)
		previous.setFile("INV_SLOT_EQUIPPED.TGA")

	if (current)
		current.setFile("INV_SLOT_EQUIPPED_FOCUS.TGA")
})

local window = GUI.Window({
	position = {x = 0, y = TAB_HEIGHT}
	sizePx = {width = 400, height = 400}
	file = "MENU_INGAME.TGA"
})

local tabHomeCollection = GUI.Collection({
	positionPx = {x = 0, y = 0}
})

local tabHomeDraw = GUI.Draw({
	relativePositionPx = {x = 20, y = 40}
	text = "The framework itself simplifies the\n"
		 + "process of managing the multiple\n"
		 + "views made on different tabs.\n"
		 + "Just try to switch between these\n"
		 + "tabs and see what will happen."
	collection = tabHomeCollection
})

local tabAboutUsCollection = GUI.Collection({
	positionPx = {x = 0, y = 0}
})

local tabAboutUsDraw = GUI.Draw({
	relativePositionPx = {x = 20, y = 40}
	text = "The framework was written and\n"
		 + "maintained by multiple people\n"
		 + "including:\n"
		 + "- Tommy\n"
		 + "- Patrix\n"
		 + "- Kotolland"
	collection = tabAboutUsCollection
})

local tabPanel = GUI.TabPanel({
	relativePositionPx = {x = 0, y = 0}
	sizePx = {width = 400, height = TAB_HEIGHT}
	marginPx = [5, 10]
	file = "MENU_INGAME.TGA"
	collection = window
	tabs = [
		{
			file = "INV_SLOT_EQUIPPED.TGA"
			draw = {text = "Home"}
			collection = tabHomeCollection
		}

		{
			file = "INV_SLOT_EQUIPPED.TGA"
			draw = {text = "About us"}
			collection = tabAboutUsCollection
		}
	]
})

addEventHandler("onInit", function()
{
	setCursorVisible(true)
	window.setVisible(true)
})
