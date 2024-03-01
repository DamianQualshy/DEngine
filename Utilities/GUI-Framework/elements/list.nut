local DataRow = class
{
#public:
	id = -1
	parent = null
	metadata = null

#private:
	_text = null
	_value = null
	_color = null
	_drawColor = null
	_file = ""
	_font = "FONT_OLD_10_WHITE_HI.TGA"
	_isDisabled = false

	constructor(id, parent, arg)
	{
		this.id = id
		this.parent = parent
		metadata = "metadata" in arg ? arg.metadata : {}

		_value = "value" in arg ? arg.value : _value
		_text = "text" in arg ? arg.text : _value
		_color = Color(255, 255, 255, 255)
		_drawColor = Color(255, 255, 255, 255)
		_file = "file" in arg ? arg.file : _file
		_font = "font" in arg ? arg.font : _font
		_isDisabled = "disabled" in arg ? arg.disabled : _isDisabled

		setColor("color" in arg ? arg.color : _color)
		setDrawColor("drawColor" in arg ? arg.drawColor : _drawColor)
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
		return clone _color
	}

	function setColor(color)
	{
		local isColorInstance = typeof color == "Color"

		if (isColorInstance || "r" in color)
			_color.r = color.r

		if (isColorInstance || "g" in color)
			_color.g = color.g

		if (isColorInstance || "b" in color)
			_color.b = color.b

		if (isColorInstance || "a" in color)
			_color.a = color.a

		local visibleRow = getVisibleRow()
		if (visibleRow)
			visibleRow.setColor(color)
	}

	function getDrawColor()
	{
		return clone _drawColor
	}

	function setDrawColor(color)
	{
		local isColorInstance = typeof color == "Color"

		if (isColorInstance || "r" in color)
			_drawColor.r = color.r

		if (isColorInstance || "g" in color)
			_drawColor.g = color.g

		if (isColorInstance || "b" in color)
			_drawColor.b = color.b

		if (isColorInstance || "a" in color)
			_drawColor.a = color.a

		local visibleRow = getVisibleRow()
		if (visibleRow)
			visibleRow.draw.setColor(color)
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

	function getFont()
	{
		return _font
	}

	function setFont(font)
	{
		_font = font

		local visibleRow = getVisibleRow()
		if (visibleRow)
			visibleRow.setFont(font)
	}

	function getDisabled()
	{
		return _isDisabled
	}

	function setDisabled(disabled)
	{
		_isDisabled = disabled

		local visibleRow = getVisibleRow()
		if (visibleRow)
			visibleRow.setDisabled(disabled)
	}
}

class GUI.ListVisibleRow extends GUI.Button
{
#public:
	id = -1

	constructor(id, parent)
	{
		base.constructor({draw = {}})
		this.id = id
		this.parent = parent
	}

	function getDataRowId()
	{
		return id + parent.scrollbar.range.getValue()
	}

	function getDataRow()
	{
		if (id >= parent.rows.len())
			return null

		return parent.rows[getDataRowId()]
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
	_scrollbarVisibilityMode = ScrollbarVisibilityMode.Needed
	_rowHeightPx = 0
	_rowSpacingPx = 0

	_visibleRowsCount = 0

	constructor(arg = null)
	{
		_scrollbarVisibilityMode = "scrollbarVisibilityMode" in arg ? arg.scrollbarVisibilityMode : _scrollbarVisibilityMode
		GUI.Margin.constructor.call(this, arg)
		_alignment = "align" in arg ? arg.align : Align.Center

		rows = []
		visibleRows = []

		scrollbar = GUI.ScrollBar("scrollbar" in arg ? arg.scrollbar : null)
		scrollbar.parent = this
		scrollbar.range.setMaximum(0)
		scrollbar.range.bind(EventType.Change, function(self) {
			self.parent.parent.refresh()
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

		GUI.Texture.constructor.call(this, arg)
		updateVisibleElements()
	}

	function setPositionPx(x, y)
	{
		local positionPx = getPositionPx()
		GUI.Texture.setPositionPx.call(this, x, y)

		local offsetXPx = x - positionPx.x
		local offsetYPx = y - positionPx.y

		foreach (visibleRow in visibleRows)
		{
			local visibleRowPositionPx = visibleRow.getPositionPx()
			visibleRow.setPositionPx(visibleRowPositionPx.x + offsetXPx, visibleRowPositionPx.y + offsetYPx)
		}

		local scrollbarPositionPx = scrollbar.getPositionPx()
		scrollbar.setPositionPx(scrollbarPositionPx.x + offsetXPx, scrollbarPositionPx.y + offsetYPx)
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
		foreach (visibleRow in visibleRows)
			visibleRow.setVisible(toggle && visibleRow.getDataRow())

		updateScrollbarVisibility()
	}

	function setDisabled(disabled)
	{
		GUI.Texture.setDisabled.call(this, disabled)
		foreach (visibleRow in visibleRows)
			visibleRow.setDisabled(disabled)

		scrollbar.setDisabled(disabled)
	}

	function insertRow(rowId, arg)
	{
		local visible = getVisible()
		if (_visibleRowsCount < visibleRows.len())
		{
			if (visible)
				visibleRows[_visibleRowsCount].setVisible(true)
			
			++_visibleRowsCount
		}

		local row = DataRow(rowId, this, arg)
		rows.insert(rowId, row)

		local max = getMaxScrollbarValue()
		if (max != 0)
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

		refresh(begin)
		return row
	}

	function addRow(arg)
	{
		return insertRow(rows.len(), arg)
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
				refresh()
		}
		else
			refresh()

		if (oldMax == 1 && scrollbar.getVisible() && _scrollbarVisibilityMode == ScrollbarVisibilityMode.Needed)
			scrollbar.setVisible(false)
	}

	function clear()
	{
		rows.clear()

		local oldValue = scrollbar.range.getValue()
		scrollbar.range.setMaximum(0)

		if (scrollbar.getVisible() && _scrollbarVisibilityMode == ScrollbarVisibilityMode.Needed)
			scrollbar.setVisible(false)

		if (oldValue == 0)
			refresh()

		_visibleRowsCount = 0
	}

	function sort(func)
	{
		rows.sort(func)
		foreach (i, row in rows)
			row.id = i

		refresh()
	}

	function getMaxScrollbarValue()
	{
		local difference = rows.len() - visibleRows.len()
			return difference > 0 ? difference : 0
	}

	function updateVisibleElements()
	{
		local oldVisibleRowsLen = visibleRows.len()
		local sizePx = getSizePx()
		local marginPx = getMarginPx()
		local rowSpacePx = _rowHeightPx + _rowSpacingPx
		local rowsLen = rows.len()

		local visibleRowsLen = (_rowHeightPx > 0) ? ((sizePx.height - marginPx.top - marginPx.bottom + _rowSpacingPx) / rowSpacePx) : 0
		_visibleRowsCount = visibleRowsLen <= rowsLen ? visibleRowsLen : rowsLen

		// Insert visibleRows loop:
		local visible = getVisible()
		for (local i = oldVisibleRowsLen; i < visibleRowsLen; ++i)
		{
			local visibleRow = _createVisibleRow(i)
			visibleRow.setAlignment(_alignment)
			visibleRow.setVisible(visible)

			visibleRows.push(visibleRow)
		}

		//  Remove visibleRows loop:
		for (local i = oldVisibleRowsLen - 1; i >= visibleRowsLen; --i)
			visibleRows.remove(i)

		//  Update visible rows:
		local positionPx = getPositionPx()
		local newPositionXPx = positionPx.x + marginPx.left
		local newPositionYPx = positionPx.y + marginPx.top
		local width = sizePx.width - marginPx.left - marginPx.right
		foreach (visibleRow in visibleRows)
		{
			visibleRow.setPositionPx(newPositionXPx, newPositionYPx)
			visibleRow.setSizePx(width, _rowHeightPx)
			newPositionYPx += rowSpacePx
		}

		//  Update scrollbar and data:
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
		
		refresh()
	}

	function refresh(begin = 0)
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

			local text = row.getText()
			if (visibleRows[i].getText() != text)
				visibleRows[i].setText(text != null ? text : "")

			visibleRows[i].setColor(row.getColor())
			visibleRows[i].draw.setColor(row.getDrawColor())
			visibleRows[i].setFile(row.getFile())
			visibleRows[i].setFont(row.getFont())
			visibleRows[i].setDisabled(row.getDisabled())
		}
	}

	function _createVisibleRow(id) {
		return GUI.ListVisibleRow(id, this)
	}
}