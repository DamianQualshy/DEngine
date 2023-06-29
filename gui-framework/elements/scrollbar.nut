local activeHorizonalScrollBar = null
local activeVerticalScrollBar = null

local activeScrollBarButton = null
local activeScrollBarButtonDirection = 0
local scrollBarNextTick = getTickCount()

class GUI.ScrollBar
{
#public:
	parent = null

	range = null

	decreaseButton = null
	increaseButton = null

	// Scrollbar behavior:
	keysEnabled = true

	constructor(x, y, width, height, file, sliderFile, decreaseButtonFile, increaseButtonFile, orientation = Orientation.Horizontal, window = null)
	{
		switch (orientation)
		{
			case Orientation.Horizontal:
			{
				local buttonSize = anx(SCROLLBAR_BUTTON_SIZE)

				decreaseButton = GUI.Button(x, y, buttonSize, height, decreaseButtonFile)
				increaseButton = GUI.Button(x + width - buttonSize, y, buttonSize, height, increaseButtonFile)

				x += buttonSize
				width -= buttonSize * 2
				break
			}
			
			case Orientation.Vertical:
			{
				local buttonSize = any(SCROLLBAR_BUTTON_SIZE)

				decreaseButton = GUI.Button(x, y, width, buttonSize, decreaseButtonFile)
				increaseButton = GUI.Button(x, y + height - buttonSize, width, buttonSize, increaseButtonFile)

				y += buttonSize
				height -= buttonSize * 2
				break
			}
		}

		range = GUI.Range(x, y, width, height, file, sliderFile, orientation)

		decreaseButton.parent = this
		increaseButton.parent = this

		range.parent = this

		decreaseButton.bind(EventType.MouseDown, button_onMouseDown)
		decreaseButton.bind(EventType.Click, button_onClick)

		increaseButton.bind(EventType.MouseDown, button_onMouseDown)
		increaseButton.bind(EventType.Click, button_onClick)

		range.bind(EventType.Click, range_onClick)

		if (window)
			window.insert(this)
	}

	function destroy()
	{
		if (activeHorizonalScrollBar == this)
			activeHorizonalScrollBar = null
		else if (activeVerticalScrollBar == this)
			activeVerticalScrollBar = null

		if (activeScrollBarButton == decreaseButton || activeScrollBarButton == increaseButton)
			activeScrollBarButton = null

		decreaseButton = decreaseButton.destroy()
		increaseButton = increaseButton.destroy()

		range = range.destroy()
	}

	function getColor()
	{
		return range.getColor()
	}

	function setColor(r, g, b)
	{
		range.setColor(r, g, b)

		increaseButton.setColor(r, g, b)
		decreaseButton.setColor(r, g, b)
	}

	function getAlpha()
	{
		return range.getAlpha()
	}

	function setAlpha(alpha)
	{
		range.setAlpha(alpha)

		increaseButton.setAlpha(alpha)
		decreaseButton.setAlpha(alpha)
	}

	function top()
	{
		range.top()

		increaseButton.top()
		decreaseButton.top()
	}

	function getDisabled()
	{
		return range.getDisabled()
	}

	function setDisabled(disabled)
	{
		range.setDisabled(disabled)

		decreaseButton.setDisabled(disabled)
		increaseButton.setDisabled(disabled)
	}

	function getVisible()
	{
		return range.getVisible()
	}

    function setVisible(visible)
    {
        range.setVisible(visible)

        decreaseButton.setVisible(visible)
        increaseButton.setVisible(visible)

        if (!visible)
        {
			if (getActiveScrollbar(range._orientation) == this)
				setActiveScrollbar(range._orientation, null)
        }
        else
        {
			if (getActiveScrollbar(range._orientation) == null)
				setActiveScrollbar(range._orientation, this)
        }
    }

	function getPositionPx()
	{
		return decreaseButton.getPositionPx()
	}

	function getPosition()
	{
		return decreaseButton.getPosition()
	}

	function setPositionPx(x, y)
	{
		local buttonSize = decreaseButton.getSizePx()
		local rangeSize = range.getSizePx()

		switch (range._orientation)
		{
			case Orientation.Horizontal:
				decreaseButton.setPositionPx(x, y)
				range.setPositionPx(x + buttonSize.width, y)
				increaseButton.setPositionPx(x + buttonSize.width + rangeSize.width, y)
				break

			case Orientation.Vertical:
				decreaseButton.setPositionPx(x, y)
				range.setPositionPx(x, y + buttonSize.height)
				increaseButton.setPositionPx(x, y + buttonSize.height + rangeSize.height)
				break
		}
	}

	function setPosition(x, y)
	{
		setPositionPx(nax(x), nay(y))
	}

	function getSizePx()
	{
		local size = range.getSizePx()
		local buttonSize = decreaseButton.getSizePx()

		switch (range._orientation)
		{
			case Orientation.Horizontal:
				size.width += buttonSize.width * 2
				break

			case Orientation.Vertical:
				size.height += buttonSize.height * 2
				break
		}

		return size
	}

	function getSize()
	{
		local sizePx = getSizePx()
		return {width = anx(sizePx.width), height = any(sizePx.height)}
	}

	function setSizePx(width, height)
	{
		local position = getPositionPx()
		local buttonSize = decreaseButton.getSizePx()

		switch (range._orientation)
		{
			case Orientation.Horizontal:
				range.setSizePx(width - buttonSize.width * 2, height)
				increaseButton.setPositionPx(position.x + width - buttonSize.width, position.y)
				break

			case Orientation.Vertical:
				range.setSizePx(width, height - buttonSize.height * 2)
				increaseButton.setPositionPx(position.x, position.y + height - buttonSize.height)
				break
		}
	}

	function setSize(width, height)
	{
		setSizePx(nax(width), nay(height))
	}

	static function getActiveScrollbar(orientation)
	{
		switch (orientation)
		{
			case Orientation.Horizontal:
				return activeHorizonalScrollBar
			
			case Orientation.Vertical:
				return activeVerticalScrollBar

			default:
				return null
		}
	}

	static function setActiveScrollbar(orientation, scrollBar)
	{
		switch (orientation)
		{
			case Orientation.Horizontal:
				activeHorizonalScrollBar = scrollBar
				break

			case Orientation.Vertical:
				activeVerticalScrollBar = scrollBar
				break
		}
	}

	static function button_onClick(self)
    {
		local scrollbar = self.parent
		scrollbar.range_onClick(scrollbar.range)
    }

	static function range_onClick(self)
    {
		local scrollBar = self.parent
		scrollBar.setActiveScrollbar(self._orientation, scrollBar)
    }

	static function button_onMouseDown(self, btn)
	{
		if (btn != MOUSE_LMB)
			return

		local scrollBar = self.parent
		activeScrollBarButton = self

		switch (self)
		{
			case scrollBar.decreaseButton:
				activeScrollBarButtonDirection = -1
				scrollBarNextTick = getTickCount()
				break

			case scrollBar.increaseButton:
				activeScrollBarButtonDirection = 1
				scrollBarNextTick = getTickCount()
				break
		}
	}

	static function onMouseRelease(btn)
	{
		if (btn != MOUSE_LMB)
			return

		activeScrollBarButton = null
	}

	static function onRender()
	{
		if (!activeScrollBarButton)
			return

		local now = getTickCount()

		if (scrollBarNextTick > now)
			return

		scrollBarNextTick = scrollBarNextTick + 100

		if (!activeScrollBarButton.isMouseAt())
			return

		local scrollBar = activeScrollBarButton.parent
		scrollBar.range.setValue(scrollBar.range.getValue() + activeScrollBarButtonDirection * scrollBar.range._step)
	}

	static function onKey(key)
	{
		local horizontalKey = 0
		local verticalKey = 0

		switch (key)
		{
			case KEY_LEFT:
				horizontalKey = -1
				break

			case KEY_RIGHT:
				horizontalKey = 1
				break

			case KEY_UP:
				verticalKey = -1
				break

			case KEY_DOWN:
				verticalKey = 1
				break
		}

		if (horizontalKey)
		{
			if (!activeHorizonalScrollBar || activeHorizonalScrollBar.getDisabled())
				return

			if (!activeHorizonalScrollBar.keysEnabled)
				return

			activeHorizonalScrollBar.range.setValue(activeHorizonalScrollBar.range.getValue() + activeHorizonalScrollBar.range._step * horizontalKey)
		}
		else if (verticalKey)
		{
			if (!activeVerticalScrollBar || activeVerticalScrollBar.getDisabled())
				return

			if (!activeVerticalScrollBar.keysEnabled)
				return

			activeVerticalScrollBar.range.setValue(activeVerticalScrollBar.range.getValue() + activeVerticalScrollBar.range._step * verticalKey)
		}
	}

	static function onMouseWheel(direction)
	{
		if (!activeVerticalScrollBar || activeVerticalScrollBar.getDisabled())
			return

		activeVerticalScrollBar.range.setValue(activeVerticalScrollBar.range.getValue() - direction * activeVerticalScrollBar.range._step)
	}
}

addEventHandler("onMouseRelease", GUI.ScrollBar.onMouseRelease)
addEventHandler("onRender", GUI.ScrollBar.onRender)
addEventHandler("onKey", GUI.ScrollBar.onKey)
addEventHandler("onMouseWheel", GUI.ScrollBar.onMouseWheel)
