// WindowBox style

local function windowbox_minimizeButton_onMouseIn(self)
{
	GUI.Texture.setAlpha.call(self, 80)
	self.setFile("WHITE")
}

local function windowbox_minimizeButton_onMouseOut(self)
{
	self.setFile("")
}

local function windowbox_closeButton_onMouseIn(self)
{
	self.setFile("RED")
}

local function windowbox_closeButton_onMouseOut(self)
{
	self.setFile("")
}

local function setWindowBoxStyle(windowBox)
{
	windowBox.minimizeButton.bind(EventType.MouseIn, windowbox_minimizeButton_onMouseIn)
	windowBox.minimizeButton.bind(EventType.MouseOut, windowbox_minimizeButton_onMouseOut)

	windowBox.closeButton.bind(EventType.MouseIn, windowbox_closeButton_onMouseIn)
	windowBox.closeButton.bind(EventType.MouseOut, windowbox_closeButton_onMouseOut)
}

// ListRow style

local function list_row_onMouseIn(self)
{
	GUI.Texture.setAlpha.call(self, 80)
	self.setFile("WHITE")
}

local function list_row_onMouseOut(self)
{
	self.setFile("")
}

local function setListRowStyle(row)
{
	row.bind(EventType.MouseIn, list_row_onMouseIn)
	row.bind(EventType.MouseOut, list_row_onMouseOut)
}

// Test Code

local windowBox = GUI.WindowBox(0, 0, anx(300), any(200) + any(WINDOWBOX_TOPBAR_HEIGHT), "BLACK", "BROWN", "", "", "Dialogue player")
local dialogueList = GUI.List(0, 0, anx(300), any(200), "", "MENU_INGAME.TGA", "BAR_MISC.TGA", "O.TGA", "U.TGA", windowBox)

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

addEventHandler("onInit", function()
{
	setWindowBoxStyle(windowBox)

	dialogueList.setMarginPx(0, 0, 0, 5)

	foreach (dialog in dialogues)
		dialogueList.addRow(dialog.name)

	for (local i = 0, end = dialogueList.getVisibleRowsCount(); i < end; ++i)
		setListRowStyle(dialogueList.getVisibleRow(i))

	windowBox.setVisible(true)
	setCursorVisible(true)
})

addEventHandler("onCommand", function(cmd, arg)
{
	if (cmd != "dialogues")
		return

	windowBox.setVisible(true)
})

local sound = null

addEventHandler("GUI.onClick", function(self)
{
    if (!(self instanceof GUI.VisibleListRow))
        return

	if (self.parent != dialogueList)
		return
    
	if (sound)
		sound.stop()

    sound = Sound(dialogues[self.id].sound)
	sound.play()
})