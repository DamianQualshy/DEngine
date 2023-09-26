local ref =
{
	activeToolTip = null
}

local toolTipInterval = -1

class GUI.ToolTip extends GUI.Button
{
#public:
	cursorOffset = null

#private:
	_toolTip = null
	
	constructor(arg = null)
	{
		GUI.Button.constructor.call(this, arg)
		_toolTip = {}

		if ("cursorOffsetPx" in arg)
			cursorOffset = GUI.Offset({offsetPx = arg.cursorOffsetPx})
		else if ("cursorOffset" in arg)
			cursorOffset = GUI.Offset({offset = arg.cursorOffset})
		else
			cursorOffset = GUI.Offset(null)
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

		object.bind(EventType.MouseIn, onMouseIn)
		object.bind(EventType.MouseOut, onMouseOut)
	}

	function onMouseIn(self)
	{
		if (!self.toolTip)
			return

		ref.activeToolTip = self.toolTip.weakref()

		local toolTip = ref.activeToolTip.getToolTip(self)

		if (toolTip)
			ref.activeToolTip.setText(toolTip)

		toolTipInterval = 0
	}

	function onMouseOut(self)
	{
		if (!self.toolTip)
			return

		ref.activeToolTip = null
	}

	static function onRender()
	{
		if (!ref.activeToolTip)
			return

		if (toolTipInterval >= TOOLTIP_INTERVAL)
			return

		toolTipInterval += getFrameTime()

		if (toolTipInterval >= TOOLTIP_INTERVAL)
		{
			local cursorPositionPx = getCursorPositionPx()
			local cursorOffsetPx = ref.activeToolTip.cursorOffset.getOffsetPx()

			ref.activeToolTip.setPositionPx(cursorPositionPx.x + cursorOffsetPx.x, cursorPositionPx.y + cursorOffsetPx.y)
			ref.activeToolTip.top()
			ref.activeToolTip.setVisible(true)
		}
	}

	static function onMouseMove(x, y)
	{
		if (!ref.activeToolTip)
			return

		ref.activeToolTip.setVisible(false)
		toolTipInterval = 0
	}
}

addEventHandler("GUI.onMouseIn", GUI.ToolTip.onMouseIn)
addEventHandler("GUI.onMouseOut", GUI.ToolTip.onMouseOut)
addEventHandler("onRender", GUI.ToolTip.onRender)
addEventHandler("onMouseMove", GUI.ToolTip.onMouseMove)