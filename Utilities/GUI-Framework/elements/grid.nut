local GridCell = class
{
#public:
	parent = null
	id = null
	metadata = null

#private:
	_text = null
	_value = null
	_color = null
	_drawColor = null
	_file = ""
	_font = "FONT_OLD_10_WHITE_HI.TGA"
	_isDisabled = false

	constructor(parent, id, arg)
	{
		this.parent = parent
		this.id = id
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

	function getVisibleCell()
	{
		local offsetId = parent.scrollbar.range.getValue() * parent._horizontalCount
		if (id >= offsetId && id < parent.visibleCells.len() + offsetId)
			return parent.visibleCells[id - offsetId]
		
		return null
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

		local visibleCell = getVisibleCell()
		if (visibleCell)
			visibleCell.setColor(color)
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

		local visibleCell = getVisibleCell()
		if (visibleCell)
			visibleCell.draw.setColor(color)
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

class GUI.GridVisibleCell extends GUI.Button
{
#public:
	id = null

	constructor(parent, id, width, height)
	{
		base.constructor({sizePx = {width = width, height = height}, draw = null})
		this.parent = parent
		this.id = id
	}

	function getDataCell()
	{
		local offsetId = (parent.scrollbar.range.getValue() * parent._horizontalCount) + id
		if (offsetId >= parent.cells.len())
			return null

		return parent.cells[offsetId]
	}
}


local GUIGridClasses = classes(GUI.Texture, GUI.Margin)
class GUI.Grid extends GUIGridClasses
{
#public:
	visibleCells = null
	cells = null
	scrollbar = null

#private:
	_cellWidthPx = 0
	_cellHeightPx = 0

	_spacingXPx = 0
	_spacingYPx = 0

	_horizontalCount = 0
	_visibleCellsCount = 0

	_scrollbarVisibilityMode = ScrollbarVisibilityMode.Always

	constructor(arg)
	{
		_scrollbarVisibilityMode = "scrollbarVisibilityMode" in arg ? arg.scrollbarVisibilityMode : _scrollbarVisibilityMode
		GUI.Margin.constructor.call(this, arg)
		visibleCells = []
		cells = []

		GUI.Texture.constructor.call(this, arg)

		scrollbar = GUI.ScrollBar("scrollbar" in arg ? arg.scrollbar : null)
		scrollbar.parent = this
		scrollbar.range.setMaximum(0)
		scrollbar.range.bind(EventType.Change, function(self) {
			self.parent.parent.refresh()
		})

		if (scrollbar.getSizePx().width == 0)
			scrollbar.setSizePx(SCROLLBAR_SIZE, 0)

		if ("cellWidthPx" in arg)
			_cellWidthPx = arg.cellWidthPx
		else if ("cellWidth" in arg)
			_cellWidthPx = nax(arg.cellWidth)

		if ("cellHeightPx" in arg)
			_cellHeightPx = arg.cellHeightPx
		else if ("cellHeight" in arg)
			_cellHeightPx = nay(arg.cellHeight)

		if ("spacingXPx" in arg)
			_spacingXPx = arg.spacingXPx
		else if ("spacingX" in arg)
			_spacingXPx = nax(arg.spacingX)

		if ("spacingYPx" in arg)
			_spacingYPx = arg.spacingYPx
		else if ("spacingY" in arg)
			_spacingYPx = nay(arg.spacingY)		

		updateVisibleElements()
	}

	function setDisabled(toggle)
	{
		GUI.Texture.setDisabled.call(this, toggle)
		scrollbar.setDisabled(toggle)

		foreach (visibleCell in visibleCells)
			visibleCell.setDisabled(toggle)
	}

	function top()
	{
		GUI.Texture.top.call(this)

		foreach (visibleCell in visibleCells)
			visibleCell.top()

		scrollbar.top()
	}

	function setPositionPx(x, y)
	{
		local positionPx = getPositionPx()
		GUI.Texture.setPositionPx.call(this, x, y)
		
		local offsetXPx = x - positionPx.x
		local offsetYPx = y - positionPx.y

		local scrollbarPositionPx = scrollbar.getPositionPx()
		scrollbar.setPositionPx(scrollbarPositionPx.x + offsetXPx, scrollbarPositionPx.y + offsetYPx)

		foreach (visibleCell in visibleCells)
		{
			local visibleCellPositionPx = visibleCell.getPositionPx()
			visibleCell.setPositionPx(visibleCellPositionPx.x + offsetXPx, visibleCellPositionPx.y + offsetYPx)
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

	function getCellWidthPx()
	{
		return _cellWidthPx
	}

	function setCellWidthPx(cellWidthPx)
	{
		_cellWidthPx = cellWidthPx
		updateVisibleElements()
	}

	function getCellHeightPx()
	{
		return _cellHeightPx
	}

	function setCellHeightPx(cellHeightPx)
	{
		_cellHeightPx = cellHeightPx
		updateVisibleElements()
	}

	function getCellHeightPx()
	{
		return _cellHeightPx
	}

	function getSpacingXPx()
	{
		return _spacingXPx
	}

	function setSpacingXPx(spacingX)
	{
		_spacingXPx = spacingX
		updateVisibleElements()
	}

	function getSpacingYPx()
	{
		return _spacingYPx
	}

	function setSpacingYPx(spacingY)
	{
		_spacingYPx = spacingY
		updateVisibleElements()
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
		foreach (visibleCell in visibleCells)
			visibleCell.setVisible(toggle && visibleCell.getDataCell())
			
		updateScrollbarVisibility()
	}

	function insertCell(id, arg)
	{
		if (_visibleCellsCount < visibleCells.len())
			++_visibleCellsCount

		local cell = GridCell(this, id, arg)
		cells.insert(id, cell)

		for (local i = id + 1, end = cells.len(); i < end; ++i)
			++cells[i].id

		local max = getMaxScrollbarValue()
		if (max > 0)
		{
			scrollbar.range.setMaximum(max)

			if (!scrollbar.getVisible() && visible && _scrollbarVisibilityMode == ScrollbarVisibilityMode.Needed)
				scrollbar.setVisible(true) 
		}

		if (id >= (scrollbar.range.getValue() * _horizontalCount) + visibleCells.len())
			return cell

		local visibleCell = cell.getVisibleCell()
		local begin = visibleCell ? visibleCell.id : 0

		refresh(begin)
		return cell
	}

	function addCell(arg) {
		return insertCell(cells.len(), arg)
	}

	function removeCell(id)
	{
		if (cells.len() <= visibleCells.len())
		{
			--_visibleCellsCount

			local visibleCell = visibleCells[_visibleCellsCount]
			if (visibleCell.getVisible())
				visibleCell.setVisible(false)
		}

		for (local i = cells.len() - 1; i > id; --i)
			--cells[i].id

		cells.remove(id)
	
		local oldMax = scrollbar.range.getMaximum()
		if (oldMax > 0)
		{
			scrollbar.range.setMaximum(getMaxScrollbarValue())
			refresh()

			if (scrollbar.range.getValue() < oldMax)
				refresh()
		}
		else
			refresh()

		if (oldMax == 1 && scrollbar.getVisible() && _scrollbarVisibilityMode == ScrollbarVisibilityMode.Needed)
			scrollbar.setVisible(false)
	}

	function clear()
	{
		cells.clear()

		local oldValue = scrollbar.range.getValue()
		scrollbar.range.setMaximum(0)

		if (scrollbar.getVisible() && _scrollbarVisibilityMode == ScrollbarVisibilityMode.Needed)
			scrollbar.setVisible(false)

		if (oldValue == 0)
			refresh()

		_visibleCellsCount = 0
	}

	function sort(func)
	{
		cells.sort(func)
		foreach (i, cell in cells)
			cell.id = i

		refresh()
	}

	function findCell(value)
	{
		foreach (cell in cells)
		{
			if (cell.getValue() == value)
				return cell
		}

		return null 
	}

	function getMaxScrollbarValue()
	{
		if (_horizontalCount == 0)
			return 0

		local cellsLen = cells.len()
		local visibleCellsLen = visibleCells.len()

		if (cellsLen > visibleCellsLen)
		{
			local difference = (cellsLen - visibleCellsLen) / _horizontalCount
			local rest = (cellsLen - visibleCellsLen) % _horizontalCount
			return rest != 0 ? difference + 1 : difference
		}
		else
			return 0
	}

	function updateVisibleElements()
	{
		local size = getSizePx()
		local margin = getMarginPx()
		local horizontalCellSize = _cellWidthPx + _spacingXPx
		local verticalCellSize = _cellHeightPx + _spacingYPx
		
		_horizontalCount = (_cellWidthPx > 0) ? ((size.width - margin.left - margin.right + _spacingXPx) / horizontalCellSize) : 0
		local verticalCount = (_cellHeightPx > 0) ? ((size.height - margin.top - margin.bottom + _spacingYPx) / verticalCellSize) : 0

		local visibleCellsLen = verticalCount * _horizontalCount
		local oldVisibleCellsLen = visibleCells.len()

		local cellsLen = cells.len()
		_visibleCellsCount = visibleCellsLen <= cellsLen ? visibleCellsLen : cellsLen

		for (local i = oldVisibleCellsLen; i < visibleCellsLen; ++i)
		{
			visibleCells.push(GUI.GridVisibleCell(this, i, _cellWidthPx, _cellHeightPx))
		}
		for (local i = oldVisibleCellsLen - 1; i >= visibleCellsLen; --i)
		{
			visibleCells[i] = null
			visibleCells.remove(i)
		}

		local pos = getPositionPx()
		for (local i = 0, y = 0; y < verticalCount; ++y)
		{
			local cellPosY = pos.y + margin.top + (y * verticalCellSize)
			for (local x = 0; x < _horizontalCount; ++x)
			{
				visibleCells[i].setSizePx(_cellWidthPx, _cellHeightPx)
				visibleCells[i].setPositionPx(pos.x + margin.left + x * horizontalCellSize, cellPosY)
				++i
			}
		}

		local scrollbarWidth = scrollbar.getSizePx().width
		scrollbar.setPositionPx((pos.x + size.width - scrollbarWidth), pos.y)
		scrollbar.setSizePx(scrollbarWidth, size.height)

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
		local offsetId = scrollbar.range.getValue() * _horizontalCount
		local cellsLen = cells.len()
		local visible = getVisible()

		for (local i = begin; i < _visibleCellsCount; ++i)
		{
			local cellId = i + offsetId
			if (cellId >= cellsLen)
			{
				if (visible)
					visibleCells[i].setVisible(false)

				continue
			}

			local cell = cells[cellId]
			local visibleCell = visibleCells[i]
	
	
			visibleCell.setText(cell.getText())
			visibleCell.setColor(cell.getColor())
			visibleCell.draw.setColor(cell.getDrawColor())

			visibleCell.setFile(cell.getFile())
			visibleCell.setFont(cell.getFont())
			visibleCell.setDisabled(cell.getDisabled())
	
			if (visible && !visibleCell.getVisible())
				visibleCell.setVisible(true)
		}
	}

	function onChange(self)
	{	  
		local scrollbar = self.parent
		local grid = scrollbar.parent

		grid.refresh()
	}
}