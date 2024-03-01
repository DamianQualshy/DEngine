local DataLine = class
{
#public:
	id = -1
	parent = null
	metadata = null

#private:
	_text = ""
	_color = null

	// ReadOnly
	_offsetXPx = 0 
	_widthPx = 0	

	constructor(id, parent, arg)
	{
		this.id = id
		this.parent = parent
		metadata = "metadata" in arg ? arg.metadata : {}

		_text = "text" in arg ? arg.text : _text
		_color = Color(255, 255, 255, 255)
		_widthPx = "widthPx" in arg ? arg.widthPx : _widthPx

		setColor("color" in arg ? arg.color : _color)
	}

	function getVisibleLine()
	{
		local scrollValue = parent.scrollbar.range.getValue()
		if (id >= scrollValue && id < parent.visibleLines.len() + scrollValue)
			return parent.visibleLines[id - scrollValue]
		
		return null
	}

	function getText()
	{
		return _text
	}

	function setText(text)
	{
		_text = text

		local visibleLine = getVisibleLine()
		if (visibleLine)
			visibleLine.setText(text)
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

		local visibleLine = getVisibleLine()
		if (visibleLine)
			visibleLine.setColor(color)
	}

	function getOffsetPx()
	{
		return _offsetXPx
	}
}


local GUINoteClasses = classes(GUI.Texture, GUI.Margin, GUI.Alignment)
class GUI.Note extends GUINoteClasses
{
#private:
	_scrollbarVisibilityMode = ScrollbarVisibilityMode.Needed
	_font = "FONT_OLD_10_WHITE_HI.TGA"
	_lineHeightPx = 0
	_separator = " "
	_isWordsPerLine = true
	_text = ""
	_scale = null

#public:
	visibleLines = null
	lines = null
	scrollbar = null

	constructor(arg = null)
	{
		_scrollbarVisibilityMode = "scrollbarVisibilityMode" in arg ? arg.scrollbarVisibilityMode : _scrollbarVisibilityMode
		_font = "font" in arg ? arg.font : _font

		if ("lineHeightPx" in arg)
			_lineHeightPx = arg.lineHeightPx
		else if ("lineHeight" in arg)
			_lineHeightPx = nay(arg.lineHeight)
		else
		{
			local oldFont = textGetFont()
			textSetFont(_font)
			_lineHeightPx = letterHeightPx()
			textSetFont(oldFont)
		}

		_separator = "separator" in arg ? arg.separator : _separator
		_isWordsPerLine = "isWordsPerLine" in arg ? arg.isWordsPerLine : _isWordsPerLine
		_text = "text" in arg ? arg.text : _text
		_scale = "scale" in arg ? arg.scale : {x = 1.0, y = 1.0}

		GUI.Margin.constructor.call(this, arg)
		_alignment = "align" in arg ? arg.align : Align.Left

		visibleLines = []
		lines = []

		scrollbar = GUI.ScrollBar("scrollbar" in arg ? arg.scrollbar : null)
		scrollbar.parent = this
		scrollbar.range.setMaximum(0)
		scrollbar.range.bind(EventType.Change, function(self) {
			self.parent.parent.refresh()
		})

		if (scrollbar.getSizePx().width == 0)
			scrollbar.setSizePx(SCROLLBAR_SIZE, 0)

		GUI.Texture.constructor.call(this, arg)
		updateScrollbar()
		updateVisibleLines()
	}

	function setPositionPx(x, y)
	{
		local positionPx = getPositionPx()
		GUI.Texture.setPositionPx.call(this, x, y)
		
		local offsetXPx = x - positionPx.x
		local offsetYPx = y - positionPx.y

		local scrollbarPositionPx = scrollbar.getPositionPx()
		scrollbar.setPositionPx(scrollbarPositionPx.x + offsetXPx, scrollbarPositionPx.y + offsetYPx)

		foreach (visibleLine in visibleLines)
		{
			local visibleLinePositionPx = visibleLine.getPositionPx()
			visibleLine.setPositionPx(visibleLinePositionPx.x + offsetXPx, visibleLinePositionPx.y + offsetYPx)
		}
	}

	function setSizePx(width, height)
	{
		GUI.Texture.setSizePx.call(this, width, height)

		updateScrollbar()
		updateVisibleLines()
	}

	function setMarginPx(top, right, bottom, left)
	{
		GUI.Margin.setMarginPx.call(this, top, right, bottom, left)
		updateVisibleLines()
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
				scrollbar.setVisible(visible && visibleLines.len() < lines.len())
				break

			case ScrollbarVisibilityMode.Never:
				scrollbar.setVisible(false)
				break
		}
	}

	function setVisible(visible)
	{
		GUI.Texture.setVisible.call(this, visible)
		foreach(visibleLine in visibleLines)
			visibleLine.setVisible(visible)

		updateScrollbarVisibility()
	}

	function top()
	{
		GUI.Texture.top.call(this)

		foreach(visibleLine in visibleLines)
			visibleLine.top()

		scrollbar.top()
	}

	function setDisabled(bool)
	{
		GUI.Texture.setDisabled.call(this, bool)
		scrollbar.setDisabled(bool)
	}

	function getLineHeightPx()
	{
		return _lineHeightPx
	}

	function setLineHeightPx(spacing)
	{
		_lineHeightPx = spacing
		updateVisibleLines()
	}

	function getLineHeight()
	{
		return anx(_lineHeightPx)
	}

	function setLineHeight(spacing)
	{
		setLineHeightPx(nax(spacing))
	}


	function getScale()
	{
		return _scale
	}	

	function setScale(x, y)
	{
		_scale = {x = x, y = y}
		updateVisibleLines()
	}

	function getWordsPerLine()
	{
		return _isWordsPerLine
	}	

	function setWordsPerLine(bool)
	{
		_isWordsPerLine = bool
		updateLines()
	}

	function getFont()
	{
		return _font
	}

	function setFont(font)
	{
		_font = font.toupper()

		foreach(visibleLine in visibleLines)
			visibleLine.setFont(_font)
	}

	function setAlignment(alignment)
	{
		GUI.Alignment.setAlignment.call(this, alignment)
		updateLinesOffset()
	}

	function getMaxScrollbarValue()
	{
		local difference = lines.len() - visibleLines.len()
			return difference > 0 ? difference : 0
	}

	function insertLine(id, arg)
	{
		local line = DataLine(id, this, arg)
		local marginPx = getMarginPx()
		local sizePx = getSizePx()
		line._widthPx = textWidthPx(line.getText()) * _scale.x

		switch (getAlignment())
		{
			case Align.Left:
				line._offsetXPx = marginPx.left
				break

			case Align.Center:
				line._offsetXPx = marginPx.left + ((sizePx.width - marginPx.right) - line._widthPx) / 2
				break

			case Align.Right:
				line._offsetXPx = sizePx.width - line._widthPx - marginPx.right
				break
		}		

		lines.insert(id, line)

		_text = ""
		foreach (i, line in lines)
			_text += line.getText()

		local maxScrollbarValue = getMaxScrollbarValue()
		if (maxScrollbarValue != 0)
		{
			scrollbar.range.setMaximum(maxScrollbarValue)

			if (!scrollbar.getVisible() && getVisible() && _scrollbarVisibilityMode == ScrollbarVisibilityMode.Needed)
				scrollbar.setVisible(true) 
		}

		for (local i = id + 1, end = lines.len(); i < end; ++i)
			++lines[i].id

		refresh()
	}

	function addLine(arg)
	{
		insertLine(lines.len(), arg)
	}

	function removeLine(id)
	{
		for (local i = lines.len() - 1; i > id; --i)
			--lines[i].id

		lines.remove(id)

		_text = ""
		foreach (i, line in lines)
			_text += line.getText()

		local oldMax = scrollbar.range.getMaximum()
		scrollbar.range.setMaximum(getMaxScrollbarValue())

		if (oldMax == 1 && scrollbar.getVisible() && _scrollbarVisibilityMode == ScrollbarVisibilityMode.Needed)
			scrollbar.setVisible(false)

		refresh()
	}

	function getText()
	{
		return _text
	}

	function setText(text)
	{
		_text = text
		updateLines()
	}

	function updateLines()
	{
		local oldFont = textGetFont()
		local textLen = _text.len()
		lines.clear()

		if (!textLen)
		{
			scrollbar.range.setMaximum(0)
			updateScrollbarVisibility()
			refresh()
			return
		}

		textSetFont(_font)
		local marginPx = getMarginPx()
		local maxLineWidthPx = getSizePx().width - marginPx.right - marginPx.left

		local curLineText = ""
		local curLineWidthPx = 0

		for (local curTextId = 0, textLen = textLen; curTextId < textLen; ++curTextId)
		{
			local curTextAsciiCode = _text[curTextId]
			local curTextLetter = curTextAsciiCode.tochar().tostring()
			local curTextLetterWidthPx = textWidthPx(curTextLetter) * _scale.x

			if (curTextAsciiCode == '\n')
			{
				lines.push(DataLine(lines.len(), this, {text = curLineText, widthPx = curLineWidthPx}))
				curLineText = ""
				curLineWidthPx = 0
			}
			else if (curLineWidthPx >= maxLineWidthPx)
			{
				if (!_isWordsPerLine)
				{
					lines.push(DataLine(lines.len(), this, {text = curLineText, widthPx = curLineWidthPx}))
					curLineText = ""
					curLineWidthPx = 0
				}
				else
				{
					local foundSeparator = false
					local newLineText = ""
					local newLineWidthPx = 0

					for (local newLineId = curLineText.len() - 1; newLineId >= 0; --newLineId)
					{
						local newLineLetter = curLineText[newLineId].tochar().tostring()
						local newLineLetterWidthPx = textWidthPx(newLineLetter) * _scale.x

						if (newLineLetter == _separator)
						{
							lines.push(DataLine(lines.len(), this, {text = curLineText.slice(0, newLineId), widthPx = curLineWidthPx - newLineWidthPx}))
							curLineText = newLineText + curTextLetter
							curLineWidthPx = newLineWidthPx + curTextLetterWidthPx

							foundSeparator = true
							break
						}
						else
						{
							newLineText = newLineLetter + newLineText
							newLineWidthPx += newLineLetterWidthPx
						}
					}

					if (!foundSeparator)
					{
						lines.push(DataLine(lines.len(), this, {text = curLineText, widthPx = curLineWidthPx}))
						curLineText = ""
						curLineWidthPx = 0
					}
				}
			}
			else	
			{
				curLineText += curTextLetter
				curLineWidthPx += curTextLetterWidthPx
			}
		}
		
		if (curLineText.len())
			lines.push(DataLine(lines.len(), this, {text = curLineText, widthPx = curLineWidthPx}))

		textSetFont(oldFont)
		local linesLen = lines.len()
		local visibleLinesLen = visibleLines.len()
		scrollbar.range.setMaximum((visibleLinesLen < linesLen) ? (linesLen - visibleLinesLen) : 0)
		updateLinesOffset()

		if (scrollbar.range.getValue() != 0)
			scrollbar.range.setValue(0)
			
		refresh()
		updateScrollbarVisibility()
	}

	function updateVisibleLines()
	{
		local oldCount = visibleLines.len()
		local marginPx = getMarginPx()
		local newCount = (getSizePx().height - marginPx.top - marginPx.bottom) / _lineHeightPx

		for (local i = oldCount; i < newCount; ++i)
		{
			local line = GUI.Draw({disabled = true, font = _font})
			line.setScale(_scale.x, _scale.y)

			visibleLines.push(line)
		}

		for (local i = oldCount - 1; i >= newCount; --i)
			visibleLines.remove(i)

		updateLines()
	}

	function updateScrollbar()
	{
		local sizePx = getSizePx()
		local positionPx = getPositionPx()
		local scrollbarWidthPx = scrollbar.getSizePx().width

		scrollbar.setPositionPx((positionPx.x + sizePx.width - scrollbarWidthPx), positionPx.y)
		scrollbar.setSizePx(scrollbarWidthPx, sizePx.height)
	}

	function updateLinesOffset()
	{
		local sizePx = getSizePx()
		local marginPx = getMarginPx()

		switch (getAlignment())
		{
			case Align.Left:
			{
				foreach (i, line in lines)
					line._offsetXPx = marginPx.left
				break
			}

			case Align.Center:
			{
				foreach (i, line in lines)
					line._offsetXPx = marginPx.left + ((sizePx.width - marginPx.right) - line._widthPx) / 2
				break
			}

			case Align.Right:
			{
				foreach (i, line in lines)
					line._offsetXPx = sizePx.width - line._widthPx - marginPx.right
				break
			}
		}
	}

	function refresh()
	{
		local positionPx = getPositionPx()
		local scrollbarValue = scrollbar.range.getValue()
		local maxLinesIndex = lines.len() - 1
		local positionYPx = positionPx.y + getMarginPx().top

		foreach(i, visibleLine in visibleLines)
		{
			if (maxLinesIndex < i)
			{
				if (visibleLine.getText() != " ")
					visibleLine.setText(" ")
				continue
			}

			local line = lines[i + scrollbarValue]
			local text = line.getText()

			visibleLine.setText(text.len() ? text : " ")
			visibleLine.setColor(line.getColor())
			visibleLine.setScale(_scale.x, _scale.y)

			visibleLine.setPositionPx(positionPx.x + line.getOffsetPx(), positionYPx)
			positionYPx += _lineHeightPx
		}
	}
}