local GUINoteClasses = classes(GUI.Texture, GUI.Margin, GUI.Alignment)
class GUI.Note extends GUINoteClasses
{
#private:
	_font = "FONT_OLD_10_WHITE_HI.TGA"
	_lineSpacingPx = 0
	_separator = " "
	_visibleLinesCount = 0
	_LinesCount = 0
	_isWordsPerLine = true
	_text = ""
	_scrollValue = 0

#public:
	visibleLines = null
	lines = null
	scrollbar = null

	constructor(x, y, width, height, file, scrollBg, scrollIndicator, scrollIncreaseBtn, scrollDecreaseBtn, text, window = null)
    {
        visibleLines = []
        lines = []

        local oldFont = textGetFont()

        textSetFont(_font)
        _lineSpacingPx = letterHeightPx()
        textSetFont(oldFont)

        GUI.Margin.constructor.call(this)
        _alignment = Align.Left

        scrollbar = GUI.ScrollBar(x + width, y, anx(SCROLLBAR_SIZE), height, scrollBg, scrollIndicator, scrollIncreaseBtn, scrollDecreaseBtn, Orientation.Vertical)
        GUI.Texture.constructor.call(this, x, y, width, height, file, window)

        scrollbar.parent = this
        scrollbar.setMinimum(0)
        scrollbar.setMaximum(0)
        scrollbar.top()

        _text = text
        updateVisibleLines()
    }

	function updateVisibleLines()
	{
		local oldFont = textGetFont()
		local visible = getVisible()
		local oldVisibleLinesCount = _visibleLinesCount
		local pos = getPositionPx()
		local margin = getMarginPx()

		textSetFont(_font)
		_visibleLinesCount = (getSizePx().height - margin.top - margin.bottom - letterHeightPx())/_lineSpacingPx

		if(_visibleLinesCount > oldVisibleLinesCount)
		{
			for(local i = oldVisibleLinesCount; i < _visibleLinesCount; ++i)
			{
				visibleLines.append(GUI.Draw(0, 0, ""))
				visibleLines[i].setVisible(visible)
				visibleLines[i].setDisabled(true)
			}
		}

		else
		{
			for(local i = oldVisibleLinesCount - 1; i >= _visibleLinesCount; --i)
			{
				visibleLines[i] = visibleLines[i].destroy()
				visibleLines.remove(i)
			}
		}

		local marginPosX = pos.x + margin.left
		local marginPosY = pos.y + margin.top
		for(local i = 0; i < _visibleLinesCount; ++i)
		{
			visibleLines[i].setPositionPx(marginPosX, marginPosY + _lineSpacingPx * i)
		}

		setText(_text)
		textSetFont(oldFont)
	}

	function destroy()
	{
		foreach(i, v in visibleLines)
		{
			visibleLines[i] = visibleLines[i].destroy()
		}

		scrollbar = scrollbar.destroy()
		GUI.Texture.destroy.call(this)
	}

	function setVisible(visible)
	{
		GUI.Texture.setVisible.call(this, visible)
		scrollbar.setVisible(visible)

		foreach(line in visibleLines)
		{
			line.setVisible(visible)
		}
	}

	function setAlpha(alpha)
	{
		GUI.Texture.setAlpha.call(this, alpha)
		scrollbar.setAlpha(alpha)

		foreach(line in visibleLines)
		{
			line.setAlpha(alpha)
		}
	}

	function top()
	{
		GUI.Texture.top.call(this)

		foreach(line in visibleLines)
		{
			line.top()
		}

		scrollbar.top()
	}

	function setDisabled(bool)
	{
		GUI.Texture.setDisabled.call(this, bool)
		scrollbar.setDisabled(bool)
	}

	function setPositionPx(x, y)
	{
		GUI.Texture.setPositionPx.call(this, x, y)
		scrollbar.setPositionPx(x + getSizePx().width, y)

		updateVisibleLines()
	}

	function setPosition(x, y)
	{
		setPositionPx(nax(x), nay(y))
	}

	function setSizePx(width, height)
	{
		local positionPx = getPositionPx()

		GUI.Texture.setSizePx.call(this, width, height)
		scrollbar.setPositionPx(positionPx.x + width, positionPx.y)
		scrollbar.setSizePx(scrollbar.getSizePx().width, height - scrollbar.increaseButton.getSizePx().height - scrollbar.decreaseButton.getSizePx().height)
		updateVisibleLines()
	}

	function setSize(x, y)
	{
		setSizePx(nax(x), nay(y))
	}

	function setMarginPx(top, right, bottom, left)
	{
		GUI.Margin.setMarginPx.call(this, top, right, bottom, left)
		updateVisibleLines()
	}

	function setMargin(top, right, bottom, left)
	{
		setMarginPx(nay(top), nax(right), nay(bottom), nax(left))
	}

	function setLineSpacingPx(spacing)
	{
		_lineSpacingPx = spacing
		updateVisibleLines()
	}

	function getLineSpacingPx()
	{
		return _lineSpacingPx
	}

	function setLineSpacing(spacing)
	{
		setLineSpacingPx(nax(spacing))
	}

	function getLineSpacing()
	{
		return anx(_lineSpacingPx)
	}

	function setWordsPerLine(bool)
	{
		_isWordsPerLine = bool
		setText(getText())
	}

	function getWordsPerLine()
	{
		return _isWordsPerLine
	}

	function setFont(font)
	{
		local oldFont = textGetFont()
		_font = font.toupper()

		foreach(visibleLine in visibleLines)
		{
			visibleLine.setFont(_font)
		}

		textSetFont(font)
		setLineSpacingPx(letterHeightPx())
		textSetFont(oldFont)
	}

	function getFont()
	{
		return _font
	}

	function getText()
	{
		return _text
	}

	function setAlignment(alignment)
	{
		local positionX = getPositionPx().x
		local size = getSizePx()
		local margin = getMarginPx()
		GUI.Alignment.setAlignment.call(this, alignment)

		switch(alignment)
		{
			case Align.Left:
				foreach(line in lines)
				{
					line.posX = margin.left
				}
				break

			case Align.Center:
				foreach(line in lines)
				{
					line.posX = (size.width - textWidthPx(line.text))/2
				}
				break

			case Align.Right:
				local linePos = size.width - margin.right
				foreach(line in lines)
				{
					line.posX = linePos - textWidthPx(line.text)
				}
				break
		}

		local lastLineId = _visibleLinesCount + _scrollValue
		foreach(i, visibleLine in visibleLines)
		{
			if(i < _LinesCount)
			{
				if(i >= _scrollValue && i < lastLineId)
				{
					visibleLine.setPositionPx(lines[i].posX + positionX, visibleLine.getPositionPx().y)
				}
			}
		}
	}

	function setLineColor(id, red, green, blue)
	{
		lines[id].color = {r = red, g = green, b = blue}
		if(id >= _scrollValue && id < _visibleLinesCount + _scrollValue)
		{
			visibleLines[id].setColor(red, green, blue)
		}
	}

	function getLineColor(id)
	{
		return lines[id].color
	}

	function setLineAlpha(id, alpha)
	{
		lines[id].alpha <- alpha
		if(id >= _scrollValue && id < _visibleLinesCount + _scrollValue)
		{
			visibleLines[id].setAlpha(alpha)
		}
	}

	function getAlpha()
	{
		return lines[id].alpha
	}

	function addLine(lineText)
	{
		lines.push({text = lineText, posX = 0, color = {r = 255, g = 255, b = 255}, alpha = 255})
	}

	function setText(text)
	{
		local oldFont = textGetFont()

		textSetFont(_font)
		lines.clear()
		_text = text

		local margin = getMarginPx()
		local maxLineWidth = getSizePx().width - margin.right - margin.left
		local curLineWidth = 0
		local textLen = text.len() - 1
		local firstIndex = 0

		for(local index = 0; index <= textLen; ++index)
		{
			curLineWidth += textWidthPx(text[index].tochar().tostring())

			if(text[index] == '\n')
			{
				addLine(text.slice(firstIndex, index))
				curLineWidth = 0
				firstIndex = index + 1

				if(firstIndex > textLen)
				{
					firstIndex = textLen
				}
			}

			else if(curLineWidth >= maxLineWidth)
			{
				local curLineText = text.slice(firstIndex, index)

				if(!getWordsPerLine())
				{
					if(curLineText[0].tochar() == _separator)
					{
						curLineText = curLineText.slice(1)
					}

					addLine(curLineText)
					firstIndex = index
					curLineWidth = 0
				}

				else
				{
					local curLineTextLen = curLineText.len() - 1
					local foundSeparator = false

					for(local i = curLineTextLen; i >= 0; --i)
					{
						if(curLineText[i].tochar() == _separator)
						{
							addLine(curLineText.slice(0, i))
							firstIndex = index - curLineTextLen + i
							curLineWidth = textWidthPx(text.slice(firstIndex, index))
							foundSeparator = true
							break
						}
					}

					if(!foundSeparator)
					{
						addLine(curLineText)
						firstIndex = index
						curLineWidth = 0
					}
				}
			}
		}

		addLine(text.slice(firstIndex))
		_LinesCount = lines.len()

		if(_visibleLinesCount < _LinesCount)
		{
			scrollbar.setMaximum(_LinesCount - _visibleLinesCount)
		}

		else
		{
			scrollbar.setMaximum(0)
		}

		foreach(i, visibleLine in visibleLines)
		{
			if(_LinesCount > i)
			{
				visibleLine.setText(lines[i].text)
			}

			else visibleLine.setText("")
		}

		scrollbar.setValue(0)
		setAlignment(getAlignment())
		textSetFont(oldFont)
	}

	function refreshNote(scrollValue)
	{
		local positionX = getPositionPx().x
		_scrollValue = scrollValue

		foreach(i, visibleLine in visibleLines)
		{
			local lineIndex = i + _scrollValue
			if(lineIndex < _LinesCount)
			{
				local line = lines[lineIndex]
				local color = line.color

				visibleLine.setText(line.text)
				visibleLine.setPositionPx(line.posX + positionX, visibleLine.getPositionPx().y)
				visibleLine.setColor(color.r, color.g, color.b)
				visibleLine.setAlpha(line.alpha)
			}
		}
	}

	static function onChange(self)
	{
		local parent = self.parent
		if (!(self instanceof GUI.ScrollBar) || !(parent instanceof this))
		{
			return
		}

		parent.refreshNote(self.getValue().tointeger())
	}
}

addEventHandler("GUI.onChange", GUI.Note.onChange.bindenv(GUI.Note))
