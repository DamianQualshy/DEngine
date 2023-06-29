class GUI.Slider extends GUI.Range
{
#public:
	bar = null

    constructor(x, y, width, height, marginX, marginY, background, progress, indicatorFile, orientation = Orientation.Horizontal, alignment = Align.Left, node = null)
    {
        bar = GUI.Bar(x, y, width, height, marginX, marginY, "", progress, orientation, alignment)
        base.constructor(x, y, width, height, background, indicatorFile, orientation, node)

		if (alignment == Align.Right)
			swapMinMax()

		bar.top()
		indicator.top()
    }

	function destroy()
	{
		bar = bar.destroy()
		base.destroy()
	}

	function swapMinMax()
	{
		local minimum = getMinimum()
		local maximum = getMaximum()

		local value = getValue()

		base.setMaximum(minimum)
		base.setMinimum(maximum)

		setValue(value)
	}

	function setMinimum(minimum)
	{
		base.setMinimum(minimum)
		bar.setMinimum(minimum)
	}

	function setMaximum(maximum)
	{
		base.setMaximum(maximum)
		bar.setMaximum(maximum)
	}

    function setValue(value)
    {
		base.setValue(value)
		bar.setValue(value)
    }

	function getAlignment()
	{
		return bar.getAlignment()
	}

	function setAlignment(alignment)
	{
		if (alignment == getAlignment())
			return

		swapMinMax()
		bar.setAlignment(alignment)
	}

	function setMarginPx(top, right, bottom, left)
	{
		base.setMarginPx(top, right, bottom, left)
		bar.setMarginPx(top, right, bottom, left)
	}

	function setMargin(top, right, bottom, left)
	{
		setMarginPx(nay(top), nax(right), nay(bottom), nax(left))
	}

	function setVisible(visible)
	{
		base.setVisible(visible)
		bar.setVisible(visible)
	}

	function setAlpha(alpha)
	{
		base.setAlpha(alpha)
		bar.setAlpha(alpha)
	}

	function setPosition(x, y)
	{
		setPositionPx(nax(x), nay(y))
	}

    function setPositionPx(x, y)
    {
        base.setPositionPx(x, y)
        bar.setPositionPx(x, y)
    }

	function setSize(width, height)
	{
		setSizePx(nax(width), nay(height))
	}

	function setSizePx(width, height)
	{
		base.setSizePx(width, height)
		bar.setSizePx(width, height)
	}

	function top()
	{
		base.top()

		bar.top()
		indicator.top()
	}
}
