local GridListCell = class
{
#public:
	parent = null
	column = null

#private:
	_text = null
	_value = null
	_color = null
	_drawColor = null
	_alpha = 255
	_file = ""
	_font = "FONT_OLD_10_WHITE_HI.TGA"

	constructor(parent, column, value)
	{
		this.parent = parent
		this.column = column

		_text = value
		_value = value
		_color = {r = 255, g = 255, b = 255}
		_drawColor = {r = 255, g = 255, b = 255}
	}

	function getVisibleCell()
	{
		local visibleRow = parent.getVisibleRow()
		if (!visibleRow)
			return null

		if (!(column in visibleRow.cells))
			return null

		return visibleRow.cells[column]
	}

	function getText()
	{
		return _text
	}

	function setText(text)
	{
		_text = text

		local visibleCell = getVisibleCell()
		if (visibleCell)
			visibleCell.setText(text)
	}

	function getValue()
	{
		return _value
	}

	function setValue(value, updateText = true)
	{
		_value = value

		if (updateText)
			setText(value)
	}

	function getColor()
	{
		return _color
	}

	function setColor(r, g, b)
	{
		_color = {r = r, g = g, b = b}

		local visibleCell = getVisibleCell()
		if (visibleCell)
			visibleCell.setColor(r, g, b)
	}

	function getDrawColor()
	{
		return _drawColor
	}

	function setDrawColor(r, g, b)
	{
		_drawColor = {r = r, g = g, b = b}

		local visibleCell = getVisibleCell()
		if (visibleCell)
			visibleCell.draw.setColor(r, g, b)
	}

	function getAlpha()
	{
		return _alpha
	}

	function setAlpha(alpha)
	{
		_alpha = alpha

		local visibleCell = getVisibleCell()
		if (visibleCell)
			visibleCell.setAlpha(alpha)
	}

	function getFile()
	{
		return _file
	}

	function setFile(file)
	{
		_file = file

		local visibleCell = getVisibleCell()
		if (visibleCell)
			visibleCell.setFile(file)
	}

	function getFont()
	{
		return _font
	}

	function setFont(font)
	{
		_font = font

		local visibleCell = getVisibleCell()
		if (visibleCell)
			visibleCell.setFont(font)
	}
}

local GridListRow = class
{
#public:
	id = -1
	parent = null
	cells = null

	constructor(id, parent)
	{
		this.id = id
		this.parent = parent
		cells = {}
	}

	function getVisibleRow()
	{
		local scrollValue = parent.scrollbar.range.getValue()
		if (id >= scrollValue && id < parent.visibleRows.len() + scrollValue)
			return parent.visibleRows[id - scrollValue]
		
		return null
	}

	function insertCell(column, value)
	{
		local cell = GridListCell(this, column, value)
		local visibleCell = cell.getVisibleCell()

		if (visibleCell)
			visibleCell.update(cell)
			
		cells[column] <- cell
		return cell
	}

	function removeCell(column)
	{
		local visibleCell = cells[column].getVisibleCell()
		if (visibleCell)
		{
			if (visibleCell.getVisible())
				visibleCell.setVisible(false)
		}

		delete cells[column]
		if (!cells.len())
			parent.removeRow(id)
	}
}

class GUI.GridListVisibleCell extends GUI.Button
{
#public:
	column = null

	constructor(parent, column, x, y, width, height, file, text)
	{
		base.constructor(x, y, width, height, file, text)
		this.parent = parent
		this.column = column
	}

	function getDataCell()
	{
		local dataRow = parent.getDataRow()
		if (!dataRow)
			return null

		local cells = dataRow.cells
		if (!(column in cells))
			return null

		return cells[column]
	}

	function update(dataCell)
	{
		local color = dataCell.getColor()
		local drawColor = dataCell.getDrawColor()

		setText(dataCell.getText())
		setColor(color.r, color.g, color.b)
		draw.setColor(drawColor.r, drawColor.g, drawColor.b)
		setAlpha(dataCell.getAlpha())
		setFile(dataCell.getFile())
		setFont(dataCell.getFont())

		if (parent.parent.getVisible() && !getVisible())
			setVisible(true)
	}
}

class GUI.GridListVisibleRow
{
#public:
	id = -1
	parent = null
	cells = null

	constructor(id, parent)
	{
		this.id = id
		this.parent = parent
		cells = {}
	}

	function getDataRow()
	{
		if (id >= parent.rows.len())
			return null

		return parent.rows[id + parent.scrollbar.range.getValue()]
	}
}

class GUI.GridListColumn
{
#public:
	id = -1
	parent = null

#private:
	_rowsAlignment = Align.Center
	_widthPx = 0

	constructor(id, parent, width)
	{
		this.id = id
		this.parent = parent
		_widthPx = width
	}

	function destroy()
	{
		//	Remove data cells:
		local rows = parent.rows
		for (local rowId = 0, end = rows.len(); rowId < end; ++rowId)
		{
			if (!(this in rows[rowId].cells))
				continue

			delete rows[rowId].cells[this]
		}

		//	Remove visible cells:
		local visibleRows = parent.visibleRows
		for (local rowId = 0, end = parent.visibleRows.len(); rowId < end; ++rowId)
		{
			if (!(this in parent.visibleRows[rowId].cells))
				continue

			parent.visibleRows[rowId].cells[this] = parent.visibleRows[rowId].cells[this].destroy()
			delete parent.visibleRows[rowId].cells[this]
		}
	}
	
	function getWidthPx()
	{
		return _widthPx
	}

	function setWidthPx(width)
	{
		_widthPx = width
		parent.updateColumns()
	}

	function getWidth()
	{
		return anx(_widthPx)
	}

	function setWidth(width)
	{
		setWidthPx(nax(width))
	}

	function getRowsAlignment()
	{
		return _rowsAlignment
	}

	function setRowsAlignment(alignment)
	{
		_rowsAlignment = alignment

		foreach (row in parent.visibleRows)
		{
			if (this in row.cells)
				row.cells[this].setAlignment(alignment)
		}
	}
}

local GUIGridListClasses = classes(GUI.Texture, GUI.Margin)
class GUI.GridList extends GUIGridListClasses
{
#public:
	columns = null
	visibleRows = null
	rows = null
	scrollbar = null

#private:
	_rowHeightPx = 0
	_rowSpacingPx = 0
	_columnSpacingPx = 0
	_visibleRowsCount = 0
	_columnsWidthPx = 0

	constructor(x, y, w, h, txtFile, scrollFile, indicatorFile, decBtnFile, incBtnFile, parent = null)
	{
		GUI.Margin.constructor.call(this)

		columns = []
		visibleRows = []
		rows = []

		GUI.Texture.constructor.call(this, x, y, w, h, txtFile)
		scrollbar = GUI.ScrollBar(0, 0, anx(SCROLLBAR_BUTTON_SIZE), 0, scrollFile, indicatorFile, decBtnFile, incBtnFile, Orientation.Vertical)
		scrollbar.parent = this
		scrollbar.range.setMaximum(0)

		scrollbar.range.bind(EventType.Change, onChange)

		local oldFont = textGetFont()
        textSetFont("FONT_OLD_10_WHITE_HI.TGA")
		_rowHeightPx = letterHeightPx()
		textSetFont(oldFont)

		updateVisibleElements()

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
			foreach (visibleRow in visibleRows)
			{
				if (column in visibleRow.cells)
					visibleRow.cells[column].top()
			}
		}
	}

	function setPositionPx(x, y)
	{
		GUI.Texture.setPositionPx.call(this, x, y)
		updateVisibleElements()
	}

	function setSizePx(width, height)
	{
		GUI.Texture.setSizePx.call(this, width, height)
		updateVisibleElements()
	}

	function setMarginPx(top, right, bottom, left)
	{
		GUI.Margin.setMarginPx.call(this, top, right, bottom, left)
		updateVisibleElements()
	}

	function getRowHeightPx()
	{
		return _rowHeightPx
	}

	function setRowHeightPx(rowHeight)
	{
		_rowHeightPx = rowHeight
		updateVisibleElements()
	}

	function getRowHeight()
	{
		return any(_rowHeightPx)
	}

	function setRowHeight(rowHeight)
	{
		setRowHeightPx(nay(rowHeight))
	}

	function getRowSpacingPx()
	{
		return _rowSpacingPx
	}

	function setRowSpacingPx(rowSpacing)
	{
		_rowSpacingPx = rowSpacing
		updateVisibleElements()
	}

	function getRowSpacing()
	{
		return any(_rowSpacingPx)
	}

	function setRowSpacing(rowSpacing)
	{
		setRowSpacingPx(nay(rowSpacing))
	}

	function getColumnSpacingPx()
	{
		return _columnSpacingPx
	}

	function setColumnSpacingPx(columnSpacing)
	{
		_columnSpacingPx = columnSpacing
		updateColumns()
	}

	function getColumnSpacing()
	{
		return any(_columnSpacingPx)
	}

	function setColumnSpacing(ColumnSpacing)
	{
		setColumnSpacingPx(nay(ColumnSpacing))
	}

	function setVisible(toggle)
	{
		GUI.Texture.setVisible.call(this, toggle)

		foreach (column in columns)
		{
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

	function insertColumn(colId, columnWidth = null)
	{
		local margin = getMarginPx()
		local freeWidth = getSizePx().width - margin.right - margin.left - _columnsWidthPx

		if (columnWidth != null)
			columnWidth = nax(columnWidth)

		if (columnWidth == null || columnWidth > freeWidth)
			columnWidth = freeWidth

		local column = GUI.GridListColumn(colId, this, columnWidth)		
		columns.insert(colId, column)

		for (local i = colId + 1, end = columns.len(); i < end; ++i)
			++columns[i].id

		_columnsWidthPx += columnWidth

		updateColumns()
		return column
	}

	function addColumn(columnWidth = null)
	{
		return insertColumn(columns.len(), columnWidth)
	}

	function removeColumn(colId)
	{
		columns[colId].destroy()

		for (local i = columns.len() - 1; i > colId; --i)
			--columns[i].id

		columns.remove(colId)
		updateColumns()
	}

	function insertRow(rowId, ...)
	{
		if (_visibleRowsCount < visibleRows.len())
			++_visibleRowsCount

		local row = GridListRow(rowId, this)
		local columnsLen = columns.len()

		rows.insert(rowId, row)

		foreach (colId, value in vargv)
		{
			if (columnsLen <= colId)
				break
				
			local column = columns[colId]
			row.cells[column] <- GridListCell(row, column, value)
		}

		local max = getMaxScrollbarValue()
		if (max > 0)
		{
			scrollbar.range.setMaximum(max)

			if (!scrollbar.getVisible() && getVisible())
				scrollbar.setVisible(true) 
		}
		
		if (rowId >= scrollbar.range.getValue() + visibleRows.len())
			return row

		local visibleRow = row.getVisibleRow()
		local begin = visibleRow ? visibleRow.id : 0
		
		for (local i = rowId + 1, end = rows.len(); i < end; ++i)
			++rows[i].id

		refreshList(begin)
		return row
	}

	function addRow(...)
	{
		vargv.insert(0, this)
		vargv.insert(1, rows.len())

		return insertRow.acall(vargv)
	}

	function removeRow(rowId)
	{
		if (rows.len() <= visibleRows.len())
		{
			--_visibleRowsCount

			foreach (column in columns)
			{
				local visibleCell = visibleRows[_visibleRowsCount].cells[column]
				if (visibleCell.getVisible())
					visibleCell.setVisible(false)
			}
		}

		for (local i = rows.len() - 1; i > rowId; --i)
			--rows[i].id

		rows.remove(rowId)
	
		local oldMax = scrollbar.range.getMaximum()
		if (oldMax > 0)
		{
			scrollbar.range.setMaximum(getMaxScrollbarValue())

			if (scrollbar.range.getValue() != oldMax)
				refreshList()
		}
		else
			refreshList()

		if (oldMax == 1)
			scrollbar.setVisible(false)
	}

	function clear()
	{
		for (local rowId = 0, end = rows.len(); rowId < end; ++rowId)
			rows[rowId].cells = null

		rows.clear()

		local oldValue = scrollbar.range.getValue()
		scrollbar.range.setMaximum(0)

		if (scrollbar.getVisible())
			scrollbar.setVisible(false)

		if (oldValue == 0)
			refreshList()

		_visibleRowsCount = 0
	}

	function sort(func)
	{
		rows.sort(func)
		refreshList()
	}

	function getMaxScrollbarValue()
	{
		local difference = rows.len() - visibleRows.len()
			return difference > 0 ? difference : 0
	}

	function updateVisibleRows()
	{
		local oldVisibleRowsLen = visibleRows.len()
		local margin = getMarginPx()
		local rowsLen = rows.len()
		local visibleRowsLen = (getSizePx().height - margin.top - margin.bottom) / (_rowHeightPx + _rowSpacingPx)
	
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
		local pos = getPositionPx()
		local factor = 1
		local spacingWidth = 0
		local spacingCount = columns.len() - 1

		if (spacingCount > 0)
			spacingWidth = spacingCount * _columnSpacingPx

		local maxFreeWidth = getSizePx().width - margin.right - margin.left - spacingWidth
		if ((maxFreeWidth - _columnsWidthPx) < 0)
			factor = fabs(maxFreeWidth) / _columnsWidthPx

		_columnsWidthPx = 0

		local rowPosX = pos.x + margin.left
		local rowSpace = _rowHeightPx + _rowSpacingPx
		local disabled = getDisabled()
		foreach (column in columns)
		{
			local columnWidth = column.getWidthPx() * factor
			local rowPosY = pos.y + margin.top

			column._widthPx = columnWidth
			_columnsWidthPx += columnWidth

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
					
				visibleCell.setPositionPx(rowPosX, rowPosY)
				visibleCell.setSizePx(columnWidth, _rowHeightPx)
				rowPosY += rowSpace
			}

			rowPosX += (columnWidth + _columnSpacingPx)
		}
	}

	function updateVisibleElements()
	{
		updateVisibleRows()
		updateColumns()

		local pos = getPositionPx()
		local size = getSizePx()
		local scrollbarWidth = scrollbar.getSizePx().width
		scrollbar.setPositionPx((pos.x + size.width - scrollbarWidth), pos.y)
		scrollbar.setSizePx(scrollbarWidth, size.height)

		local newMax = getMaxScrollbarValue()
		if (newMax != scrollbar.range.getMaximum())
		{
			scrollbar.range.setMaximum(newMax)

			local scrollVisible = getVisible() && newMax != 0
			if (scrollVisible != scrollbar.getVisible())
				scrollbar.setVisible(scrollVisible)
		}
		else
			refreshList()
	}

	function refreshList(begin = 0)
	{
		local scrollValue = scrollbar.range.getValue()
		local maxRowsId = rows.len() - 1

		for (local i = begin; i < _visibleRowsCount; ++i)
		{
			local visibleRow = visibleRows[i]
			if (maxRowsId < i)
			{
				local visibleCells = visibleRow.cells
				foreach (visibleCell in visibleCells)
					visibleCell.setVisible(false)

				continue
			}

			local cells = rows[i + scrollValue].cells
			foreach (column in columns)
			{
				local visibleCell = visibleRow.cells[column]
				if (!(column in cells))
				{
					visibleCell.setVisible(false)
					continue
				}

				visibleCell.update(cells[column])
			}
		}
	}

	static function onChange(self)
	{	  
		local scrollbar = self.parent
		local gridlist = scrollbar.parent

		gridlist.refreshList()
	}
}