local DataRow = class
{
#public:
	id = -1
	parent = null

#private:
	_text = null
	_value = null
	_color = null
	_drawColor = null
	_alpha = 255
	_file = ""

	constructor(id, parent, value)
	{
		this.id = id
		this.parent = parent

		_text = value
		_value = value
		_color = {r = 255, g = 255, b = 255}
		_drawColor = {r = 255, g = 255, b = 255}
	}

	function getVisibleRow()
	{
		local scrollValue = parent.scrollbar.range.getValue()
		if (id >= scrollValue && id < parent.visibleRows.len() + scrollValue)
			return parent.visibleRows[id - scrollValue]
		
		return null
	}

	function getText()
	{
		return _text
	}

	function setText(text)
	{
		_text = text

		local visibleRow = getVisibleRow()
		if (visibleRow)
			visibleRow.setText(text)
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

		local visibleRow = getVisibleRow()
		if (visibleRow)
			visibleRow.setColor(r, g, b)
	}

	function getDrawColor()
	{
		return _drawColor
	}

	function setDrawColor(r, g, b)
	{
		_drawColor = {r = r, g = g, b = b}

		local visibleRow = getVisibleRow()
		if (visibleRow)
			visibleRow.draw.setColor(r, g, b)
	}

	function getAlpha()
	{
		return _alpha
	}

	function setAlpha(alpha)
	{
		_alpha = alpha

		local visibleRow = getVisibleRow()
		if (visibleRow)
			visibleRow.setAlpha(alpha)
	}

	function getFile()
	{
		return _file
	}

	function setFile(file)
	{
		_file = file

		local visibleRow = getVisibleRow()
		if (visibleRow)
			visibleRow.setFile(file)
	}
}

class GUI.ListVisibleRow extends GUI.Button
{
#public:
	id = -1

	constructor(newId, newParent, x, y, width, height, file, text)
	{
		base.constructor(x, y, width, height, file, text)
		id = newId
		parent = newParent
	}

	function getDataRow()
	{
		if (id >= parent.rows.len())
			return null

		return parent.rows[id + parent.scrollbar.range.getValue()]
	}
}

local GUIListClasses = classes(GUI.Texture, GUI.Margin, GUI.Alignment)
class GUI.List extends GUIListClasses
{
#public:
	rows = null
	visibleRows = null
	scrollbar = null

#private:
	_rowHeightPx = 0
	_rowSpacingPx = 0
	_font = "FONT_OLD_10_WHITE_HI.TGA"

	_visibleRowsCount = 0

	constructor(x, y, w, h, txtFile, scrollFile, indicatorFile, decBtnFile, incBtnFile, parent = null)
	{
		GUI.Margin.constructor.call(this)
		_alignment = Align.Center

		rows = []
		visibleRows = []

		GUI.Texture.constructor.call(this, x, y, w, h, txtFile)
		scrollbar = GUI.ScrollBar(0, 0, anx(SCROLLBAR_BUTTON_SIZE), 0, scrollFile, indicatorFile, decBtnFile, incBtnFile, Orientation.Vertical)
		scrollbar.parent = this
		scrollbar.range.setMaximum(0)

		scrollbar.range.bind(EventType.Change, onChange)

		local oldFont = textGetFont()
        textSetFont(_font)
		_rowHeightPx = letterHeightPx()
		textSetFont(oldFont)

		updateVisibleElements()

		if (parent)
			parent.insert(this)
	}

	function destroy()
	{
		for (local i = 0, end = visibleRows.len(); i < end; ++i)
			visibleRows[i] = visibleRows[i].destroy()

		rows = null
		visibleRows = null

		scrollbar = scrollbar.destroy()
		GUI.Texture.destroy.call(this)
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

	function setAlignment(alignment)
	{
		GUI.Alignment.setAlignment.call(this, alignment)

		foreach (visibleRow in visibleRows)
			visibleRow.setAlignment(alignment)
	}

	function setFont(font)
	{
		_font = font

		foreach (visibleRow in visibleRows)
			visibleRow.setFont(font)
	}

	function getFont()
	{
		return _font
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

	function setVisible(toggle)
	{
		GUI.Texture.setVisible.call(this, toggle)

		foreach (visibleRow in visibleRows)
			visibleRow.setVisible(toggle && visibleRow.getDataRow())

		local scrollVisible = getVisible() && visibleRows.len() < rows.len()
		if (scrollVisible != scrollbar.getVisible())
			scrollbar.setVisible(scrollVisible)
	}

	function insertRow(rowId, value)
	{
        local visible = getVisible()
		if (_visibleRowsCount < visibleRows.len())
		{
			if (visible)
				visibleRows[_visibleRowsCount].setVisible(true)
			
			++_visibleRowsCount
		}

		local row = DataRow(rowId, this, value)
		rows.insert(rowId, row)

		local max = getMaxScrollbarValue()
		if (max != 0)
		{
			scrollbar.range.setMaximum(max)

			if (!scrollbar.getVisible() && visible)
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

	function addRow(value)
	{
		return insertRow(rows.len(), value)
	}

	function removeRow(rowId)
	{
		if (rows.len() <= visibleRows.len())
		{
			--_visibleRowsCount
			visibleRows[_visibleRowsCount].setVisible(false)
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

		if (oldMax == 1 && scrollbar.getVisible())
			scrollbar.setVisible(false)
	}

	function clear()
	{
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

	function updateVisibleElements()
	{
		local oldVisibleRowsLen = visibleRows.len()
		local size = getSizePx()
		local margin = getMarginPx()
		local rowSpace = _rowHeightPx + _rowSpacingPx
		local rowsLen = rows.len()

		local visibleRowsLen = (size.height - margin.top - margin.bottom) / rowSpace
		_visibleRowsCount = visibleRowsLen <= rowsLen ? visibleRowsLen : rowsLen

		// Insert visibleRows loop:
		local visible = getVisible()
		for (local i = oldVisibleRowsLen; i < visibleRowsLen; ++i)
		{
			local visibleRow = GUI.ListVisibleRow(i, this, 0, 0, 0, 0, "", "")
			visibleRow.setFont(_font)
			visibleRow.setAlignment(_alignment)
			visibleRow.setVisible(visible)

			visibleRows.push(visibleRow)
		}

		//  Remove visibleRows loop:
		for (local i = oldVisibleRowsLen - 1; i >= visibleRowsLen; --i)
		{
			visibleRows[i] = visibleRows[i].destroy()
			visibleRows.remove(i)
		}

		//  Update visible rows:
		local pos = getPositionPx()
		local newPosX = pos.x + margin.left
		local newPosY = pos.y + margin.top
		local width = size.width - margin.left - margin.right
		foreach (visibleRow in visibleRows)
		{
			visibleRow.setPositionPx(newPosX, newPosY)
			visibleRow.setSizePx(width, _rowHeightPx)
			newPosY += rowSpace
		}

		//  Update scrollbar and data:
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
		local scrollbarValue = scrollbar.range.getValue()
		local maxRowsId = rows.len() - 1

		for (local i = begin; i < _visibleRowsCount; ++i)
		{
			if (maxRowsId < i)
			{
				visibleRows[i].setVisible(false)
				continue
			}

			local row = rows[i + scrollbarValue]
			local color = row.getColor()
			local drawColor = row.getDrawColor()

			visibleRows[i].setText(row.getText())
			visibleRows[i].setColor(color.r, color.g, color.b)
			visibleRows[i].draw.setColor(drawColor.r, drawColor.g, drawColor.b)
			visibleRows[i].setAlpha(row.getAlpha())
			visibleRows[i].setFile(row.getFile())
		}
	}

	static function onChange(self)
	{	  
		local scrollbar = self.parent
		local list = scrollbar.parent

		list.refreshList()
	}
}