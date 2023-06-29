local activeWindow = null

local GUIWindowClasses = classes(GUI.Texture, GUI.Collection)
class GUI.Window extends GUIWindowClasses
{
	static _cursorOffset = {x = 0, y = 0}

#public:
	constructor(x, y, w, h, texture, textureAlign = null, enabled = false)
	{
		GUI.Collection.constructor.call(this, x, y)
		GUI.Texture.constructor.call(this, x, y, w, h, texture)

		if (!enabled)
			setDisabled(true)
	}

	function destroy()
	{
		GUI.Texture.destroy.call(this)
		GUI.Collection.destroy.call(this)
	}

	function isMouseAt()
	{
		foreach(item in childs)
		{
			if (item.pointer.isMouseAt())
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

	function setColor(r, g, b, affectChilds = false)
	{
		GUI.Texture.setColor.call(this, r, g, b)

		if (affectChilds)
		{
			foreach(item in childs)
				item.pointer.setColor(r, g, b)
		}
	}

	function setAlpha(alpha, affectChilds = false)
	{
		GUI.Texture.setAlpha.call(this, alpha)

		if (affectChilds)
		{
			foreach(item in childs)
				item.pointer.setAlpha(alpha)
		}
	}

	static function getActiveWindow()
	{
		return activeWindow
	}

	static function setActiveWindow(window)
	{
		activeWindow = window
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
		if (!activeWindow)
			return

		local cursorPosition = getCursorPositionPx()
		activeWindow.setPositionPx(cursorPosition.x + activeWindow._cursorOffset.x, cursorPosition.y + activeWindow._cursorOffset.y)
	}

	static function onMouseDown(self, button)
	{
		if (button != MOUSE_LMB)
			return

		if (!(self instanceof this))
			return

		local cursorPosition = getCursorPositionPx()
		local position = self.getPositionPx()

		self._cursorOffset.x = position.x - cursorPosition.x
		self._cursorOffset.y = position.y - cursorPosition.y

		activeWindow = self
	}

	static function onMouseUp(self, button)
	{
		if (button != MOUSE_LMB)
			return

		if (!activeWindow)
			return

		activeWindow = null
	}
}

addEventHandler("onMouseMove", GUI.Window.onMouseMove.bindenv(GUI.Window))
addEventHandler("GUI.onMouseDown", GUI.Window.onMouseDown.bindenv(GUI.Window))
addEventHandler("GUI.onMouseUp", GUI.Window.onMouseUp)
