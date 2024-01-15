local ref =
{
	activeHorizonalScrollBar = null
	activeVerticalScrollBar = null

	activeScrollBarButton = null
}

local activeScrollBarButtonDirection = 0
local scrollBarNextTick = getTickCount()

class GUI.ScrollBar extends GUI.Base
{
#private:
	_buttonSizePx = 0
	_visibilityMode = ScrollbarVisibilityMode.Always

#public:
	keysEnabled = true

	range = null
	decreaseButton = null
	increaseButton = null
	
	constructor(arg = null)
	{
		base.constructor(arg)

		local argRange = "range" in arg ? arg.range : null
		if (argRange == null)
			argRange = {orientation = Orientation.Vertical}
		else if (!("orientation" in argRange))
			argRange["orientation"] <- Orientation.Vertical

		range = GUI.Range(argRange)
		range.parent = this
		range.bind(EventType.Click, range_onClick)

		decreaseButton = GUI.Button("decreaseButton" in arg ? arg.decreaseButton : null)
		decreaseButton.parent = this
		decreaseButton.bind(EventType.MouseDown, button_onMouseDown)
		decreaseButton.bind(EventType.Click, button_onClick)

		increaseButton = GUI.Button("increaseButton" in arg ? arg.increaseButton : null)
		increaseButton.parent = this
		increaseButton.bind(EventType.MouseDown, button_onMouseDown)
		increaseButton.bind(EventType.Click, button_onClick)

		keysEnabled = "keysEnabled" in arg ? arg.keysEnabled : keysEnabled

		if ("buttonSizePx" in arg)
			_buttonSizePx = arg.buttonSizePx
		if ("buttonSize" in arg)
			_buttonSizePx = (range._orientation == Orientation.Horizontal) ? nax(arg.buttonSize) : nay(arg.buttonSize)
		else
			_buttonSizePx = SCROLLBAR_BUTTON_SIZE

		local sizePx
		if ("sizePx" in arg)
			sizePx = {width = arg.sizePx.width, height = arg.sizePx.height}
		else if ("size" in arg)
			sizePx = {width = nax(arg.size.width), height = nay(arg.size.height)}
		else
			sizePx = {width = 0, height = 0}

		local positionPx
		if ("positionPx" in arg)
			positionPx = {x = arg.positionPx.x, y = arg.positionPx.y}
		else if ("position" in arg)
			positionPx = {x = nax(arg.position.x), y = nay(arg.position.y)}
		else if ("relativePositionPx" in arg)
		{
			local collectionPositionPx = collection.getPositionPx()
			positionPx = {x = collectionPositionPx.x + arg.relativePositionPx.x, y = collectionPositionPx.y + arg.relativePositionPx.y}
		}
		else if ("relativePosition" in arg)
		{
			local collectionPositionPx = collection.getPosition()
			positionPx = {x = collectionPositionPx.x + nax(arg.relativePosition.x), y = collectionPositionPx.y + nay(arg.relativePosition.y)}
		}
		else
			positionPx = {x = 0, y = 0}

		updateElements(sizePx.width, sizePx.height, positionPx.x, positionPx.y)

		if ("color" in arg)
			setColor(arg.color.r, arg.color.g, arg.color.b)

		if ("alpha" in arg)
			setAlpha(arg.apha)
	}

	function setVisibilityMode(visibilityMode)
	{
		_visibilityMode = visibilityMode
	}

	function getVisibilityMode()
	{
		return _visibilityMode
	}

	function setButtonSizePx(buttonSize)
	{
		local sizePx = getSizePx()
		local positionPx = getPositionPx()

		_buttonSizePx = buttonSize
		updateElements(sizePx.width, sizePx.height, positionPx.x, positionPx.y)
	}

	function setButtonSize(buttonSize)
	{
		switch (range._orientation)
		{
			case Orientation.Horizontal:
				setButtonSizePx(nax(buttonSize))
				break

			case Orientation.Vertical:
				setButtonSizePx(nay(buttonSize))
				break
		}
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

	function setDisabled(disabled)
	{
		base.setDisabled(disabled)

		range.setDisabled(disabled)
		decreaseButton.setDisabled(disabled)
		increaseButton.setDisabled(disabled)
	}

	function setVisible(visible)
	{
		base.setVisible(visible)

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

	function setPositionPx(x, y)
	{
		local positionPx = getPositionPx()

		local offsetXPx = x - positionPx.x
		local offsetYPx = y - positionPx.y

		local decreaseButtonPositionPx = decreaseButton.getPositionPx()
		decreaseButton.setPositionPx(decreaseButtonPositionPx.x + offsetXPx, decreaseButtonPositionPx.y + offsetYPx)

		local rangePositionPx = range.getPositionPx()
		range.setPositionPx(rangePositionPx.x + offsetXPx, rangePositionPx.y + offsetYPx)

		local increaseButtonPositionPx = increaseButton.getPositionPx()
		increaseButton.setPositionPx(increaseButtonPositionPx.x + offsetXPx, increaseButtonPositionPx.y + offsetYPx)
	}

	function getSizePx()
	{
		local sizePx = range.getSizePx()
		switch (range._orientation)
		{
			case Orientation.Horizontal:
				sizePx.width += _buttonSizePx * 2
				break

			case Orientation.Vertical:
				sizePx.height += _buttonSizePx * 2
				break
		}

		return sizePx
	}

	function setSizePx(width, height)
	{
		local positionPx = getPositionPx()
		updateElements(width, height, positionPx.x, positionPx.y)
	}

	function updateElements(width, height, x, y)
	{
		switch (range._orientation)
		{
			case Orientation.Horizontal:
				local rangeSizePx = width - 2 * _buttonSizePx

				decreaseButton.setSizePx(_buttonSizePx, height)
				decreaseButton.setPositionPx(x, y)

				range.setSizePx(rangeSizePx, height)
				range.setPositionPx(x + _buttonSizePx, y)

				increaseButton.setSizePx(_buttonSizePx, height)
				increaseButton.setPositionPx(x + rangeSizePx + _buttonSizePx, y)
				break

			case Orientation.Vertical:
				local rangeSizePx = height - 2 * _buttonSizePx

				decreaseButton.setSizePx(width, _buttonSizePx)
				decreaseButton.setPositionPx(x, y)

				range.setSizePx(width, rangeSizePx)
				range.setPositionPx(x, y + _buttonSizePx)

				increaseButton.setSizePx(width, _buttonSizePx)
				increaseButton.setPositionPx(x, y + rangeSizePx + _buttonSizePx)
				break
		}
	}

	static function getActiveScrollbar(orientation)
	{
		switch (orientation)
		{
			case Orientation.Horizontal:
				return ref.activeHorizonalScrollBar
			
			case Orientation.Vertical:
				return ref.activeVerticalScrollBar

			default:
				return null
		}
	}

	static function setActiveScrollbar(orientation, scrollBar)
	{
		switch (orientation)
		{
			case Orientation.Horizontal:
				ref.activeHorizonalScrollBar = (scrollBar != null) ? scrollBar.weakref() : null
				break

			case Orientation.Vertical:
				ref.activeVerticalScrollBar = (scrollBar != null) ? scrollBar.weakref() : null
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
		ref.activeScrollBarButton = self.weakref()

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

		ref.activeScrollBarButton = null
	}

	static function onRender()
	{
		if (!ref.activeScrollBarButton)
			return

		local now = getTickCount()

		if (scrollBarNextTick > now)
			return

		scrollBarNextTick = scrollBarNextTick + 100

		if (!ref.activeScrollBarButton.isMouseAt())
			return

		local scrollBar = ref.activeScrollBarButton.parent
		scrollBar.range.setValue(scrollBar.range.getValue() + activeScrollBarButtonDirection * scrollBar.range._step)
	}

	static function onKeyDown(key)
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
			if (!ref.activeHorizonalScrollBar || ref.activeHorizonalScrollBar.getDisabled())
				return

			if (!ref.activeHorizonalScrollBar.keysEnabled)
				return

				ref.activeHorizonalScrollBar.range.setValue(ref.activeHorizonalScrollBar.range.getValue() + ref.activeHorizonalScrollBar.range._step * horizontalKey)
		}
		else if (verticalKey)
		{
			if (!ref.activeVerticalScrollBar || ref.activeVerticalScrollBar.getDisabled())
				return

			if (!ref.activeVerticalScrollBar.keysEnabled)
				return

				ref.activeVerticalScrollBar.range.setValue(ref.activeVerticalScrollBar.range.getValue() + ref.activeVerticalScrollBar.range._step * verticalKey)
		}
	}

	static function onMouseWheel(direction)
	{
		if (!ref.activeVerticalScrollBar || ref.activeVerticalScrollBar.getDisabled())
			return

			ref.activeVerticalScrollBar.range.setValue(ref.activeVerticalScrollBar.range.getValue() - direction * ref.activeVerticalScrollBar.range._step)
	}
}

addEventHandler("onMouseRelease", GUI.ScrollBar.onMouseRelease)
addEventHandler("onRender", GUI.ScrollBar.onRender)
addEventHandler("onKeyDown", GUI.ScrollBar.onKeyDown)
addEventHandler("onMouseWheel", GUI.ScrollBar.onMouseWheel)