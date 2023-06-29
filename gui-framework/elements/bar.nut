local GUIBarClasses = classes(GUI.Texture, GUI.Orientation, GUI.Alignment, GUI.Margin)
class GUI.Bar extends GUIBarClasses
{
#proteced:
	_stretching = true

	_value = 0
	_minimum = 0
	_maximum = 100

#public:
	progress = null

	constructor(x, y, width, height, marginX, marginY, background, progress, orientation = Orientation.Horizontal, alignment = Align.Left, window = null)
	{
		GUI.Texture.constructor.call(this, x, y, width, height, background, window)
		setDisabled(true)

		GUI.Orientation.setOrientation.call(this, orientation)
		GUI.Alignment.setAlignment.call(this, alignment)
		GUI.Margin.constructor.call(this)

		this.progress = GUI.Texture(0, 0, 0, 0, progress)

		setPosition(x, y)
		setSize(width, height)

		// tmp?
		setMargin(marginY, marginX, marginY, marginX)
	}

	function getPercentage()
	{
		return fabs(_value - _minimum) / fabs(_maximum - _minimum)
	}

	function getValue()
	{
		return _value
	}

	function setValue(value)
	{
		if (value > _maximum)
			value = _maximum
		else if (value < _minimum)
			value = _minimum

		_value = value

		local maxSize = getSizePx()
		setSizePx(maxSize.width, maxSize.height)
	}

	function getMinimum()
	{
		return _minimum
	}

	function setMinimum(minimum)
	{
		_minimum = minimum
		setValue(_minimum)
	}

	function getMaximum()
	{
		return _maximum
	}

	function setMaximum(maximum)
	{
		_maximum = maximum
		setValue(_minimum)
	}

	function top()
	{
		GUI.Texture.top.call(this)
		progress.top()
	}

	function destroy()
	{
		GUI.Texture.destroy.call(this)
		progress.destroy()
	}

	function getStreching()
	{
		return _stretching
	}

	function setStretching(stretching)
	{
		_stretching = stretching
	}

	function setAlignment(alignment)
	{
		GUI.Alignment.setAlignment.call(this, alignment)

		local position = getPositionPx()
		setPositionPx(position.x, position.y)

		setValue(getValue())
	}

	function setVisible(visible)
	{
		GUI.Texture.setVisible.call(this, visible)
		progress.setVisible(visible)
	}

	function setAlpha(alpha)
	{
		GUI.Texture.setAlpha.call(this, alpha)
		progress.setAlpha(alpha)
	}

	function setPositionPx(x, y)
	{
		GUI.Texture.setPositionPx.call(this, x, y)

		local size = getSizePx()

		if (_orientation == Orientation.Horizontal)
		{
			local progressWidth = ((size.width - _marginPx.left - _marginPx.right) * getPercentage()).tointeger()

			switch (_alignment)
			{
				case Align.Left:
					progress.setPositionPx(x + _marginPx.left, y + _marginPx.top)
					break

				case Align.Right:
					progress.setPositionPx(x + (size.width - progressWidth) - _marginPx.right, y + _marginPx.top)
					break

				case Align.Center:
					progress.setPositionPx(x + (size.width - progressWidth) / 2, y + _marginPx.top)
					break
			}
		}
		else if (_orientation == Orientation.Vertical)
		{
			local progressHeight = ((size.height - _marginPx.top - _marginPx.bottom) * getPercentage()).tointeger()

			switch (_alignment)
			{
				case Align.Left:
					progress.setPositionPx(x + _marginPx.left, y + _marginPx.top)
					break

				case Align.Right:
					progress.setPositionPx(x + _marginPx.left, y + size.height - progressHeight - _marginPx.bottom)
					break

				case Align.Center:
					progress.setPositionPx(x + _marginPx.right, y + (size.height - progressHeight) / 2)
					break
			}
		}
	}

	function setPosition(x, y)
	{
		setPositionPx(nax(x), nay(y))
	}

	function changeProgress(rectX, rectY, rectWidth, rectHeight)
	{
		if (!_stretching)
		{
			local size = getSizePx()

			progress.setSizePx((size.width - _marginPx.left - _marginPx.right), size.height - _marginPx.top - _marginPx.bottom)
			progress.setRectPx(rectX, rectY, rectWidth, rectHeight)
		}

		progress.setSizePx(rectWidth, rectHeight)
	}

	function setSizePx(width, height)
	{
		GUI.Texture.setSizePx.call(this, width, height)

		local position = getPositionPx()

		local progressWidth = width - _marginPx.left - _marginPx.right
		local progressHeight = height - _marginPx.top - _marginPx.bottom

		if (_orientation == Orientation.Horizontal)
		{
			progressWidth = (progressWidth * getPercentage()).tointeger()

			switch (_alignment)
			{
				case Align.Left:
					changeProgress(0, 0, progressWidth, progressHeight)
					break

				case Align.Right:
					changeProgress(width - progressWidth - _marginPx.left - _marginPx.right, 0, progressWidth, progressHeight)
					setPositionPx(position.x, position.y)
					break

				case Align.Center:
					changeProgress((width - progressWidth - _marginPx.left - _marginPx.right) / 2, 0, progressWidth, progressHeight)
					setPositionPx(position.x, position.y)
					break
			}
		}
		else if (_orientation == Orientation.Vertical)
		{
			progressHeight = (progressHeight * getPercentage()).tointeger()

			switch (_alignment)
			{
				case Align.Left:
					changeProgress(0, 0, progressWidth, progressHeight)
					break

				case Align.Right:
					changeProgress(0, height - progressHeight - _marginPx.top - _marginPx.bottom, progressWidth, progressHeight)
					setPositionPx(position.x, position.y)
					break

				case Align.Center:
					changeProgress(0, (height - progressHeight - _marginPx.top - _marginPx.bottom) / 2, progressWidth, progressHeight)
					setPositionPx(position.x, position.y)
					break
			}
		}
	}

	function setSize(width, height)
	{
		setSizePx(nax(width), nay(height))
	}

	function setMarginPx(top, right, bottom, left)
	{
		GUI.Margin.setMarginPx.call(this, top, right, bottom, left)

		local position = getPositionPx()
		local size = getSizePx()

		setPositionPx(position.x, position.y)
		setSizePx(size.width, size.height)
	}

	function setMargin(top, right, bottom, left)
	{
		setMarginPx(nay(top), nax(right), nay(bottom), nax(left))
	}
}
