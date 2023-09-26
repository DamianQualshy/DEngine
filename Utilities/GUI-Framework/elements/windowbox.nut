local GUIWindowBoxClasses = classes(GUI.Window, GUI.Offset)
class GUI.WindowBox extends GUIWindowBoxClasses
{
#public:
	topBar = null
	title = null
	minimizeButton = null
	closeButton = null

	constructor(arg = null)
	{
		GUI.Offset.constructor.call(this, arg)

		local sizePx = {width = 0, height = 0}
		if ("sizePx" in arg)
			sizePx = {width = arg.sizePx.width, height = arg.sizePx.height}
		else if ("size" in arg)
			sizePx = {width = nax(arg.size.width), height = nay(arg.size.height)}

		local topBarHeightPx = WINDOWBOX_TOPBAR_HEIGHT
		if ("topBarHeightPx" in arg)
			topBarHeightPx = arg.topBarHeightPx
		else if ("topBarHeight" in arg)
			topBarHeightPx = nay(arg.topBarHeight)

		local buttonWidthPx = WINDOWBOX_BUTTON_WIDTH
		if ("buttonWidthPx" in arg)
			buttonWidthPx = arg.buttonWidthPx
		else if ("buttonWidth" in arg)
			buttonWidthPx = nax(arg.buttonWidth)

		local positionPx = {x = 0, y = 0}
		if ("positionPx" in arg)
			positionPx = {x = arg.positionPx.x, y = arg.positionPx.y}
		else if ("position" in arg)
			positionPx = {x = nax(arg.position.x), y = nay(arg.position.y)}

		topBar = GUI.Texture("topBar" in arg ? arg.topBar : null)
		topBar.setSizePx(sizePx.width, topBarHeightPx)
		topBar.parent = this
		topBar.bind(EventType.MouseDown, topBar_onMouseDown)

		title = GUI.Draw("title" in arg ? arg.title : null)
		title.setDisabled(true)
		title.parent = this

		minimizeButton = GUI.Button("minimizeButton" in arg ? arg.minimizeButton : null)
		minimizeButton.setSizePx(buttonWidthPx, topBarHeightPx)
		minimizeButton.parent = this
		minimizeButton.bind(EventType.Click, minimizeButton_onClick)

		closeButton = GUI.Button("closeButton" in arg ? arg.closeButton : null)
		closeButton.setSizePx(buttonWidthPx, topBarHeightPx)
		closeButton.parent = this
		closeButton.bind(EventType.Click, closeButton_onClick)

		GUI.Window.constructor.call(this, arg)
		GUI.Window.setSizePx.call(this, sizePx.width, sizePx.height - topBarHeightPx)

		updatePosition()
	}

	function setOffsetPx(x, y)
	{
		local positionPx = getPositionPx()
		GUI.Offset.setOffsetPx.call(this, x, y)
		title.setPositionPx(positionPx.x + x, positionPx.y + y)
	}

	function setVisible(visible)
	{
		GUI.Window.setVisible.call(this, visible)

		topBar.setVisible(visible)
		title.setVisible(visible)
		minimizeButton.setVisible(visible)
		closeButton.setVisible(visible)
	}

	function getPositionPx()
	{
		return topBar.getPositionPx()
	}

	function setPositionPx(x, y)
	{
		local positionPx = getPositionPx()

		local offsetXPx = x - positionPx.x
		local offsetYPx = y - positionPx.y

		local topBarPositionPx = topBar.getPositionPx()
		topBar.setPositionPx(topBarPositionPx.x + offsetXPx, topBarPositionPx.y + offsetYPx)

		local titlePositionPx = title.getPositionPx()
		title.setPositionPx(titlePositionPx.x + offsetXPx, titlePositionPx.y + offsetYPx)

		local minimizeButtonPositionPx = minimizeButton.getPositionPx()
		minimizeButton.setPositionPx(minimizeButtonPositionPx.x + offsetXPx, minimizeButtonPositionPx.y + offsetYPx)

		local closeButtonPositionPx = closeButton.getPositionPx()
		closeButton.setPositionPx(closeButtonPositionPx.x + offsetXPx, closeButtonPositionPx.y + offsetYPx)
	}

	function getSizePx()
	{
		local topBarSize = topBar.getSizePx()
		return {width = topBarSize.width, height = topBarSize.height + GUI.Window.getSizePx.call(this).height}
	}

	function setSizePx(width, height)
	{
		local topBarHeight = topBar.getSizePx().height
		topBar.setSizePx(width, topBarHeight)
		GUI.Window.setSizePx.call(this, width, height - topBarHeight)
		
		updatePosition()
	}

	function updatePosition()
	{
		local positionPx = getPositionPx()
		local sizePx = getSizePx()
		local offset = getOffsetPx()
		local closeButtonWidth = closeButton.getSizePx().width

		topBar.setPositionPx(positionPx.x, positionPx.y)
		title.setPositionPx(positionPx.x + offset.x, positionPx.y + offset.y)
		minimizeButton.setPositionPx(positionPx.x + sizePx.width - closeButtonWidth - minimizeButton.getSizePx().width, positionPx.y)
		closeButton.setPositionPx(positionPx.x + sizePx.width - closeButtonWidth, positionPx.y)

		GUI.Window.setPositionPx.call(this, positionPx.x, positionPx.y + topBar.getSizePx().height)
	}

	function topBar_onMouseDown(self, button)
	{
		if (button != MOUSE_LMB)
			return

		local cursorPositionPx = getCursorPositionPx()
		local position = self.getPositionPx()
		local window = self.parent

		window.setCursorOffset(position.x - cursorPositionPx.x, position.y - cursorPositionPx.y)
		setActiveWindow(window)
	}

	function minimizeButton_onClick(self)
	{
		local window = self.parent
		GUI.Window.setVisible.call(window, !window.getVisible())
	}

	function closeButton_onClick(self)
	{
		self.parent.setVisible(false)
	}
}
