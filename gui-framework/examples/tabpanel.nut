local horizontalPanel = GUI.TabPanel(0, 0, anx(400), any(TAB_HEIGHT), "MENU_INGAME.TGA")
local horizontalTabs = []

horizontalTabs.push(horizontalPanel.addTab("INV_SLOT_EQUIPPED.TGA", "Page 1"))
horizontalTabs.push(horizontalPanel.addTab("INV_SLOT_EQUIPPED.TGA", "Page 2"))
horizontalTabs.push(horizontalPanel.addTab("INV_SLOT_EQUIPPED.TGA", "Page 3"))
horizontalTabs.push(horizontalPanel.addTab("INV_SLOT_EQUIPPED.TGA", "Page 4"))

horizontalPanel.setMarginPx(5, 10, 5, 10)

local verticalPanel = GUI.TabPanel(anx(400), any(TAB_HEIGHT), anx(TAB_WIDTH), any(TAB_HEIGHT * 4), "", Orientation.Vertical)
local verticalTabs = []

verticalTabs.push(verticalPanel.addTab("INV_SLOT_EQUIPPED.TGA", "Page 1"))
verticalTabs.push(verticalPanel.addTab("INV_SLOT_EQUIPPED.TGA", "Page 2"))
verticalTabs.push(verticalPanel.addTab("INV_SLOT_EQUIPPED.TGA", "Page 3"))
verticalTabs.push(verticalPanel.addTab("INV_SLOT_EQUIPPED.TGA", "Page 4"))

local debugCollection = GUI.Collection(anx(0), any(500))
local addLastTabButton = GUI.Button(anx(0), any(0), anx(200), any(40), "MENU_INGAME.TGA", "Add last tab", debugCollection)
local removeLastTabButton = GUI.Button(anx(200), any(0), anx(200), any(40), "MENU_INGAME.TGA", "Remove last tab", debugCollection)
local addFirstTabButton = GUI.Button(anx(0), any(40), anx(200), any(40), "MENU_INGAME.TGA", "Add first tab", debugCollection)
local removeFirstTabButton = GUI.Button(anx(200), any(40), anx(200), any(40), "MENU_INGAME.TGA", "Remove first tab", debugCollection)

addEventHandler("onInit", function()
{
	setCursorVisible(true)

	horizontalPanel.setVisible(true)
	verticalPanel.setVisible(true)

	debugCollection.setVisible(true)
})

addEventHandler("GUI.onSwitch",function(current, previous)
{
	if (previous)
		previous.setFile("INV_SLOT_EQUIPPED.TGA")

	if (current)
		current.setFile("INV_SLOT_EQUIPPED_FOCUS.TGA")
})

addEventHandler("GUI.onClick", function(self)
{
	switch (self)
	{
		case addLastTabButton:
			horizontalTabs.push(horizontalPanel.addTab("INV_SLOT_EQUIPPED.TGA", "Page "+(horizontalPanel.tabs.len() + 1)))
			verticalTabs.push(verticalPanel.addTab("INV_SLOT_EQUIPPED.TGA", "Page "+(verticalPanel.tabs.len() + 1)))
			break

		case removeLastTabButton:
			local len = horizontalPanel.tabs.len()

			if (!len)
				return

			horizontalPanel.removeTab(len - 1)
			horizontalTabs.remove(len - 1)

			verticalPanel.removeTab(len - 1)
			verticalTabs.remove(len - 1)
			break

		case addFirstTabButton:
			horizontalTabs.insert(0, horizontalPanel.insertTab(0, "INV_SLOT_EQUIPPED.TGA", "Page "+(horizontalPanel.tabs.len() + 1)))
			verticalTabs.insert(0, verticalPanel.insertTab(0, "INV_SLOT_EQUIPPED.TGA", "Page "+(verticalPanel.tabs.len() + 1)))
			break

		case removeFirstTabButton:
			if (!(0 in horizontalTabs))
				return

			horizontalTabs.remove(0)
			horizontalPanel.removeTab(0)

			verticalTabs.remove(0)
			verticalPanel.removeTab(0)
			break
	}
})
