local table
local column1
local column2
local counter

//  Remove focused data cell:
local function cell_onClick(self)
{
	local dataCell = self.getDataCell()
	local row = dataCell.parent

	row.removeCell(dataCell.column)
}

local function createTable()
{
	table = GUI.Table(0, 0, anx(600), any(300), "MENU_INGAME.TGA", "MENU_INGAME.TGA", "BAR_MISC.TGA", "O.TGA", "U.TGA")
	table.setRowHeightPx(50)

	column1 = table.addColumn("MENU_INGAME.TGA", "Column 1", anx(300))
	column2 = table.insertColumn(0, "MENU_INGAME.TGA", "Column 2")    //  Column 2 is now first!
	
	column2.setRowsAlignment(Align.Right)
	column2.setFont("FONT_OLD_20_WHITE.TGA")
	
	counter = 0

	foreach (column in table.columns)
	{
		foreach (visibleRow in table.visibleRows)
			visibleRow.cells[column].bind(EventType.Click, cell_onClick)
	}
}

local random = @() rand() % 100

addEventHandler("onInit", function()
{
	createTable()

	print("F2: Show cursor & element")
	print("F3: Add row at end")
	print("F4: Insert row at first index")
	print("F5: Set margin")
	print("F6: Set spacing beetwen rows")
	print("F7: Set row height")
	print("F8: Remove column 2")
	print("F9: Clear all rows")
	print("F10: Toggle disable")
	print("F11: Set column spacing")
	print("F12: Destroy table")

})

addEventHandler("onKey", function(key)
{
	switch(key)
	{
		//  Show cursor & element:
		case KEY_F2:
		{
			if (!table)
				createTable()

			local opposite = !table.getVisible()
			table.setVisible(opposite)
			setCursorVisible(opposite)
		}
		break

		//  Add row at end:
		case KEY_F3:
			local row = table.addRow(++counter, counter)
			row.cells[column1].setDrawColor(255, 0, 0)

			//	There is possibility of removing this column, so we should check, if this instance is not null:
			if (column2)
				row.cells[column2].setDrawColor(0, 255, 0)
		break

		//  Insert row at first index:
		case KEY_F4:
			local row = table.insertRow(0, random(), random())
			row.cells[column1].setFile("MENU_INGAME.TGA")
			row.cells[column1].setDrawColor(200, 200, 0)
			row.cells[column1].setColor(0, 200, 200)
			row.cells[column1].setFont("FONT_OLD_20_WHITE_HI.TGA")
		break

		//  Set margin:
		case KEY_F5:
			table.setMarginPx(20, 20, 20, 20)
		break

		//  Spacing beetwen rows:
		case KEY_F6:
			table.setRowSpacingPx(10)
		break

		//  Row height:
		case KEY_F7:
			table.setRowHeightPx(100)
		break

        //  Remove column 2
        case KEY_F8:
		{
			if (column2)
			{
				table.removeColumn(column2.id)
				column2 = null
			}
		}
        break

        //  Clear all rows:
        case KEY_F9:
            table.clear()
        break

		//	Toggle disable:
        case KEY_F10:
            table.setDisabled(!table.getDisabled())
        break

		//	Column spacing:
		case KEY_F11:
			table.setColumnSpacingPx(20)
		break

        //  Delete whole table:
        case KEY_F12:
		{
			if (table)
			{
				column1 = null
				column2 = null
				table = table.destroy()
			}
		}
        break
	}
})