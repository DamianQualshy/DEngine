local GUITableColumn = classes(GUI.Button, GUI.GridListColumn)
class GUI.TableColumn extends GUITableColumn
{
	constructor(id, parent, file, text, width)
	{
		GUI.Button.constructor.call(this, 0, 0, 0, 0, file, text)
		GUI.GridListColumn.constructor.call(this, id, parent, width)
	}

	function destroy()
	{
		GUI.GridListColumn.destroy.call(this)
		GUI.Button.destroy.call(this)
	}
}

class GUI.Table extends GUI.GridList
{
#public:
	constructor(x, y, w, h, txtFile, scrollFile, indicatorFile, decBtnFile, incBtnFile, parent = null)
	{
		base.constructor(x, y, w, h, txtFile, scrollFile, indicatorFile, decBtnFile, incBtnFile)

		if (parent)
			parent.insert(this)
	}

	function destroy()
	{
		for (local rowId = 0, end = rows.len(); rowId < end; ++rowId)
			rows[rowId].cells = null

		for (local colId = 0, columnsLen = columns.len(); colId < columnsLen; ++colId)
		{
			//	Remove visible rows:
			for (local rowId = 0, rowsLen = visibleRows.len(); rowId < rowsLen; ++rowId)
			{
				if (columns[colId] in visibleRows[rowId].cells)
					visibleRows[rowId].cells[columns[colId]] = visibleRows[rowId].cells[columns[colId]].destroy()		
			}

			columns[colId] = GUI.Button.destroy.call(columns[colId])
		}

		columns = null
		visibleRows = null
		rows = null

		scrollbar = scrollbar.destroy()
		GUI.Texture.destroy.call(this)
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
			
		local scrollVisible = getVisible() && visibleRows.len() < rows.len()
		if (scrollVisible != scrollbar.getVisible())
			scrollbar.setVisible(scrollVisible)
	}

	function insertColumn(colId, file, text, columnWidth = null)
	{
		local margin = getMarginPx()
		local freeWidth = getSizePx().width - margin.right - margin.left - _columnsWidthPx

		if (columnWidth != null)
			columnWidth = nax(columnWidth)

		if (columnWidth == null || columnWidth > freeWidth)
			columnWidth = freeWidth

		local column = GUI.TableColumn(colId, this, file, text, columnWidth)
		column.setSizePx(columnWidth, _rowHeightPx)
		column.setDisabled(getDisabled())

		if (getVisible())
			column.setVisible(true)
		
		columns.insert(colId, column)

		for (local i = colId + 1, end = columns.len(); i < end; ++i)
			++columns[i].id

		_columnsWidthPx += columnWidth

		updateColumns()
		return column
	}

	function addColumn(file, text, columnWidth = null)
	{
		return insertColumn(columns.len(), file, text, columnWidth)
	}

	function updateVisibleRows()
	{
		local oldVisibleRowsLen = visibleRows.len()
		local margin = getMarginPx()
		local rowSpace = _rowHeightPx + _rowSpacingPx
		local rowsLen = rows.len()
		local visibleRowsLen = (getSizePx().height - margin.top - margin.bottom - rowSpace) / rowSpace
	
		_visibleRowsCount = visibleRowsLen <= rowsLen ? visibleRowsLen : rowsLen

		// Insert visibleRows loop:
		for (local i = oldVisibleRowsLen; i < visibleRowsLen; ++i)
			visibleRows.push(GUI.GridListVisibleRow(i, this))

		//  Remove visibleRows loop:
		for (local i = oldVisibleRowsLen - 1; i >= visibleRowsLen; --i)
		{
			foreach (column in columns)
				visibleRows[i].cells[column] = visibleRows[i].cells[column].destroy()

			visibleRows.remove(i)
		}
	}

	function updateColumns()
	{
		local margin = getMarginPx()
		local rowSpace = _rowHeightPx + _rowSpacingPx
		local pos = getPositionPx()
		local disabled = getDisabled()

		local startColPosY = pos.y + margin.top
		local startRowPosY = startColPosY + rowSpace

		local factor = 1
		local spacingWidth = 0
		local spacingCount = columns.len() - 1

		if (spacingCount > 0)
			spacingWidth = spacingCount * _columnSpacingPx

		local maxFreeWidth = getSizePx().width - margin.right - margin.left - spacingWidth
		if ((maxFreeWidth - _columnsWidthPx) < 0)
			factor = fabs(maxFreeWidth) / _columnsWidthPx

		_columnsWidthPx = 0

		local columnPosX = pos.x + margin.left
		foreach (column in columns)
		{
			local columnWidth = column.getWidthPx() * factor
			local rowPosY = startRowPosY

			_columnsWidthPx += columnWidth
			column.setPositionPx(columnPosX, startColPosY)
			column.setSizePx(columnWidth, _rowHeightPx)
			column._widthPx = columnWidth

			foreach (visibleRow in visibleRows)
			{
				local visibleCell
				if (column in visibleRow.cells)
					visibleCell = visibleRow.cells[column]
				else
				{
					visibleCell = GUI.GridListVisibleCell(visibleRow, column, 0, 0, 0, 0, "", "")
					visibleCell.setAlignment(column.getRowsAlignment())
					visibleCell.setDisabled(disabled)
					visibleRow.cells[column] <- visibleCell
				}
					
				visibleCell.setPositionPx(columnPosX, rowPosY)
				visibleCell.setSizePx(columnWidth, _rowHeightPx)

				rowPosY += rowSpace
			}

			columnPosX += (columnWidth + _columnSpacingPx)
		}
	}
}