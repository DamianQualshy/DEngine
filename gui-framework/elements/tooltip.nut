local activeToolTip = null
local toolTipInterval = -1

class GUI.ToolTip extends GUI.Button
{
#private:
	_toolTip = null
	_paddingPx = null

#public:
	draw = null

	constructor(width, height, file, text = null)
	{
		_toolTip = {}

		base.constructor(0, 0, width, height, file, text)
		base.setDisabled(true)

		if (text)
		{
			_paddingPx = {x = nax(width) * 2, y = nay(height) * 2}

			local size = draw.getSize()
			setSize(size.width + width, size.height + height)
		}
	}

	function getToolTip(object)
	{
		if (!(object in _toolTip))
			return null

		return _toolTip[object]
	}

	function setToolTip(object, text)
	{
		object.toolTip = this
		_toolTip[object] <- text
	}

	function getPaddingPx()
	{
		return _paddingPx
	}

	function setPaddingPx(x, y)
	{
		_paddingPx.x = x
		_paddingPx.y = y

		local drawSize = draw.getSizePx()
		setSizePx(drawSize.width + _paddingPx.x * 2, drawSize.height + _paddingPx.y * 2)
	}

	function getPadding()
	{
		return {x = anx(_paddingPx.x), y = any(_paddingPx.y)}
	}

	function setPadding(x, y)
	{
		setPaddingPx(nax(x), nay(y))
	}

	function setText(text)
	{
		base.setText(text)
		setPaddingPx(_paddingPx.x, _paddingPx.y)
	}

	static function onMouseIn(self)
	{
		if (!self.toolTip)
			return

		activeToolTip = self.toolTip

		local toolTip = activeToolTip.getToolTip(self)

		if (toolTip)
			activeToolTip.setText(toolTip)

		toolTipInterval = 0
	}

	static function onMouseOut(self)
	{
		if (!self.toolTip)
			return

		activeToolTip = null
	}

	static function onRender()
	{
		if (!activeToolTip)
			return

		if (toolTipInterval >= TOOLTIP_INTERVAL)
			return

		toolTipInterval += getFrameTime()

		if (toolTipInterval >= TOOLTIP_INTERVAL)
		{
			local cursorPosition = getCursorPositionPx()

			activeToolTip.setPositionPx(cursorPosition.x, cursorPosition.y + 15)
			activeToolTip.top()
			activeToolTip.setVisible(true)
		}
	}

	static function onMouseMove(x, y)
	{
		if (!activeToolTip)
			return

		activeToolTip.setVisible(false)
		toolTipInterval = 0
	}
}

addEventHandler("GUI.onMouseIn", GUI.ToolTip.onMouseIn)
addEventHandler("GUI.onMouseOut", GUI.ToolTip.onMouseOut)
addEventHandler("onRender", GUI.ToolTip.onRender)
addEventHandler("onMouseMove", GUI.ToolTip.onMouseMove)
