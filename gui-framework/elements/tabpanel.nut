local movableTab = null
local cursorOffset = 0

class GUI.Tab extends GUI.Button
{
#private:
	_title = ""

#public:
	id = -1

	constructor(parent, id, file, text)
	{
		this.parent = parent
		this.id = id

		base.constructor(0, 0, 0, 0, file, text)

		_title = text
	}

	function destroy()
	{
		if (this == movableTab)
			movableTab = null

		base.destroy()
	}

	function setText(text)
	{
		if (draw)
			base.setText(text)

		_title = text
	}

	static function onMouseDown(self, btn)
	{
		if (btn != MOUSE_LMB)
			return

		if (!(self instanceof this))
			return

		local panel = self.parent

		if (!panel._tabsMovementEnabled)
			return

		local position = self.getPositionPx()
		local cursorPosition = getCursorPositionPx()

		if (panel._orientation == Orientation.Horizontal)
			cursorOffset = cursorPosition.x - position.x
		else if (panel._orientation == Orientation.Vertical)
			cursorOffset = cursorPosition.y - position.y

		self.top()

		panel.setActiveTab(self.id)
		movableTab = self
	}

	static function onMouseRelease(button)
	{
		if (button != MOUSE_LMB)
			return

		if (!movableTab)
			return

		local panel = movableTab.parent

		local position = panel.getPositionPx()
		local margin = panel.getMarginPx()

		position.x += margin.left
		position.y += margin.top

		for (local i = 0; i < movableTab.id; ++i)
		{
			local size = panel.tabs[i].getSizePx()

			if (panel._orientation == Orientation.Horizontal)
				position.x += size.width
			else if (panel._orientation == Orientation.Vertical)
				position.y += size.height
		}

		movableTab.setPositionPx(position.x, position.y)
		movableTab = null
	}

	static function onMouseMove(x, y)
	{
		if (!isMouseBtnPressed(MOUSE_LMB))
			return

		if (!movableTab)
			return

		local cursorPositionPx = getCursorPositionPx()
		local cursorSensitivity = getCursorSensitivity()

		local newCursorX = cursorPositionPx.x
		local newCursorY = cursorPositionPx.y
		local oldCursorX = cursorPositionPx.x - x * cursorSensitivity
		local oldCursorY = cursorPositionPx.y - y * cursorSensitivity

		local tabPosition = movableTab.getPositionPx()
		local tabSize = movableTab.getSizePx()

		local panel = movableTab.parent
		local tabsCount = panel.tabs.len()

		local dimension, size
		local minimumPanelRange, maximumPanelRange
		local cursorMovingDirection

		// Moving tab, keeping tab in panel range,
		//determinating the cursor movement direction

		if (panel._orientation == Orientation.Horizontal)
		{
			dimension = "x"
			size = "width"

			tabPosition.x = newCursorX - cursorOffset
			minimumPanelRange = maximumPanelRange = panel.getPositionPx().x

			cursorMovingDirection = (newCursorX - oldCursorX) < 0 ? -1 : 1
		}
		else if (panel._orientation == Orientation.Vertical)
		{
			dimension = "y"
			size = "height"

			tabPosition.y = newCursorY -cursorOffset
			minimumPanelRange = maximumPanelRange = panel.getPositionPx().y

			cursorMovingDirection = (newCursorY - oldCursorY) < 0 ? -1 : 1
		}

		for (local i = 0; i < tabsCount - 1; ++i)
			maximumPanelRange += panel.tabs[i].getSizePx()[size]

		if (tabPosition[dimension] < minimumPanelRange)
			tabPosition[dimension] = minimumPanelRange
		else if (tabPosition[dimension] > maximumPanelRange)
			tabPosition[dimension] = maximumPanelRange

		// Checking if tab can be swapped,
		//swapping tab with nearest tab, if our tab is on half way to the nearest tab

		if ((cursorMovingDirection == -1 && movableTab.id > 0)
		|| (cursorMovingDirection == 1 && movableTab.id < tabsCount - 1))
		{
			local nearTab = panel.tabs[movableTab.id + cursorMovingDirection]
			local nearTabPosition = nearTab.getPositionPx()
			local nearTabSize = nearTab.getSizePx()

			if ((cursorMovingDirection == -1 && tabPosition[dimension] < nearTabPosition[dimension] + nearTabSize[size] / 2)
			|| (cursorMovingDirection == 1 && tabPosition[dimension] >= nearTabPosition[dimension] - nearTabSize[size] / 2))
			{
				if (panel._orientation == Orientation.Horizontal)
					nearTab.setPositionPx(nearTabPosition.x + tabSize.width * -cursorMovingDirection, nearTabPosition.y)
				else
					nearTab.setPositionPx(nearTabPosition.x, nearTabPosition.y + tabSize.height * -cursorMovingDirection)

				panel.tabs[movableTab.id + cursorMovingDirection] = movableTab
				panel.tabs[movableTab.id] = nearTab

				nearTab.id -= cursorMovingDirection
				movableTab.id += cursorMovingDirection
			}
		}

		movableTab.setPositionPx(tabPosition.x, tabPosition.y)
	}
}

addEventHandler("GUI.onMouseDown", GUI.Tab.onMouseDown.bindenv(GUI.Tab))
addEventHandler("onMouseRelease", GUI.Tab.onMouseRelease)
addEventHandler("onMouseMove", GUI.Tab.onMouseMove)

local GUITabPanelClasses = classes(GUI.Texture, GUI.Orientation, GUI.Margin)
class GUI.TabPanel extends GUITabPanelClasses
{
#private:
	_tabsMovementEnabled = true

	_font = "FONT_OLD_10_WHITE_HI.TGA"

	_activeTab = null
	_tabSizePx = null

#public:
	tabs = null

	constructor(x, y, width, height, file, orientation = Orientation.Horizontal, window = null)
	{
		tabs = []

		_tabSizePx = {width = 0, height = 0}

		GUI.Margin.constructor.call(this)
		GUI.Orientation.setOrientation.call(this, orientation)
		GUI.Texture.constructor.call(this, x, y, width, height, file, window)
	}

	function destroy()
	{
		_activeTab = null

		foreach (index, _ in tabs)
			tabs[index] = tabs[index].destroy()

		GUI.Texture.destroy.call(this)
	}

	function insertTab(index, file, text)
	{
		local tab = GUI.Tab(this, index, file, text)

		if (tab.draw)
			tab.draw.setFont(_font)

		tabs.insert(index, tab)

		local tabsCount = tabs.len()

		for (local i = index + 1; i < tabsCount; ++i)
			++tabs[i].id

		local size = getSizePx()
		setSizePx(size.width, size.height)

		if (visible)
			tab.setVisible(true)

		return tab
	}

	function addTab(file, text)
	{
		return insertTab(tabs.len(), file, text)
	}

	function removeTab(id)
	{
		local tabsCount = tabs.len()

		if (!tabsCount)
			return

		for (local i = id; i < tabsCount; ++i)
			--tabs[i].id

		if (_activeTab == tabs[id])
		{
			if (tabsCount == 1)
				setActiveTab(null)
			else if (id + 1 < tabsCount)
				setActiveTab(id + 1)
			else
				setActiveTab(id - 1)
		}

		tabs[id] = tabs[id].destroy()
		tabs.remove(id)

		local size = getSizePx()
		setSizePx(size.width, size.height)
	}

	function setMarginPx(top, right, bottom, left)
	{
		GUI.Margin.setMarginPx.call(this, top, right, bottom, left)

		local position = getPositionPx()
		setPositionPx(position.x, position.y)

		local size = getSizePx()
		setSizePx(size.width, size.height)
	}

	function setMargin(top, right, bottom, left)
	{
		setMarginPx(nay(top), nax(right), nay(bottom), nax(left))
	}

	function getActiveTab()
	{
		return _activeTab
	}

	function setActiveTab(id)
	{
		local tab = (id != null) ? tabs[id] : null

		call(EventType.Switch, tab, _activeTab)
		callEvent("GUI.onSwitch", tab, _activeTab)

		_activeTab = tab
	}

	function getTabsMovement()
	{
		return _tabsMovementEnabled
	}

	function setTabsMovement(movement)
	{
		_tabsMovementEnabled = movement
	}

	function setPositionPx(x, y)
	{
		GUI.Texture.setPositionPx.call(this, x, y)

		x += _marginPx.left
		y += _marginPx.top

		foreach (tab in tabs)
		{
			tab.setPositionPx(x, y)

			if (_orientation == Orientation.Horizontal)
				x += _tabSizePx.width
			else if (_orientation == Orientation.Vertical)
				y += _tabSizePx.height
		}
	}

	function setPosition(x, y)
	{
		setPositionPx(nax(x), nay(y))
	}

	function setSizePx(width, height)
	{
		GUI.Texture.setSizePx.call(this, width, height)

		local tabsCount = tabs.len()

		if (!tabsCount)
			return

		width -= _marginPx.left + _marginPx.right
		height -= _marginPx.top + _marginPx.bottom

		if (_orientation == Orientation.Horizontal)
		{
			_tabSizePx.width = width / tabsCount
			_tabSizePx.height = height
		}
		else if (_orientation == Orientation.Vertical)
		{
			_tabSizePx.width = width
			_tabSizePx.height = height / tabsCount
		}

		foreach (tab in tabs)
			tab.setSizePx(_tabSizePx.width, _tabSizePx.height)

		local position = getPositionPx()
		setPositionPx(position.x, position.y)
	}

	function setSize(width, height)
	{
		setSizePx(nax(width), nay(height))
	}

	function setVisible(visible)
	{
		GUI.Texture.setVisible.call(this, visible)

		foreach (tab in tabs)
			tab.setVisible(visible)

		if (visible)
		{
			if (!_activeTab && (0 in tabs))
				setActiveTab(0)
		}
		else
			setActiveTab(null)
	}

	function top()
	{
		GUI.Texture.top.call(this)

		foreach (tab in tabs)
			tab.top()
	}

	function getFont()
	{
		return _font
	}

	function setFont(font)
	{
		_font = font

		foreach (tab in tabs)
		{
			if (tab.draw)
				tab.draw.setFont(_font)
		}
	}
}
