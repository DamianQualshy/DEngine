local ref =
{
	movableTab = null
}


local cursorDragOffsetPx = Vec2i()

class GUI.Tab extends GUI.Button
{

#public:
	id = -1
	collection = null

	constructor(id, parent, arg = null)
	{
		this.id = id
		this.parent = parent

		if ("collection" in arg)
		{
			collection = arg.collection
			delete arg.collection
		}

		base.constructor(arg)

		this.bind(EventType.MouseDown, onMouseDown)
	}

	function setVisible(visible)
	{
		base.setVisible(visible)

		if (collection && this == parent._activeTab)
			collection.setVisible(visible)
	}

	function setDisabled(disabled)
	{
		base.setDisabled(disabled)

		if (collection)
			collection.setDisabled(disabled)
	}

	function getPreferredPositionPx()
	{
		local orientation = parent.getOrientation()

		local positionPx = parent.getPositionPx()
		local marginPx = parent.getMarginPx()

		positionPx.x += marginPx.left
		positionPx.y += marginPx.top

		switch (orientation)
		{
			case Orientation.Horizontal:
				positionPx.x += parent._tabSizePx.width * id
				break

			case Orientation.Vertical:
				positionPx.y += parent._tabSizePx.height * id
				break
		}

		return positionPx
	}

	function onMouseDown(self, btn)
	{
		if (btn != MOUSE_BUTTONLEFT)
			return

		local tabPanel = self.parent
		if (!tabPanel.tabsMoveable)
			return

		local positionPx = self.getPositionPx()
		local cursorPositionPx = getCursorPositionPx()

		cursorDragOffsetPx.x = cursorPositionPx.x - positionPx.x
		cursorDragOffsetPx.y = cursorPositionPx.y - positionPx.y

		self.top()

		tabPanel.setActiveTab(self)
		ref.movableTab = self.weakref()
	}

	static function onMouseUp(button)
	{
		if (button != MOUSE_BUTTONLEFT)
			return

		if (!ref.movableTab)
			return

		local preferredPositionPx = ref.movableTab.getPreferredPositionPx()
		ref.movableTab.setPositionPx(preferredPositionPx.x, preferredPositionPx.y)
		ref.movableTab = null
	}

	static function onMouseMove(x, y)
	{
		if (!isMouseBtnPressed(MOUSE_BUTTONLEFT))
			return

		if (!ref.movableTab)
			return

		local cursorPositionPx = getCursorPositionPx()

		local id = ref.movableTab.id
		local positionPx = ref.movableTab.getPositionPx()
		local sizePx = ref.movableTab.getSizePx()

		local tabPanel = ref.movableTab.parent
		local tabsLen = tabPanel.tabs.len()
		
		local tabPanelPositionPx = tabPanel.getPositionPx()
		local tabPanelSizePx = tabPanel.getSizePx()
		local tabPanelMarginPx = tabPanel.getMarginPx()

		switch (tabPanel.getOrientation())
		{
			case Orientation.Horizontal:
				positionPx.x = clamp(
					cursorPositionPx.x - cursorDragOffsetPx.x, 
					tabPanelPositionPx.x + tabPanelMarginPx.left, 
					tabPanelPositionPx.x + tabPanelSizePx.width - sizePx.width - tabPanelMarginPx.right
				)

				local dragDirection = clamp(x, -1, 1)
				local adjacentTabId = id + dragDirection

				if (adjacentTabId >= 0 && adjacentTabId <= tabsLen - 1)
				{
					local adjacentTab = tabPanel.tabs[id + dragDirection]

					local adjacentTabPositionPx = adjacentTab.getPositionPx()
					local adjacentTabSizePx = adjacentTab.getSizePx()

					local overlapPercentage = (dragDirection == -1)
						? (adjacentTabPositionPx.x + adjacentTabSizePx.width - positionPx.x) / adjacentTabSizePx.width.tofloat()
						: (positionPx.x - adjacentTabPositionPx.x + adjacentTabSizePx.width) / adjacentTabSizePx.width.tofloat()

					if (overlapPercentage > 0.5)
					{
						tabPanel.tabs[ref.movableTab.id + dragDirection] = ref.movableTab
						tabPanel.tabs[ref.movableTab.id] = adjacentTab

						adjacentTab.id = ref.movableTab.id
						ref.movableTab.id = adjacentTabId

						adjacentTab.setPositionPx(adjacentTabPositionPx.x + sizePx.width * - dragDirection, adjacentTabPositionPx.y)
					}
				}
				break

			case Orientation.Vertical:
				positionPx.y = clamp(
					cursorPositionPx.y - cursorDragOffsetPx.y, 
					tabPanelPositionPx.y + tabPanelMarginPx.top, 
					tabPanelPositionPx.y + tabPanelSizePx.height - sizePx.height - tabPanelMarginPx.bottom
				)

				local dragDirection = clamp(y, -1, 1)
				local adjacentTabId = id + dragDirection

				if (adjacentTabId >= 0 && adjacentTabId <= tabsLen - 1)
				{
					local adjacentTab = tabPanel.tabs[id + dragDirection]

					local adjacentTabPositionPx = adjacentTab.getPositionPx()
					local adjacentTabSizePx = adjacentTab.getSizePx()

					local overlapPercentage = (dragDirection == -1)
						? (adjacentTabPositionPx.y + adjacentTabSizePx.height - positionPx.y) / adjacentTabSizePx.height.tofloat()
						: (positionPx.y - adjacentTabPositionPx.y + adjacentTabSizePx.height) / adjacentTabSizePx.height.tofloat()

					if (overlapPercentage > 0.5)
					{
						tabPanel.tabs[ref.movableTab.id + dragDirection] = ref.movableTab
						tabPanel.tabs[ref.movableTab.id] = adjacentTab

						adjacentTab.id = ref.movableTab.id
						ref.movableTab.id = adjacentTabId

						adjacentTab.setPositionPx(adjacentTabPositionPx.x, adjacentTabPositionPx.y + sizePx.height * - dragDirection)
					}
				}
				break
		}

		ref.movableTab.setPositionPx(positionPx.x, positionPx.y)
	}
}

addEventHandler("onMouseUp", GUI.Tab.onMouseUp)
addEventHandler("onMouseMove", GUI.Tab.onMouseMove)

local GUITabPanelClasses = classes(GUI.Texture, GUI.Orientation, GUI.Margin)
class GUI.TabPanel extends GUITabPanelClasses
{
#private:
	tabsMoveable = true

	_activeTab = null
	_tabSizePx = null

#public:
	tabs = null

	constructor(arg = null)
	{
		tabs = []

		_tabSizePx = {width = 0, height = 0}
		GUI.Margin.constructor.call(this, arg)
		_orientation = "orientation" in arg ? arg.orientation : Orientation.Horizontal
		GUI.Texture.constructor.call(this, arg)
		updateSize()

		if ("tabs" in arg)
		{
			foreach (tab in arg.tabs)
				addTab(tab)
		}
	}

	function insertTab(idx, arg)
	{
		local tab = GUI.Tab(idx, this, arg)
		tabs.insert(idx, tab)

		local tabsCount = tabs.len()
		for (local i = idx + 1; i < tabsCount; ++i)
			++tabs[i].id

		if (tabsCount == 1)
			setActiveTab(tab)

		updateSize()

		if (visible)
			tab.setVisible(true)

		return tab
	}

	function addTab(arg)
	{
		return insertTab(tabs.len(), arg)
	}

	function removeTab(id)
	{
		local tabsCount = tabs.len()

		for (local i = id; i < tabsCount; ++i)
			--tabs[i].id

		if (_activeTab == tabs[id])
		{
			if (tabsCount == 1)
				setActiveTab(null)
			else if (id + 1 < tabsCount)
				setActiveTab(tabs[id + 1])
			else
				setActiveTab(tabs[id - 1])
		}

		tabs.remove(id)
		updateSize()
	}

	function setMarginPx(top, right, bottom, left)
	{
		GUI.Margin.setMarginPx.call(this, top, right, bottom, left)
		updateSize()
	}

	function getActiveTab()
	{
		return _activeTab
	}

	function setActiveTab(tab)
	{
		if (getVisible())
		{
			if (_activeTab && _activeTab.collection)
				_activeTab.collection.setVisible(false)

			if (tab && getVisible() && tab.collection)
				tab.collection.setVisible(true)
		}

		call(EventType.Switch, tab, _activeTab)
		callEvent("GUI.onSwitch", tab, _activeTab)

		_activeTab = tab
	}

	function setPositionPx(x, y)
	{
		local positionPx = getPositionPx()
		GUI.Texture.setPositionPx.call(this, x, y)

		local offsetXPx = x - positionPx.x
		local offsetYPx = y - positionPx.y
		
		foreach (tab in tabs)
		{
			local tabPositionPx = tab.getPositionPx()
			tab.setPositionPx(tabPositionPx.x + offsetXPx, tabPositionPx.y + offsetYPx)

			if (tab.collection)
			{
				local collectionPositionPx = tab.collection.getPositionPx()
				tab.collection.setPositionPx(collectionPositionPx.x + offsetXPx, collectionPositionPx.y + offsetYPx)
			}
		}
	}

	function setSizePx(width, height)
	{
		GUI.Texture.setSizePx.call(this, width, height)
		updateSize()
	}

	function setVisible(visible)
	{
		GUI.Texture.setVisible.call(this, visible)

		foreach (tab in tabs)
			tab.setVisible(visible)
	}

	function top()
	{
		GUI.Texture.top.call(this)

		foreach (tab in tabs)
			tab.top()
	}

	function updatePosition()
	{
		local positionPx = getPositionPx()
		local marginPx = getMarginPx()

		local x = positionPx.x + marginPx.left
		local y = positionPx.y + marginPx.top

		foreach (tab in tabs)
		{
			tab.setPositionPx(x, y)
			switch (_orientation)
			{
				case Orientation.Horizontal:
					x += _tabSizePx.width
					break

				case Orientation.Vertical:
					y += _tabSizePx.height
					break
			}	
		}
	}

	function updateSize()
	{
		local tabsCount = tabs.len()
		if (!tabsCount)
			return

		local sizePx = getSizePx()
		local marginPx = getMarginPx()

		sizePx.width -= marginPx.left + marginPx.right
		sizePx.height -= marginPx.top + marginPx.bottom

		switch (_orientation)
		{
			case Orientation.Horizontal:
				_tabSizePx.width = sizePx.width / tabsCount
				_tabSizePx.height = sizePx.height
				break

			case Orientation.Vertical:
				_tabSizePx.width = sizePx.width
				_tabSizePx.height = sizePx.height / tabsCount
				break
		}

		foreach (tab in tabs)
			tab.setSizePx(_tabSizePx.width, _tabSizePx.height)

		updatePosition()
	}
}
