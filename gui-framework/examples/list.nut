local list = GUI.List(0, 0, anx(600), any(300), "MENU_INGAME.TGA", "MENU_INGAME.TGA", "BAR_MISC.TGA", "O.TGA", "U.TGA")
list.setMarginPx(20, 20, 20, 20)
list.setRowHeightPx(50)

local counter = 0
local random = @() rand() % 100

local function row_onClick(self)
{
    local list = self.parent
    list.removeRow(self.getDataRow().id)
}

addEventHandler("onInit", function()
{
    foreach (visibleRow in list.visibleRows)
        visibleRow.bind(EventType.Click, row_onClick)
})

addEventHandler("onKey", function(key)
{
	switch(key)
	{
        //  Show cursor & element:
		case KEY_F2:
			local opposite = !list.getVisible()
			list.setVisible(opposite)
			setCursorVisible(opposite)
		break

        //  Add new row and set texture:
		case KEY_F3:
			local row = list.addRow(counter++)
			row.setFile("MENU_INGAME.TGA")
            row.setDrawColor(200, 200, 0)
            row.setColor(0, 200, 200)
		break

        //  Add new row at first index:
		case KEY_F4:
			local row = list.insertRow(0, random())
		break

        //  Clear list:
        case KEY_F5:
            list.clear()
        break

        //  Spacing beetwen rows:
        case KEY_F6:
            list.setRowSpacingPx(10)
        break

        //  Row height:
        case KEY_F6:
            list.setRowHeightPx(200)
        break

        //  Font:
        case KEY_F7:
            list.setFont("FONT_OLD_20_WHITE_HI.TGA")
        break

        //  Row height:
        case KEY_F8:
            list.setRowHeightPx(80)
        break
	}
})