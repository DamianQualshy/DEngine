class GUI.Base
{
#protected:
	_visible = false
	_isDisabled = false

#public:
	parent = null
	collection = null
	metadata = null

	constructor(arg = null)
	{
		parent = "parent" in arg ? arg.parent : parent
		metadata = "metadata" in arg ? arg.metadata : {}

		if ("visible" in arg)
			setVisible(arg.visible)

		if ("disabled" in arg)
			setDisabled(arg.disabled)

		if ("collection" in arg && arg.collection != null)
			arg.collection.add(this)
	}

	function getVisible()
	{
		return _visible
	}

	function setVisible(visible)
	{
		_visible = visible
	}

	function getDisabled()
	{
		return _isDisabled
	}

	function setDisabled(disabled)
	{
		_isDisabled = disabled
	}

	function getPosition()
	{
		local positionPx = getPositionPx()
		return { x = anx(positionPx.x), y = any(positionPx.y) }
	}

	function setPosition(x, y)
	{
		setPositionPx(nax(x), nay(y))
	}

	function getRelativePositionPx()
	{
		if (!collection)
			return getPositionPx()

		local collectionPositionPx = collection.getPositionPx()
		local positionPx = getPositionPx()

		return { x = positionPx.x - collectionPositionPx.x, y =  positionPx.y - collectionPositionPx.y }
	}

	function getRelativePosition()
	{
		local relativePositionPx = getRelativePositionPx()
		return { x = anx(relativePositionPx.x), y = any(relativePositionPx.y) }
	}

	function setRelativePositionPx(x, y)
	{
		if (!collection)
		{
			setPositionPx(x, y)
			return
		}

		local collectionPositionPx = collection.getPositionPx()
		setPositionPx(collectionPositionPx.x + x, collectionPositionPx.y + y)
	}

	function setRelativePosition(x, y)
	{
		setRelativePositionPx(nax(x), nay(y))
	}

	function getSize()
	{
		local sizePx = getSizePx()
		return { width = anx(sizePx.width), height = any(sizePx.height) }
	}
	
	function setSize(width, height)
	{
		setSizePx(nax(width), nay(height))
	}
}