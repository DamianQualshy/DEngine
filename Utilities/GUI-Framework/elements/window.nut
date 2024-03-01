local ref =
{
	activeWindow = null
}

class GUI.TopBar extends GUI.Base
{
#public:
    dragButton = null
    minimizeButton = null
    closeButton = null

    constructor(arg)
    {
		if (arg)
		{
			if (!("align" in arg))
				arg.align <- Align.Left
		}

        dragButton = GUI.Button(arg)
        dragButton.parent = this
		dragButton.bind(EventType.MouseDown, dragButton_onMouseDown)

        if ("minimizeButton" in arg)
        {
            minimizeButton = GUI.Button(arg.minimizeButton)
            minimizeButton.parent = this
			minimizeButton.bind(EventType.Click, minimizeButton_onClick)
        }

        if ("closeButton" in arg)
        {
            closeButton = GUI.Button(arg.closeButton)
            closeButton.parent = this
			closeButton.bind(EventType.Click, closeButton_onClick)
        }

        base.constructor(arg)
		updateButtonsPosition()
    }

    function setVisible(visible)
    {
        dragButton.setVisible(visible)

        if (minimizeButton)
            minimizeButton.setVisible(visible)

        if (closeButton)
            closeButton.setVisible(visible)

        base.setVisible(visible)
    }

    function setDisabled(disabled)
	{
        dragButton.setDisabled(disabled)

        if (minimizeButton)
            minimizeButton.setDisabled(disabled)

        if (closeButton)
            closeButton.setDisabled(disabled)

		base.setDisabled(disabled)
	}

    function getColor()
    {
        return dragButton.getColor()
    }

    function setColor(color)
    {
        dragButton.setColor(color)
        minimizeButton.setColor(color)
        closeButton.setColor(color)
    }

    function top()
	{
        dragButton.top()

        if(minimizeButton)
            minimizeButton.top()

        if (closeButton)
            closeButton.top()
    }

	function updateButtonsPosition()
	{
		local dragButtonPositionPx = dragButton.getPositionPx()
        local buttonPxX = dragButtonPositionPx.x + dragButton.getSizePx().width

        if (closeButton)
        {
            buttonPxX -= closeButton.getSizePx().width
            closeButton.setPositionPx(buttonPxX, dragButtonPositionPx.y)
        }

        if (minimizeButton)
        {
            buttonPxX -= minimizeButton.getSizePx().width
            minimizeButton.setPositionPx(buttonPxX, dragButtonPositionPx.y)
        }
	}

    function getPositionPx()
    {
        return dragButton.getPositionPx()
    }

    function setPositionPx(x, y)
    {
        dragButton.setPositionPx(x, y)
        updateButtonsPosition()
    }

    function getSizePx()
    {
        return dragButton.getSizePx()
    }

    function setSizePx(width, height)
    {
        dragButton.setSizePx(width, height)
        updateButtonsPosition()
    }

	function dragButton_onMouseDown(self, button)
	{
		if (button != MOUSE_BUTTONLEFT)
			return

		local topBar = self.parent
		local window = topBar.parent

		ref.activeWindow = window.weakref()
		GUI.Event.setSearchElementPointedByCursor(false)
	}

	function minimizeButton_onClick(self)
	{
		local topBar = self.parent
		local window = topBar.parent

		local toggle = !window.getVisible()
		window.setVisible(toggle, false)

		if (toggle)
			topBar.top()
	}

	function closeButton_onClick(self)
	{
		local topBar = self.parent
		local window = topBar.parent

		window.setVisible(false)
	}

	static function onMouseUp(self, button)
	{
		if (button != MOUSE_BUTTONLEFT)
			return

		if (!ref.activeWindow)
			return

		ref.activeWindow = null
		GUI.Event.setSearchElementPointedByCursor(true)
	}

	static function onMouseMove(x, y)
	{
		if (!ref.activeWindow)
			return

		local windowPositionPx = ref.activeWindow.getPositionPx()
		ref.activeWindow.setPositionPx(windowPositionPx.x + x, windowPositionPx.y + y)
	}
}

addEventHandler("GUI.onMouseUp", GUI.TopBar.onMouseUp)
addEventHandler("onMouseMove", GUI.TopBar.onMouseMove.bindenv(GUI.TopBar))

local GUIWindowClasses = classes(GUI.Texture, GUI.Collection)
class GUI.Window extends GUIWindowClasses
{
#public
	topBar = null

	constructor(arg = null)
	{
		if ("topBar" in arg)
		{
			if (!("size" in arg.topBar) && "size" in arg)
				arg.topBar.size <- {}
			else if (!("sizePx" in arg.topBar) && "sizePx" in arg)
				arg.topBar.sizePx <- {}

			if ("size" in arg.topBar)
				arg.topBar.size.width <- arg.size.width
			else if ("sizePx" in arg.topBar)
				arg.topBar.sizePx.width <- arg.sizePx.width

			if ("size" in arg.topBar && !("height" in arg.topBar.size))
				arg.topBar.size.height <- any(WINDOW_TOPBAR_HEIGHT)
			else if ("sizePx" in arg.topBar && !("height" in arg.topBar.sizePx))
				arg.topBar.sizePx.height <- WINDOW_TOPBAR_HEIGHT

			if ("position" in arg)
				arg.topBar.position <- arg.position
			else if ("positionPx" in arg)
				arg.topBar.positionPx <- arg.positionPx
		}

		topBar = GUI.TopBar("topBar" in arg ? arg.topBar : null)
		topBar.parent = this

		GUI.Collection.constructor.call(this, arg)
		GUI.Texture.constructor.call(this, arg)
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
		topBar.top()
	}

	function setVisible(visible, affectTopBar = true)
	{
		GUI.Texture.setVisible.call(this, visible)
		GUI.Collection.setVisible.call(this, visible)

		if (affectTopBar)
			topBar.setVisible(visible)
	}

	function setPosition(x, y)
	{
		setPositionPx(nax(x), nay(y))
	}

	function setPositionPx(x, y)
	{
		GUI.Texture.setPositionPx.call(this, x, y)
		GUI.Collection.setPositionPx.call(this, x, y)
		topBar.setPositionPx(x, y)
	}

	function setColor(color, affectChilds = true)
	{
		GUI.Texture.setColor.call(this, color)

		if (affectChilds)
		{
			foreach(child in childs)
				child.setColor(color)
		}
	}

	function setDisabled(disabled, affectChilds = true)
	{
		GUI.Texture.setDisabled.call(this, disabled)
		topBar.setDisabled(disabled)

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
}