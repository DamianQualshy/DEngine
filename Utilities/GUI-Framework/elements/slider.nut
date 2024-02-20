class GUI.Slider extends GUI.Range
{
#public:
	progress = null

	constructor(arg = null)
	{
		progress = GUI.Texture("progress" in arg ? arg.progress : null)
		base.constructor(arg)

		updateProgress()
	}

	function setValue(value)
	{
		base.setValue(value)
		updateProgress()
	}

	function setMinimum(minimum)
	{
		base.setMinimum(minimum)
		updateProgress()
	}

	function setMaximum(maximum)
	{
		base.setMaximum(maximum)
		updateProgress()
	}

	function setVisible(visible)
	{
		GUI.Texture.setVisible.call(this, visible)
		progress.setVisible(visible)
		indicator.setVisible(visible)
	}

	function setDisabled(disabled)
	{
		base.setDisabled(disabled)
		progress.setDisabled(disabled)
	}

	function top()
	{
		GUI.Texture.top.call(this)
		progress.top()
		indicator.top()
	}

	function setPositionPx(x, y)
	{
		local positionPx = getPositionPx()
		base.setPositionPx(x, y)
		
		local offsetXPx = x - positionPx.x
		local offsetYPx = y - positionPx.y

		local progressPositionPx = progress.getPositionPx()
		progress.setPositionPx(progressPositionPx.x + offsetXPx, progressPositionPx.y + offsetYPx)
	}

	function setSizePx(width, height)
	{
		base.setSizePx(width, height)
		updateProgress()
	}

	function setMarginPx(top, right, bottom, left)
	{
		base.setMarginPx(top, right, bottom, left)
		updateProgress()
	}

	function updateProgress()
	{
		local sizePx = getSizePx()
		local positionPx = getPositionPx()
		local marginPx = getMarginPx()

		local indicatorPositionPx = indicator.getPositionPx()
		local indicatorSizePx = indicator.getSizePx()

		switch (_orientation)
		{
			case Orientation.Horizontal:
			{
				if (_minimum < _maximum)
				{
					progress.setPositionPx(positionPx.x + marginPx.left, positionPx.y + marginPx.top)
					progress.setSizePx(indicatorSizePx.width + indicatorPositionPx.x - positionPx.x - marginPx.left, indicatorSizePx.height)
				}
				else
				{
					progress.setPositionPx(indicatorPositionPx.x, positionPx.y + marginPx.top)
					progress.setSizePx(sizePx.width - (indicatorPositionPx.x - positionPx.x) - marginPx.right, indicatorSizePx.height)
				}
				break
			}

			case Orientation.Vertical:
			{
				if (_minimum < _maximum)
				{
					progress.setPositionPx(positionPx.x + marginPx.left, positionPx.y + marginPx.top)
					progress.setSizePx(indicatorSizePx.width, indicatorSizePx.height + indicatorPositionPx.y - positionPx.y - marginPx.top)
				}
				else
				{
					progress.setPositionPx(positionPx.x + marginPx.left, indicatorPositionPx.y)
					progress.setSizePx(indicatorSizePx.width, sizePx.height - (indicatorPositionPx.y - positionPx.y) - marginPx.bottom)
				}
				break
			}
		}
	}
}