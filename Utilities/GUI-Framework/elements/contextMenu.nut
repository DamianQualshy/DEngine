local ref = {
	activeContextMenu = null
}

class GUI.ContextMenu extends GUI.List
{
	_activeParent = null

	function setVisible(visible)
	{
		base.setVisible(visible)
		
		if (!visible && ref.activeContextMenu == this)
			ref.activeContextMenu = null
	}

	function getActiveParent()
	{
		return _activeParent
	}  

	static function row_onClick(self) {
		self.parent.setVisible(false)
	}

	static function onMouseDown(button)
	{
		if (!isCursorVisible())
			return

		if (!ref.activeContextMenu)
			return

		local elementPointedByCursor = GUI.Event.getElementPointedByCursor()
		if (elementPointedByCursor)
		{
			// Clicked at lists texture.
			if (elementPointedByCursor == ref.activeContextMenu)
				return

			// Clicked at lists row.
			if (elementPointedByCursor.parent && elementPointedByCursor.parent == ref.activeContextMenu)
				return
		}

		ref.activeContextMenu.setVisible(false)
	}

	static function onMouseUp(btn)
	{
		if (btn != MOUSE_BUTTONRIGHT)
			return

		local self = GUI.Event.getElementPointedByCursor()
		if (!self)
			return

		local contextMenu = self.contextMenu
		if (!contextMenu)
			return

		if (ref.activeContextMenu && ref.activeContextMenu != contextMenu)
			ref.activeContextMenu.setVisible(false)

		ref.activeContextMenu = contextMenu.weakref()
		contextMenu._activeParent = self.weakref()

		local cursorPos = getCursorPositionPx()
		local res = getResolution()
		local size = contextMenu.getSizePx()

		local pos = {x = cursorPos.x, y = cursorPos.y}
		if (pos.x + size.width > res.x)
			pos.x -= size.width
		
		if (pos.y + size.height > res.y)
			pos.y -= size.height		

		contextMenu.setPositionPx(pos.x, pos.y)
		contextMenu.setVisible(true)
	}

	function _createVisibleRow(id)
	{
		local row = base._createVisibleRow(id)
		row.bind(EventType.Click, row_onClick)

		return row
	}
}

addEventHandler("onMouseDown", GUI.ContextMenu.onMouseDown)
addEventHandler("onMouseUp", GUI.ContextMenu.onMouseUp)