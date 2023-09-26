local ref =
{
	activeWindow = null
}

local GUIWindowClasses = classes(GUI.Texture, GUI.Collection)
class GUI.Window extends GUIWindowClasses
{
	static _cursorOffset = {x = 0, y = 0}
	movable = true

	constructor(arg = null)
	{
		GUI.Collection.constructor.call(this, arg)
		GUI.Texture.constructor.call(this, arg)

		movable = "movable" in arg ? arg.movable : movable
	}

	function isMouseAt()
	{
		foreach(child in childs)
		{
			if (child.isMouseAt())
				return false
		}

		return GUI.Texture.isMouseAt.call(this)
	}

	function top()
	{
		GUI.Texture.top.call(this)
		GUI.Collection.top.call(this)
	}

	function setVisible(visible, affectChilds = true)
	{
		GUI.Texture.setVisible.call(this, visible)

		if (affectChilds)
			GUI.Collection.setVisible.call(this, visible)
	}

	function setPosition(x, y)
	{
		setPositionPx(nax(x), nay(y))
	}

	function setPositionPx(x, y)
	{
		GUI.Texture.setPositionPx.call(this, x, y)
		GUI.Collection.setPositionPx.call(this, x, y)
	}

	function setColor(r, g, b, affectChilds = true)
	{
		GUI.Texture.setColor.call(this, r, g, b)

		if (affectChilds)
		{
			foreach(child in childs)
				child.setColor(r, g, b)
		}
	}

	function setAlpha(alpha, affectChilds = true)
	{
		GUI.Texture.setAlpha.call(this, alpha)

		if (affectChilds)
		{
			foreach(child in childs)
				child.setAlpha(alpha)
		}
	}

	function setDisabled(disabled, affectChilds = true)
	{
		GUI.Texture.setDisabled.call(this, disabled)

		if (affectChilds)
		{
			foreach(child in childs)
				child.setDisabled(disabled)
		}
	}

	static function getActiveWindow()
	{
		return ref.activeWindow
	}

	static function setActiveWindow(window)
	{
		ref.activeWindow = (window != null) ? window.weakref() : null
	}

	static function getCursorOffset()
	{
		return _cursorOffset
	}

	static function setCursorOffset(x, y)
	{
		_cursorOffset.x = x
		_cursorOffset.y = y
	}

	static function onMouseMove(x, y)
	{
		if (!ref.activeWindow)
			return

		local cursorPositionPx = getCursorPositionPx()
		ref.activeWindow.setPositionPx(cursorPositionPx.x + ref.activeWindow._cursorOffset.x, cursorPositionPx.y + ref.activeWindow._cursorOffset.y)
	}

	static function onMouseDown(self, button)
	{
		if (button != MOUSE_LMB)
			return

		if (!(self instanceof this))
			return

		if (!self.movable)
			return

		local cursorPositionPx = getCursorPositionPx()
		local position = self.getPositionPx()

		self._cursorOffset.x = position.x - cursorPositionPx.x
		self._cursorOffset.y = position.y - cursorPositionPx.y

		ref.activeWindow = self.weakref()
	}

	static function onMouseUp(self, button)
	{
		if (button != MOUSE_LMB)
			return

		if (!ref.activeWindow)
			return

		ref.activeWindow = null
	}
}

addEventHandler("onMouseMove", GUI.Window.onMouseMove.bindenv(GUI.Window))
addEventHandler("GUI.onMouseDown", GUI.Window.onMouseDown.bindenv(GUI.Window))
addEventHandler("GUI.onMouseUp", GUI.Window.onMouseUp)