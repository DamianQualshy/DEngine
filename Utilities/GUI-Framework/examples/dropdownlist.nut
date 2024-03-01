local window = GUI.Window({
	positionPx = {x = 0, y = 0}
	sizePx = {width = 400, height = 80}
	file = "MENU_INGAME.TGA"
})


local chooseLangDraw = GUI.Draw({
	positionPx = {x = 20, y = 20}
	text = "choose your language:"
	collection = window
})

local greetingsDraw = GUI.Draw({
	positionPx = {x = 180, y = 50}
	text = "Witaj"
	collection = window
})

local langDropDownList = GUI.DropDownList({
	positionPx = {x = 240, y = 20}
	sizePx = {width = 120, height = 20}
	marginPx = [20]
	maxHeightPx = 500
	file = "MENU_INGAME.TGA"
	draw = {text = "DropDownList"}
	list = {file = "MENU_INGAME.TGA"}
	scrollbar = {
		range = {
			file = "MENU_INGAME.TGA"
			indicator = {file = "BAR_MISC.TGA"}
		}
		increaseButton = {file = "U.TGA"}
		decreaseButton = {file = "O.TGA"}
	},

	rows = [
		{text = "English"}
		{text = "Polish"}
		{text = "Russian"}
		{text = "German"}
	]

	selectedIndex = 1
	collection = window
})

addEventHandler("onInit", function()
{
	window.setVisible(true)
})

langDropDownList.bind(EventType.Change, function(self)
{
	switch (self.getSelectedIndex())
	{
		case 0:
			greetingsDraw.setText("Hello")
			break

		case 1:
			greetingsDraw.setText("Witaj")
			break
		
		case 2:
			greetingsDraw.setText("Privet")
			break

		case 3:
			greetingsDraw.setText("Hallo")
			break
	}
})