local getroottable = getroottable

local ref =
{
	pointedByCursor = null,
	focused = null,
	lastClicked = null
}

local doubleClickTimestamp = null
local currentEventType = -1

class GUI.Event
{
	static _objects = []

#protected:
	_id = -1
	_events = null
	
#public:
	toolTip = null

	constructor(arg = null)
	{
		_events = array(EventType.Max)
		toolTip = "toolTip" in arg ? arg.toolTip : toolTip
	}

	function addToArray()
	{
		_id = _objects.len()
		_objects.push(this.weakref())
	}

	function removeFromArray()
	{
		if (_id == -1)
			return

		for (local i = _objects.len() - 1; i > _id; --i)
			--_objects[i]._id

		_objects.remove(_id)
		_id = -1
	}

	function top()
	{
		if (!getVisible())
			return

		removeFromArray()
		addToArray()
	}

	function bind(event_type, callback, priority = 9999)
	{
		local event = _events[event_type] || {handlers = [], cancelled = false}
		_events[event_type] = event

		event.handlers.push({callback = callback, priority = priority, index = event.handlers.len(), cancelled = false})
		event.handlers.sort(function(a, b)
		{
			if (a.priority == b.priority)
				return a.index <=> b.index

			return a.priority <=> b.priority
		})
	}

	function unbind(event_type, callback)
	{
		local event = _events[event_type]
		if (event == null)
			return

		local idx = null

		foreach (handler in event.handlers)
		{
			if (handler.callback == callback)
			{
				idx = i
				break
			}
		}

		if (idx != null)
			event.handlers.remove(idx)
	}

	function call(event_type, ...)
	{
		local event = _events[event_type]
		if (event == null)
			return

		vargv.insert(0, getroottable())
		vargv.insert(1, this)

		currentEventType = event_type

		foreach (handler in event.handlers)
			handler.callback.acall(vargv)

		event.cancelled = false
		currentEventType = -1
	}

	function cancel()
	{
		if (currentEventType == -1)
			return

		_events[currentEventType].cancelled = true
	}

	function isCancelled()
	{
		if (currentEventType == -1)
			return false

		return _events[currentEventType].cancelled
	}

	function setVisible(visible)
	{
		if (getVisible() == visible)
			return

		if (!visible)
		{
			if (this == ref.pointedByCursor)
				setElementPointedByCursor(null)
		
			if (this == ref.focused)
				setFocusedElement(null)

			removeFromArray()
		}
		else
		{
			addToArray()

			if (isCursorVisible() && checkIsMouseAt())
				setElementPointedByCursor(this)
		}
	}

	function setPositionPx(x, y)
	{
		setElementPointedByCursor(findElementPointedByCursor())
	}

	function setSizePx(width, height)
	{
		setElementPointedByCursor(findElementPointedByCursor())
	}

	function setDisabled(disabled)
	{
		if (disabled && isFocused())
			setFocusedElement(null)
	}

	function checkIsMouseAt()
	{
		if (!getVisible())
			return false

		if (getDisabled())
			return false
	
		local positionPx = getPositionPx()
		local sizePx = getSizePx()

		local cursorPositionPx = getCursorPositionPx()

		if (cursorPositionPx.x >= positionPx.x && cursorPositionPx.x <= positionPx.x + sizePx.width
		&& cursorPositionPx.y >= positionPx.y && cursorPositionPx.y <= positionPx.y + sizePx.height)
			return true

		return false
	}

	function isMouseAt()
	{
		return ref.pointedByCursor == this
	}

	function isFocused()
	{
		return ref.focused == this
	}

	static function findElementPointedByCursor()
	{
		for (local i = _objects.len() - 1; i >= 0; --i)
		{
			local object = _objects[i]

			if (object == null)
				continue

			if (object.checkIsMouseAt())
				return object
		}
		
		return null
	}

	static function getElementPointedByCursor()
	{
		return ref.pointedByCursor
	}
	
	static function setElementPointedByCursor(newElementPointedByCursor)
	{
		if (newElementPointedByCursor == ref.pointedByCursor)
			return
	
		if (ref.pointedByCursor)
		{
			ref.pointedByCursor.call(EventType.MouseOut)
			callEvent("GUI.onMouseOut", ref.pointedByCursor)
		}
			
		ref.pointedByCursor = (newElementPointedByCursor != null) ? newElementPointedByCursor.weakref() : null
			
		if (newElementPointedByCursor)
		{
			newElementPointedByCursor.call(EventType.MouseIn)
			callEvent("GUI.onMouseIn", newElementPointedByCursor)
		}
	}

	static function getFocusedElement()
	{
		return ref.focused
	}
	
	static function setFocusedElement(newFocusedElement)
	{
		if (newFocusedElement == ref.focused)
			return
	
		if (ref.focused)
		{
			ref.focused.call(EventType.LostFocus)
			callEvent("GUI.onLostFocus", ref.focused)
		}
			
		ref.focused = (newFocusedElement != null) ? newFocusedElement.weakref() : null
			
		if (newFocusedElement)
		{
			newFocusedElement.call(EventType.TakeFocus)
			callEvent("GUI.onTakeFocus", newFocusedElement)
		}
	}

	static function onRender()
	{
		local deletedObjectIndicies = []

		foreach (index, object in _objects)
		{
			if (object == null)
			{
				deletedObjectIndicies.push(index)
				continue
			}

			if (!object.getVisible())
				continue

			object.call(EventType.Render)
			callEvent("GUI.onRender", object)
		}

		for (local i = deletedObjectIndicies.len() - 1; i >= 0; --i)
			_objects.remove(deletedObjectIndicies[i])
	}

	static function onMouseMove(x, y)
	{
		if (!isCursorVisible())
			return

		setElementPointedByCursor(findElementPointedByCursor())
		
		if (ref.pointedByCursor)
		{
			local cursorPositionPx = getCursorPositionPx()
			local cursorSensitivity = getCursorSensitivity()
	
			local newCursorX = cursorPositionPx.x
			local newCursorY = cursorPositionPx.y
			local oldCursorX = cursorPositionPx.x - x * cursorSensitivity
			local oldCursorY = cursorPositionPx.y - y * cursorSensitivity

			ref.pointedByCursor.call(EventType.MouseMove, newCursorX, newCursorY, oldCursorX, oldCursorY)
			callEvent("GUI.onMouseMove", ref.pointedByCursor, newCursorX, newCursorY, oldCursorX, oldCursorY)
		}
	}

	static function onMouseClick(button)
	{
		if (!isCursorVisible())
			return

		setFocusedElement(ref.pointedByCursor)

		if (!ref.pointedByCursor)
			return

		ref.pointedByCursor.call(EventType.MouseDown, button)
		callEvent("GUI.onMouseDown", ref.pointedByCursor, button)
	}

	static function onMouseRelease(button)
	{
		if (!isCursorVisible())
			return

		if (!ref.focused)
			return

		ref.focused.call(EventType.MouseUp, button)
		callEvent("GUI.onMouseUp", ref.focused, button)

		if (button == MOUSE_LMB)
		{
			ref.focused.call(EventType.Click)
			callEvent("GUI.onClick", ref.focused)

			local now = getTickCount()
			if (ref.lastClicked == ref.focused && now <= doubleClickTimestamp)
			{
				ref.lastClicked = null
				doubleClickTimestamp = null

				ref.focused.call(EventType.DoubleClick)				
				callEvent("GUI.onDoubleClick", ref.focused)
			}
			else
			{
				ref.lastClicked = (ref.focused != null) ? ref.focused.weakref() : null
				doubleClickTimestamp = (ref.focused != null) ? now + DOUBLE_CLICK_TIME : null
			}	
		}
	}

	static function onCursorShow()
	{
		setElementPointedByCursor(findElementPointedByCursor())
	}

	static function onCursorHide()
	{
		if (ref.focused)
		{
			for (local i = MOUSE_LMB; i <= MOUSE_MMB; ++i)
			{
				if (!isMouseBtnPressed(i))
					continue

				ref.focused.call(EventType.MouseUp, i)
				callEvent("GUI.onMouseUp", ref.focused, i)
			}
		}
		
		setElementPointedByCursor(null)
	}
}

addEventHandler("onRender", GUI.Event.onRender.bindenv(GUI.Event))
addEventHandler("onMouseMove", GUI.Event.onMouseMove.bindenv(GUI.Event))
addEventHandler("onMouseClick", GUI.Event.onMouseClick.bindenv(GUI.Event))
addEventHandler("onMouseRelease", GUI.Event.onMouseRelease.bindenv(GUI.Event))

local _setCursorVisible = setCursorVisible
function setCursorVisible(toggle)
{
	if (toggle != isCursorVisible())
	{
		if (toggle)
			GUI.Event.onCursorShow()
		else
			GUI.Event.onCursorHide()
	}

	_setCursorVisible(toggle)
}