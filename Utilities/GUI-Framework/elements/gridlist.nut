local GridListCell = class
{
#public:
	parent = null
	column = null
	metadata = null

#private:
	_text = null
	_value = null
	_color = null
	_drawColor = null
	_alpha = 255
	_file = ""
	_font = "FONT_OLD_10_WHITE_HI.TGA"
	_isDisabled = false

	constructor(parent, column, arg)
	{
		this.parent = parent
		this.column = column
		metadata = "metadata" in arg ? arg.metadata : {}

		_value = "value" in arg ? arg.value : _value
		_text = "text" in arg ? arg.text : _value
		_color = "color" in arg ? arg.color : {r = 255, g = 255, b = 255}
		_drawColor = "drawColor" in arg ? arg.drawColor : {r = 255, g = 255, b = 255}
		_alpha = "alpha" in arg ? arg.alpha : _alpha
		_file = "file" in arg ? arg.file : _file
		_font = "font" in arg ? arg.font : _font
		_isDisabled = "disabled" in arg ? arg.disabled : _isDisabled
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

	function getDisabled()
	{
		return _isDisabled
	}

	function setDisabled(disabled)
	{
		_isDisabled = disabled

		local visibleCell = getVisibleCell()
		if (visibleCell)
			visibleCell.setDisabled(disabled)
	}
}

local GridListRow = class
{
#public:
	id = -1
	parent = null
	cells = null
	metadata = null

	constructor(id, parent)
	{
		this.id = id
		this.parent = parent
		cells = {}
		metadata = {}
	}

	function getVisibleRow()
	{
		local scrollValue = parent.scrollbar.range.getValue()
		if (id >= scrollValue && id < parent.visibleRows.len() + scrollValue)
			return parent.visibleRows[id - scrollValue]

		return null
	}

	function insertCell(column, arg)
	{
		local cell = GridListCell(this, column, arg)
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

	constructor(parent, column)
	{
		this.parent = parent
		this.column = column

		base.constructor({draw = {}})
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
		setDisabled(dataCell.getDisabled())

		local gridlist = parent.parent
		if (gridlist.getVisible() && !getVisible())
		{
			setVisible(true)

			if (gridlist.scrollbar.getVisible())
				gridlist.scrollbar.top()
		}
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

class GUI.GridListColumn extends GUI.Alignment
{
#public:
	id = -1
	parent = null

#private:
	_widthPx = 0

	constructor(id, parent, arg)
	{
		this.id = id
		this.parent = parent

		_alignment = "align" in arg ? arg.align : Align.Center

		if ("widthPx" in arg)
			_widthPx = arg.widthPx
		else if ("width" in arg)
			_widthPx = nax(arg.width)
		else
			_widthPx = 0
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

	function setAlignment(alignment)
	{
		base.setAlignment(alignment)

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
	_scrollbarVisibilityMode = ScrollbarVisibilityMode.Always
	_rowHeightPx = 0
	_rowSpacingPx = 0
	_columnSpacingPx = 0
	_visibleRowsCount = 0
	_columnsWidthPx = 0

	constructor(arg = null)
	{
		_scrollbarVisibilityMode = "scrollbarVisibilityMode" in arg ? arg.scrollbarVisibilityMode : _scrollbarVisibilityMode
		GUI.Margin.constructor.call(this, arg)

		columns = []
		visibleRows = []
		rows = []

		scrollbar = GUI.ScrollBar("scrollbar" in arg ? arg.scrollbar : null)
		scrollbar.parent = this
		scrollbar.range.setMaximum(0)
		scrollbar.range.bind(EventType.Change, function(self) {
			self.parent.parent.refreshList()
		})

		if (scrollbar.getSizePx().width == 0)
			scrollbar.setSizePx(SCROLLBAR_SIZE, 0)

		if ("rowHeightPx" in arg)
			_rowHeightPx = arg.rowHeightPx
		else if ("rowHeight" in arg)
			_rowHeightPx = nay(arg.rowHeight)
		else
		{
			local oldFont = textGetFont()
			textSetFont("FONT_OLD_10_WHITE_HI.TGA")
			_rowHeightPx = letterHeightPx()
			textSetFont(oldFont)
		}

		if ("rowSpacingPx" in arg)
			_rowSpacingPx = arg.rowSpacingPx
		else if ("rowSpacing" in arg)
			_rowSpacingPx = nay(arg.rowSpacing)

		if ("columnSpacingPx" in arg)
			_columnSpacingPx = arg.columnSpacingPx
		else if ("columnSpacing" in arg)
			_columnSpacingPx = nax(arg.columnSpacing)

		GUI.Texture.constructor.call(this, arg)
		updateVisibleElements()
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
		local positionPx = getPositionPx()
		GUI.Texture.setPositionPx.call(this, x, y)

		local offsetXPx = x - positionPx.x
		local offsetYPx = y - positionPx.y

		local scrollbarPositionPx = scrollbar.getPositionPx()
		scrollbar.setPositionPx(scrollbarPositionPx.x + offsetXPx, scrollbarPositionPx.y + offsetYPx)

		foreach (visibleRow in visibleRows)
		{
			foreach (visibleCell in visibleRow.cells)
			{
				local visibleCellPositionPx = visibleCell.getPositionPx()
				visibleCell.setPositionPx(visibleCellPositionPx.x + offsetXPx, visibleCellPositionPx.y + offsetYPx)
			}
		}
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

	function getScrollbarVisibilityMode()
	{
		return _scrollbarVisibilityMode
	}

	function setScrollbarVisibilityMode(visibilityMode)
	{
		_scrollbarVisibilityMode = visibilityMode
		updateScrollbarVisibility()
	}

	function updateScrollbarVisibility()
	{
		local visible = getVisible()
		switch (_scrollbarVisibilityMode)
		{
			case ScrollbarVisibilityMode.Always:
				scrollbar.setVisible(visible)
				break

			case ScrollbarVisibilityMode.Needed:
				scrollbar.setVisible(visible && visibleRows.len() < rows.len())
				break

			case ScrollbarVisibilityMode.Never:
				scrollbar.setVisible(false)
				break
		}
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

		updateScrollbarVisibility()
	}

	function insertColumn(colId, arg = null)
	{
		local marginPx = getMarginPx()
		local freeWidthPx = getSizePx().width - marginPx.right - marginPx.left - _columnsWidthPx
		local column = GUI.GridListColumn(colId, this, arg)

		if (column._widthPx <= 0 || column._widthPx > freeWidthPx)
			column._widthPx = freeWidthPx

		columns.insert(colId, column)
		for (local i = colId + 1, end = columns.len(); i < end; ++i)
			++columns[i].id

		_columnsWidthPx += column._widthPx

		updateColumns()
		return column
	}

	function addColumn(arg = null)
	{
		return insertColumn(columns.len(), arg)
	}

	function removeColumn(colId)
	{
		// Remove data cells:
		local column = columns[colId]

		for (local rowId = 0, end = rows.len(); rowId < end; ++rowId)
		{
			if (!(column in rows[rowId].cells))
				continue

			delete rows[rowId].cells[column]
		}

		// Remove visible cells:
		for (local rowId = 0, end = visibleRows.len(); rowId < end; ++rowId)
		{
			if (!(column in visibleRows[rowId].cells))
				continue

			delete visibleRows[rowId].cells[column]
		}

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

		foreach (colId, arg in vargv)
		{
			if (columnsLen <= colId)
				break

			local column = columns[colId]
			row.cells[column] <- GridListCell(row, column, arg)
		}

		local max = getMaxScrollbarValue()
		if (max > 0)
		{
			scrollbar.range.setMaximum(max)

			if (!scrollbar.getVisible() && visible && _scrollbarVisibilityMode == ScrollbarVisibilityMode.Needed)
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

		if (oldMax == 1 && scrollbar.getVisible() && _scrollbarVisibilityMode == ScrollbarVisibilityMode.Needed)
			scrollbar.setVisible(false)
	}

	function clear()
	{
		for (local rowId = 0, end = rows.len(); rowId < end; ++rowId)
			rows[rowId].cells = null

		rows.clear()

		local oldValue = scrollbar.range.getValue()
		scrollbar.range.setMaximum(0)

		if (scrollbar.getVisible() && _scrollbarVisibilityMode == ScrollbarVisibilityMode.Needed)
			scrollbar.setVisible(false)

		if (oldValue == 0)
			refreshList()

		_visibleRowsCount = 0
	}

	function sort(func)
	{
		rows.sort(func)
		foreach (i, row in rows)
			row.id = i

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
		local marginPx = getMarginPx()
		local rowsLen = rows.len()
		local visibleRowsLen = (getSizePx().height - marginPx.top - marginPx.bottom) / (_rowHeightPx + _rowSpacingPx)

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
		local positionPx = getPositionPx()
		local factor = 1
		local spacingWidthPx = 0
		local spacingCount = columns.len() - 1

		if (spacingCount > 0)
			spacingWidthPx = spacingCount * _columnSpacingPx

		local maxFreeWidthPx = getSizePx().width - marginPx.right - marginPx.left - spacingWidthPx
		if ((maxFreeWidthPx - _columnsWidthPx) < 0)
			factor = fabs(maxFreeWidthPx) / _columnsWidthPx

		_columnsWidthPx = 0

		local rowPositionXPx = positionPx.x + marginPx.left
		local rowFullSizePx = _rowHeightPx + _rowSpacingPx
		local disabled = getDisabled()
		foreach (column in columns)
		{
			local columnAlignment = column.getAlignment()
			local columnWidthPx = column.getWidthPx() * factor
			local rowPositionYPx = positionPx.y + marginPx.top

			column._widthPx = columnWidthPx
			_columnsWidthPx += columnWidthPx

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

				visibleCell.setPositionPx(rowPositionXPx, rowPositionYPx)
				visibleCell.setSizePx(columnWidthPx, _rowHeightPx)
				rowPositionYPx += rowFullSizePx
			}

			rowPositionXPx += (columnWidthPx + _columnSpacingPx)
		}
	}

	function updateVisibleElements()
	{
		updateVisibleRows()
		updateColumns()

		local positionPx = getPositionPx()
		local sizePx = getSizePx()
		local scrollbarWidthPx = scrollbar.getSizePx().width
		scrollbar.setPositionPx((positionPx.x + sizePx.width - scrollbarWidthPx), positionPx.y)
		scrollbar.setSizePx(scrollbarWidthPx, sizePx.height)

		local newMax = getMaxScrollbarValue()
		if (newMax != scrollbar.range.getMaximum())
		{
			scrollbar.range.setMaximum(newMax)

			local scrollVisible = getVisible() && newMax != 0 && _scrollbarVisibilityMode == ScrollbarVisibilityMode.Needed
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
}