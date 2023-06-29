local newDropdownlist

local counter = 0
local random = @() rand() % 100

local function row_onClick(self)
{
	local list = self.parent
	local dropdownlist = list.parent

	dropdownlist.removeRow(self.getDataRow().id)
}

addEventHandler("onInit", function()
{
	newDropdownlist = GUI.DropDownList(0, 0, anx(600), any(80), "MENU_INGAME.TGA", "Dropdownlist", any(500), "MENU_INGAME.TGA", "MENU_INGAME.TGA", "BAR_MISC.TGA", "O.TGA", "U.TGA")
    newDropdownlist.setMarginPx(20, 20, 20, 20)

	local visibleRows = newDropdownlist.list.visibleRows
	foreach (visibleRow in visibleRows)
		visibleRow.bind(EventType.Click, row_onClick)
})

addEventHandler("onKey", function(key)
{
	switch (key)
	{
		case KEY_F2:
			local vis = !newDropdownlist.getVisible()
			newDropdownlist.setVisible(vis)
			setCursorVisible(vis)
		break

				//  Add new row and set texture:
		case KEY_F3:
			local row = newDropdownlist.addRow(counter++)
			row.setFile("MENU_INGAME.TGA")
			row.setDrawColor(200, 200, 0)
			row.setColor(0, 200, 200)
		break

		//  Add new row at first index:
		case KEY_F4:
			local row = newDropdownlist.insertRow(0, random())
		break

		//  Clear list:
		case KEY_F5:
			newDropdownlist.clear()
		break

		//  Spacing beetwen rows:
		case KEY_F6:
			newDropdownlist.setRowSpacingPx(10)
		break

		//  Row height:
		case KEY_F7:
			newDropdownlist.setRowHeightPx(100)
		break

		//  Font:
		case KEY_F8:
			newDropdownlist.list.setFont("FONT_OLD_20_WHITE_HI.TGA")
		break

        //  Change max list height:
		case KEY_F9:
			newDropdownlist.setMaxHeightPx(600)
		break

        //  Change column alignment:
        case KEY_F10:
            newDropdownlist.setAlignment(Align.Right)
        break

        //  Change rows alignment:
        case KEY_F11:
            newDropdownlist.list.setAlignment(Align.Left)
        break

        //  Toggle closing on row click:
        case KEY_F12:
            newDropdownlist.closeOnRowClick = !newDropdownlist.closeOnRowClick
        break
	}
})