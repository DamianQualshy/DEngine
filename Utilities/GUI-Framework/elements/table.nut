local GUITableColumnClasses = classes(GUI.Button, GUI.GridListColumn)
class GUI.TableColumn extends GUITableColumnClasses
{	
	constructor(id, parent, arg)
	{
		GUI.Button.constructor.call(this, arg)
		GUI.GridListColumn.constructor.call(this, id, parent, arg)
	}
}

class GUI.Table extends GUI.GridList
{
	function setPositionPx(x, y)
	{
		local positionPx = getPositionPx()
		GUI.Texture.setPositionPx.call(this, x, y)
		
		local offsetXPx = x - positionPx.x
		local offsetYPx = y - positionPx.y

        local scrollbarPositionPx = scrollbar.getPositionPx()
        scrollbar.setPositionPx(scrollbarPositionPx.x + offsetXPx, scrollbarPositionPx.y + offsetYPx)

        foreach (column in columns)
        {
			local columnPositionPx = column.getPositionPx()
			column.setPositionPx(columnPositionPx.x + offsetXPx, columnPositionPx.y + offsetYPx)

			foreach (visibleRow in visibleRows)
			{
				local visibleCell = visibleRow.cells[column]
				local visibleCellPositionPx = visibleCell.getPositionPx()
				visibleCell.setPositionPx(visibleCellPositionPx.x + offsetXPx, visibleCellPositionPx.y + offsetYPx)
			}
        }
	}

	function setDisabled(toggle)
	{
		GUI.Texture.setDisabled.call(this, toggle)
		scrollbar.setDisabled(toggle)

		foreach (column in columns)
		{
			column.setDisabled(toggle)
			foreach (visibleRow in visibleRows)
			{
				if (column in visibleRow.cells)
					visibleRow.cells[column].setDisabled(toggle)
			}
		}
	}

	function top()
	{
		GUI.Texture.top.call(this)
		scrollbar.top()

		foreach (column in columns)
		{
			column.top()
			foreach (visibleRow in visibleRows)
			{
				if (column in visibleRow.cells)
					visibleRow.cells[column].top()
			}
		}
	}

	function setVisible(toggle)
	{
		GUI.Texture.setVisible.call(this, toggle)

		foreach (column in columns)
		{
			column.setVisible(toggle)
			foreach (visibleRow in visibleRows)
			{
				local visibleCell = visibleRow.cells[column]
				visibleCell.setVisible(toggle && visibleCell.getDataCell())
			}
		}
			
		updateScrollbarVisibility()
	}

	function insertColumn(colId, arg = null)
	{
		local marginPx = getMarginPx()
		local freeWidthPx = getSizePx().width - marginPx.right - marginPx.left - _columnsWidthPx
		local column = GUI.TableColumn(colId, this, arg)

		if (column._widthPx <= 0 || column._widthPx > freeWidthPx)
			column._widthPx = freeWidthPx

		column.setSizePx(column._widthPx, _rowHeightPx)
		column.setDisabled(getDisabled())
		if (getVisible())
			column.setVisible(true)

		columns.insert(colId, column)
		for (local i = colId + 1, end = columns.len(); i < end; ++i)
			++columns[i].id

		_columnsWidthPx += column._widthPx

		updateColumns()
		return column
	}

	function updateVisibleRows()
	{
		local oldVisibleRowsLen = visibleRows.len()
		local marginPx = getMarginPx()
		local rowSpacePx = _rowHeightPx + _rowSpacingPx
		local rowsLen = rows.len()
		local visibleRowsLen = (getSizePx().height - marginPx.top - marginPx.bottom - rowSpacePx) / rowSpacePx

		_visibleRowsCount = visibleRowsLen <= rowsLen ? visibleRowsLen : rowsLen

		// Insert visibleRows loop:
		for (local i = oldVisibleRowsLen; i < visibleRowsLen; ++i)
			visibleRows.push(GUI.GridListVisibleRow(i, this))

		//  Remove visibleRows loop:
		for (local i = oldVisibleRowsLen - 1; i >= visibleRowsLen; --i)
			visibleRows.remove(i)
	}

	function updateColumns()
	{
		local marginPx = getMarginPx()
		local rowSpacePx = _rowHeightPx + _rowSpacingPx
		local positionPx = getPositionPx()
		local disabled = getDisabled()

		local startColPosYPx = positionPx.y + marginPx.top
		local startRowPosYPx = startColPosYPx + rowSpacePx

		local factor = 1
		local spacingWidthPx = 0
		local spacingCount = columns.len() - 1

		if (spacingCount > 0)
			spacingWidthPx = spacingCount * _columnSpacingPx

		local maxFreeWidthPx = getSizePx().width - marginPx.right - marginPx.left - spacingWidthPx
		if ((maxFreeWidthPx - _columnsWidthPx) < 0)
			factor = fabs(maxFreeWidthPx) / _columnsWidthPx

		_columnsWidthPx = 0

		local columnPosX = positionPx.x + marginPx.left
		foreach (column in columns)
		{
			local columnAlignment = column.getAlignment()
			local columnWidthPx = column.getWidthPx() * factor
			local rowPosYPx = startRowPosYPx

			_columnsWidthPx += columnWidthPx
			column.setPositionPx(columnPosX, startColPosYPx)
			column.setSizePx(columnWidthPx, _rowHeightPx)
			column._widthPx = columnWidthPx

			foreach (visibleRow in visibleRows)
			{
				local visibleCell
				if (column in visibleRow.cells)
					visibleCell = visibleRow.cells[column]
				else
				{
					visibleCell = GUI.GridListVisibleCell(visibleRow, column)
					visibleCell.setAlignment(columnAlignment)
					visibleCell.setDisabled(disabled)
					visibleRow.cells[column] <- visibleCell
				}
					
				visibleCell.setPositionPx(columnPosX, rowPosYPx)
				visibleCell.setSizePx(columnWidthPx, _rowHeightPx)

				rowPosYPx += rowSpacePx
			}

			columnPosX += (columnWidthPx + _columnSpacingPx)
		}
	}
}