local ref =
{
	activeToolTip = null
}

local toolTipInterval = -1
class GUI.ToolTip extends GUI.Button
{
#public:
	tips = null
	
	constructor(arg = null)
	{
		GUI.Button.constructor.call(this, arg)
		tips = {}

		if ("tips" in arg)
		{
			foreach (tip in arg.tips)
				addTip(tip.object, tip.text)
		}
	}

	function getTip(object)
	{
		if (!(object in tips))
			return null

		return tips[object]
	}

	function addTip(object, text)
	{
		object.toolTip = this
		tips[object] <- text

		object.bind(EventType.MouseIn, onMouseIn)
		object.bind(EventType.MouseOut, onMouseOut)
	}

	function removeTip(object, text)
	{
		object.toolTip = null
		delete tips[object]

		object.unbind(EventType.MouseIn, onMouseIn)
		object.unbind(EventType.MouseOut, onMouseOut)
	}

	function onMouseIn(self)
	{
		if (!self.toolTip)
			return

		ref.activeToolTip = self.toolTip.weakref()

		local tip = ref.activeToolTip.getTip(self)
		if (!tip)
			return
		
		ref.activeToolTip.setText(tip)
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
			local resolution = getResolution()
			
			local sizePx = ref.activeToolTip.getSizePx()
			if (sizePx.width == 0 && sizePx.height == 0)
				sizePx = ref.activeToolTip.draw.getSizePx()

			local cursorPositionPx = getCursorPositionPx()
			local cursorSizePx = getCursorSizePx()

			ref.activeToolTip.setPositionPx(
				clamp(cursorPositionPx.x, 0, resolution.x - sizePx.width),
				clamp(cursorPositionPx.y + cursorSizePx.height, 0, resolution.y - sizePx.height - cursorSizePx.height)
			)

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