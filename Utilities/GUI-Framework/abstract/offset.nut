class GUI.Offset
{
#private:
	_offsetPx = null

#public:
	constructor(arg = null)
	{
		if ("offsetPx" in arg)
			_offsetPx = {x = arg.offsetPx.x, y = arg.offsetPx.y}
		else if("offset" in arg)
			_offsetPx = {x = nax(arg.offset.x), y = nay(arg.offset.y)}
		else
			_offsetPx = {x = 0, y = 0}
	}

	function getOffsetPx()
	{
		return _offsetPx
	}

	function setOffsetPx(x, y)
	{
		_offsetPx.x = x
		_offsetPx.y = y
	}

	function getOffset()
	{
		return {x = anx(_offsetPx.x), y = any(_offsetPx.y)}
	}

	function setOffset(x, y)
	{
		setOffsetPx(nax(x), nay(y))
	}
}