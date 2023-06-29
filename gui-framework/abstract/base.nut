local getroottable = getroottable

local elementPointedByCursor = null
local focusedElement = null
local lastClickedElement = null
local doubleClickTimestamp = null

class GUI.Base
{
	static _objects = []

#protected:
	_id = -1

	_visible = false
	_isDisabled = false
	_events = null

#public:
	toolTip = null
	parent = null

	constructor()
	{
		_events = array(EventType.Max)
	}

	function bind(event_type, callback) {
		local events = _events[event_type] || []
		if (events.len() == 0) {
			_events[event_type] = events
		}

		events.push(callback)
	}

	function unbind(event_type, callback) {
		if (!(event_type in _events))
			return

		local events = _events[event_type]
		local idx = events.find(callback)

		if (idx != null)
			events.remove(idx)
	}

	function call(event_type, ...) {
		local events = _events[event_type]
		if (events == null) return

		// Context + This GUI element
		vargv.insert(0, getroottable())
		vargv.insert(1, this)

		foreach (callback in events) {
			callback.acall(vargv)
		}
	}

	function destroy()
	{
		if (elementPointedByCursor == this)
			elementPointedByCursor = null

		if (focusedElement == this)
			focusedElement = null

		if (toolTip)
		{
			if (toolTip.getToolTip(this))
				delete toolTip._toolTip[this]

			toolTip = null
		}

		removeFromArray()
	}

	function addToArray()
	{
		_id = _objects.len()
		_objects.push(this)
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
		if (!_visible)
			return

		removeFromArray()
		addToArray()
	}

	function getVisible()
	{
		return _visible
	}

	function setVisible(visible)
	{
		if (_visible == visible)
			return

		_visible = visible

		if (!visible)
		{
			if (this == elementPointedByCursor)
				setElementPointedByCursor(null)
		
			if (this == focusedElement)
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

	function setPosition(x, y)
	{
		setElementPointedByCursor(findElementPointedByCursor())
	}

	function setSizePx(width, height)
	{
		setElementPointedByCursor(findElementPointedByCursor())
	}

	function setSize(width, height)
	{
		setElementPointedByCursor(findElementPointedByCursor())
	}

	function getDisabled()
	{
		return _isDisabled
	}

	function setDisabled(disabled)
	{
		if (disabled && isFocused())
			setFocusedElement(null)

		_isDisabled = disabled
	}

	function checkIsMouseAt()
	{
		if (!_visible)
			return false

		if (_isDisabled)
			return false
	
		local texPosition = getPositionPx()
		local texSize = getSizePx()

		local cursorPosition = getCursorPositionPx()

		if (cursorPosition.x >= texPosition.x && cursorPosition.x <= texPosition.x + texSize.width
		&& cursorPosition.y >= texPosition.y && cursorPosition.y <= texPosition.y + texSize.height)
			return true

		return false
	}

	function isMouseAt()
	{
		return elementPointedByCursor == this
	}

	function isFocused()
	{
		return focusedElement == this
	}

	static function findElementPointedByCursor()
	{
		for (local i = _objects.len() - 1; i >= 0; --i)
		{
			local object = _objects[i]

			if (object.checkIsMouseAt())
				return object
		}
		
		return null
	}

	static function getElementPointedByCursor()
	{
		return elementPointedByCursor
	}
	
	static function setElementPointedByCursor(newElementPointedByCursor)
	{
		if (newElementPointedByCursor == elementPointedByCursor)
			return
	
		if (elementPointedByCursor)
		{
			elementPointedByCursor.call(EventType.MouseOut)
			callEvent("GUI.onMouseOut", elementPointedByCursor)
		}
			
		elementPointedByCursor = newElementPointedByCursor
			
		if (newElementPointedByCursor)
		{
			newElementPointedByCursor.call(EventType.MouseIn)
			callEvent("GUI.onMouseIn", newElementPointedByCursor)
		}
}

	static function getFocusedElement()
	{
		return focusedElement
	}
	
	static function setFocusedElement(newFocusedElement)
	{
		if (newFocusedElement == focusedElement)
			return
	
		if (focusedElement)
		{
			focusedElement.call(EventType.LostFocus)
			callEvent("GUI.onLostFocus", focusedElement)
		}
			
		focusedElement = newFocusedElement
			
		if (newFocusedElement)
		{
			newFocusedElement.call(EventType.TakeFocus)
			callEvent("GUI.onTakeFocus", newFocusedElement)
		}
	}

	static function onRender()
	{
		local cursorPosition = getCursorPositionPx()
		local deltaTime = getFrameTime()

		foreach (object in _objects)
		{
			if (!object.getVisible())
				continue

			object.call(EventType.Render)
			callEvent("GUI.onRender", object)
		}
	}

	static function onMouseMove(x, y)
	{
		if (!isCursorVisible())
			return

		setElementPointedByCursor(findElementPointedByCursor())
		
		if (elementPointedByCursor)
		{
			local cursorPositionPx = getCursorPositionPx()
			local cursorSensitivity = getCursorSensitivity()
	
			local newCursorX = cursorPositionPx.x
			local newCursorY = cursorPositionPx.y
			local oldCursorX = cursorPositionPx.x - x * cursorSensitivity
			local oldCursorY = cursorPositionPx.y - y * cursorSensitivity

			elementPointedByCursor.call(EventType.MouseMove, newCursorX, newCursorY, oldCursorX, oldCursorY)
			callEvent("GUI.onMouseMove", elementPointedByCursor, newCursorX, newCursorY, oldCursorX, oldCursorY)
		}
	}

	static function onMouseClick(button)
	{
		if (!isCursorVisible())
			return

		setFocusedElement(elementPointedByCursor)

		if (!elementPointedByCursor)
			return

		elementPointedByCursor.call(EventType.MouseDown, button)
		callEvent("GUI.onMouseDown", elementPointedByCursor, button)
	}

	static function onMouseRelease(button)
	{
		if (!isCursorVisible())
			return

		if (!focusedElement)
			return

		focusedElement.call(EventType.MouseUp, button)
		callEvent("GUI.onMouseUp", focusedElement, button)

		if (button == MOUSE_LMB)
		{
			focusedElement.call(EventType.Click)
			callEvent("GUI.onClick", focusedElement)

			local now = getTickCount()
			if (lastClickedElement == focusedElement && now <= doubleClickTimestamp)
			{
				lastClickedElement = null
				doubleClickTimestamp = null

				focusedElement.call(EventType.DoubleClick)				
				callEvent("GUI.onDoubleClick", focusedElement)
			}
			else
			{
				lastClickedElement = focusedElement
				doubleClickTimestamp = now + DOUBLE_CLICK_TIME
			}	
		}
	}

	static function onCursorShow()
	{
		setElementPointedByCursor(findElementPointedByCursor())
	}

	static function onCursorHide()
	{
		if (focusedElement)
		{
			for (local i = MOUSE_LMB; i <= MOUSE_MMB; ++i)
			{
				if (!isMouseBtnPressed(i))
					continue

				focusedElement.call(EventType.MouseUp, i)
				callEvent("GUI.onMouseUp", focusedElement, i)
			}
		}
		
		setElementPointedByCursor(null)
	}
}

addEventHandler("onRender", GUI.Base.onRender.bindenv(GUI.Base))
addEventHandler("onMouseMove", GUI.Base.onMouseMove.bindenv(GUI.Base))
addEventHandler("onMouseClick", GUI.Base.onMouseClick.bindenv(GUI.Base))
addEventHandler("onMouseRelease", GUI.Base.onMouseRelease.bindenv(GUI.Base))

local _setCursorVisible = setCursorVisible
function setCursorVisible(toggle)
{
	if (toggle != isCursorVisible())
	{
		if (toggle)
			GUI.Base.onCursorShow()
		else
			GUI.Base.onCursorHide()
	}

	_setCursorVisible(toggle)
}
