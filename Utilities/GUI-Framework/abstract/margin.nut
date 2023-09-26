class GUI.Margin
{
#protected:
	_marginPx = null

#public:
	constructor(arg = null)
	{
		if ("marginPx" in arg)
		{
			switch (typeof arg.marginPx)
			{
				case "table":
					_marginPx = {
						top = "top" in arg.marginPx ? arg.marginPx.top : 0
						right = "right" in arg.marginPx ? arg.marginPx.right : 0,
						bottom = "bottom" in arg.marginPx ? arg.marginPx.bottom : 0,
						left = "left" in arg.marginPx ? arg.marginPx.left : 0
					}
					break

				case "array":
				{
					local top = (0 in arg.marginPx) ? arg.marginPx[0] : 0
					local right = (1 in arg.marginPx) ? arg.marginPx[1] : top
					local bottom = (2 in arg.marginPx) ? arg.marginPx[2] : top
					local left = (3 in arg.marginPx) ? arg.marginPx[3] : right

					_marginPx = {top = top, right = right, bottom = bottom, left = left}
					break
				}
			}
		}
		else if ("margin" in arg)
		{
			switch (typeof arg.margin)
			{
				case "table":
					_marginPx = {
						top = "top" in arg.margin ? nay(arg.margin.top) : 0
						right = "right" in arg.margin ? nax(arg.margin.right) : 0,
						bottom = "bottom" in arg.margin ? nay(arg.margin.bottom) : 0,
						left = "left" in arg.margin ? nax(arg.margin.left) : 0
					}
					break

				case "array":
				{
					local top = (0 in arg.margin) ? arg.margin[0] : 0
					local right = (1 in arg.margin) ? arg.margin[1] : top
					local bottom = (2 in arg.margin) ? arg.margin[2] : top
					local left = (3 in arg.margin) ? arg.margin[3] : right

					_marginPx = {top = nay(top), right = nax(right), bottom = nay(bottom), left = nax(left)}
					break
				}
			}
		}
		else
			_marginPx = {top = 0, right = 0, bottom = 0, left = 0}
	}

	function getMarginPx()
	{
		return _marginPx
	}

	function setMarginPx(top, right, bottom, left)
	{
		_marginPx.top = top
		_marginPx.right = right
		_marginPx.bottom = bottom
		_marginPx.left = left
	}

	function getMargin()
	{
		return {
			top = any(_marginPx.top)
			right = anx(_marginPx.right)
			bottom = any(_marginPx.bottom)
			left = anx(_marginPx.left)
		}
	}

	function setMargin(top, right, bottom, left)
	{
		setMarginPx(nay(top), nax(right), nay(bottom), nax(left))
	}
}