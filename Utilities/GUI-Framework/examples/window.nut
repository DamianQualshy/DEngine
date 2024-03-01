local window = GUI.Window({
	positionPx = {x = 0, y = 0}
	sizePx = {width = 300, height = 200}
	file = "BLACK.TGA"
	color = {a = 180}
	topBar = {
		file = "BLACK.TGA"
		offsetPx = {x = 10, y = 0}

		draw = {
			text = "Dialogue player"
		}

		minimizeButton = {
			sizePx = {width = 45, height = WINDOW_TOPBAR_HEIGHT}
			draw = {
				text = "-"
			}
		}

		closeButton = {
			sizePx = {width = 45, height = WINDOW_TOPBAR_HEIGHT}
			draw = {
				text = "X"
			}
		}
	}
})

local dialogueList = GUI.List({
	relativePositionPx = {x = 0, y = WINDOW_TOPBAR_HEIGHT}
	sizePx = {width = 300, height = 200 - WINDOW_TOPBAR_HEIGHT}
	marginPx = [0, SCROLLBAR_BUTTON_SIZE, 0, 5]
	scrollbar = {
		range = {
			file = "MENU_INGAME.TGA"
			indicator = {file = "BAR_MISC.TGA"}
		}
		increaseButton = {file = "U.TGA"}
		decreaseButton = {file = "O.TGA"}
	}
	collection = window
})

local dialogues = 
[
	{ name = "Xardas", sound = "DIA_ADDON_XARDAS_HELLO_14_00.WAV" },
	{ name = "Nameless Hero", sound = "DIA_XARDAS_HELLO_15_01.WAV" },
	{ name = "Diego", sound = "DIA_DIEGOOW_HALLO_11_00.WAV" },
	{ name = "Gorn", sound = "DIA_GORNOW_HELLO_12_01.WAV" },
	{ name = "Milten", sound = "DIA_MILTENOW_HELLO_03_00.WAV" },
	{ name = "Lares", sound = "DIA_LARES_HALLO_09_00.WAV" },
	{ name = "Lester", sound = "DIA_LESTER_HELLO_13_00.WAV" },
	{ name = "Lee", sound = "DIA_LEE_HALLO_04_00.WAV" },
	{ name = "Garond", sound = "DIA_GAROND_BACKINKAP4_10_08.WAV" },
	{ name = "Abuyin", sound = "DIA_ABUYIN_DU_13_01.WAV" },
	{ name = "Cavalorn", sound = "DIA_ADDON_CAVALORN_HALLO_08_02.WAV" },
	{ name = "Vatras", sound = "DIA_VATRAS_PREACH_05_05.WAV" },
	{ name = "Saturas", sound = "DIA_ADDON_SATURAS_HALLO_14_02.WAV" },
]

// Button events

local function minimizeButton_onMouseIn(self)
{
	self.setColor({a = 80})
	self.setFile("WHITE")
}

local function minimizeButton_onMouseOut(self)
{
	self.setFile("")
}

local function closeButton_onMouseIn(self)
{
	self.setFile("RED")
}

local function closeButton_onMouseOut(self)
{
	self.setFile("")
}

// ListVisibleRow events

local function list_row_onMouseIn(self)
{
	self.setColor({a = 80})
	self.setFile("WHITE")
}

local function list_row_onMouseOut(self)
{
	self.setFile("")
}

local sound = null

local function list_row_onClick(self)
{
	if (sound)
		sound.stop()

	sound = Sound(dialogues[self.getDataRowId()].sound)
	sound.play()
}

addEventHandler("onInit", function()
{
	window.topBar.minimizeButton.bind(EventType.MouseIn, minimizeButton_onMouseIn)
	window.topBar.minimizeButton.bind(EventType.MouseOut, minimizeButton_onMouseOut)

	window.topBar.closeButton.bind(EventType.MouseIn, closeButton_onMouseIn)
	window.topBar.closeButton.bind(EventType.MouseOut, closeButton_onMouseOut)

	foreach (dialog in dialogues)
		dialogueList.addRow({text = dialog.name})

	foreach (visibleRow in dialogueList.visibleRows)
	{
		visibleRow.bind(EventType.MouseIn, list_row_onMouseIn)
		visibleRow.bind(EventType.MouseOut, list_row_onMouseOut)
		visibleRow.bind(EventType.Click, list_row_onClick)
	}

	window.setVisible(true)
	setCursorVisible(true)
})