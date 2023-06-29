class GUI.DropDownList extends GUI.Button
{
#public:
	list = null
	closeOnRowClick = false

#private:
	_maxHeightPx = 0

	constructor(colX, colY, colWidth, colHeight, colFile, colText, listMaxHeight, listTxtBg, scrollbarFile, indicatorFile, decBtnFile, incBtnFile, parent = null)
	{
		base.constructor(colX, colY, colWidth, colHeight, colFile, colText, parent)
		_maxHeightPx = nay(listMaxHeight)

		list = GUI.List(0, 0, 0, 0, listTxtBg, scrollbarFile, indicatorFile, decBtnFile, incBtnFile)
		list.setRowHeight(colHeight)
		list.parent = this

		this.bind(EventType.Click, onClick)
		updateVisibleElements()
	}

	function destroy()
	{
		list = list.destroy()
		base.destroy()
	}

	function setPositionPx(x, y)
	{
		base.setPositionPx(x, y)
		updateVisibleElements()
	}

	function setSizePx(width, height)
	{
		base.setSizePx(x, y)
		updateVisibleElements()
	}

	function setMarginPx(top, right, bottom, left)
	{
		list._marginPx =
		{
			top = top,
			right = right
			bottom = bottom,
			left = left,
		}

		updateVisibleElements()
	}

	function setRowHeightPx(rowHeight)
	{
		list._rowHeightPx = rowHeight
		updateVisibleElements()
	}

	function setRowHeight(rowHeight)
	{
		setRowHeightPx(nay(rowHeight))
	}

	function setRowSpacingPx(rowSpacing)
	{
		list._rowSpacingPx = rowSpacing
		updateVisibleElements()
	}

	function setRowSpacing(rowSpacing)
	{
		setRowSpacingPx(nay(rowSpacing))
	}

	function getMaxHeightPx()
	{
		return _maxHeightPx
	}

	function setMaxHeightPx(maxHeight)
	{
		_maxHeightPx = maxHeight
		updateVisibleElements()
	}

	function getMaxHeight()
	{
		return any(_maxHeightPx)
	}

	function setMaxHeight(maxHeight)
	{
		setMaxHeightPx(nay(maxHeight))
	}

	function setVisible(toggle)
	{
		if (!toggle && list.getVisible())
			list.setVisible(false)

		base.setVisible(toggle)
	}

	function insertRow(rowId, value)
	{
		local row = list.insertRow(rowId, value)
		if (list.rows.len() <= list.visibleRows.len())
			updateTexture()
			
		return row
	}

	function addRow(value)
	{
		return insertRow(list.rows.len(), value)
	}

	function removeRow(rowId)
	{
		list.removeRow(rowId)
		if (list.rows.len() < list.visibleRows.len())
			updateTexture()	
	}

	function clear()
	{
		list.clear() 
		updateTexture()
	}

	function toggleOpen()
	{
		if (!_visible)
			return

		list.setVisible(!list.getVisible())
	}

	function updateTexture()
	{
		local pos = getPositionPx()
		local size = getSizePx()
		local margin = list.getMarginPx()

		GUI.Texture.setPositionPx.call(list, pos.x, (pos.y + size.height))

		if (list._visibleRowsCount != 0)
			GUI.Texture.setSizePx.call(list, size.width, ((list.getRowHeightPx() + list.getRowSpacingPx()) * list._visibleRowsCount) + (margin.top + margin.bottom))
		else
			GUI.Texture.setSizePx.call(list, size.width, 0)
	}

	function updateVisibleElements()
	{
		local oldVisibleRowsLen = list.visibleRows.len()
		local size = getSizePx()
		local margin = list.getMarginPx()
		local rowHeight = list.getRowHeightPx()
		local rowSpace = rowHeight + list.getRowSpacingPx()
		local rowsLen = list.rows.len()

		local visibleRowsLen = (_maxHeightPx - margin.top - margin.bottom) / rowSpace
		list._visibleRowsCount = visibleRowsLen <= rowsLen ? visibleRowsLen : rowsLen

		// Insert visibleRows loop:
		local font = list.getFont()
		local alignment = list.getAlignment()
		local isOpen = list.getVisible()
		for (local i = oldVisibleRowsLen; i < visibleRowsLen; ++i)
		{
			local visibleRow = GUI.ListVisibleRow(i, list, 0, 0, 0, 0, "", "")
			visibleRow.setFont(font)
			visibleRow.setAlignment(alignment)
			visibleRow.setVisible(isOpen)
			visibleRow.bind(EventType.Click, row_onClick)

			list.visibleRows.push(visibleRow)
		}

		//  Remove visibleRows loop:
		for (local i = oldVisibleRowsLen - 1; i >= visibleRowsLen; --i)
		{
			list.visibleRows[i].unbind(EventType.Click, row_onClick)
			list.visibleRows[i] = list.visibleRows[i].destroy()

			list.visibleRows.remove(i)
		}

		//  Update scrollbar:
		local pos = getPositionPx()
		local newPosY = pos.y + margin.top + size.height

		local scrollbar = list.scrollbar
		local scrollbarWidth = scrollbar.getSizePx().width
		scrollbar.setPositionPx((pos.x + size.width - scrollbarWidth), newPosY)
		scrollbar.setSizePx(scrollbarWidth, (rowSpace * visibleRowsLen) + margin.top + margin.bottom)

		//  Update visible rows:
		local newPosX = pos.x + margin.left
		local rowWidth = size.width - margin.left - margin.right
		foreach (visibleRow in list.visibleRows)
		{
			visibleRow.setPositionPx(newPosX, newPosY)
			visibleRow.setSizePx(rowWidth, rowHeight)
			newPosY += rowSpace
		}

		updateTexture()

		//  Update data and scrollbar values:
		local newMax = list.getMaxScrollbarValue()
		local oldMax = scrollbar.range.getMaximum()
		if (newMax != oldMax)
		{
			scrollbar.range.setMaximum(newMax)

			if (oldMax > newMax)
				list.refreshList()

			local scrollVisible = isOpen && newMax != 0
			if (scrollVisible != scrollbar.getVisible())
				scrollbar.setVisible(scrollVisible)
		}
		else
			list.refreshList()
	}

	static function onClick(self)
	{
		self.toggleOpen()
	}

	static function row_onClick(self)
	{
		local dropdownlist = self.parent.parent
		if (!dropdownlist.closeOnRowClick)
			return

		dropdownlist.toggleOpen()
	}
}