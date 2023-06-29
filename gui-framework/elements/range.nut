// This script was made with a help of Calysto Canem

local activeRange = null

local GUIRangeClasses = classes(GUI.Texture, GUI.Orientation, GUI.Margin)
class GUI.Range extends GUIRangeClasses
{
#private:
	_step = 1
	_value = 0
	_minimum = 0
	_maximum = 100
	_smoothMotion = false

#public:
	indicator = null

	constructor(x, y, width, height, file, indicatorFile, orientation = Orientation.Horizontal, window = null)
	{
		indicator = GUI.Texture(x, y, 0, 0, indicatorFile)
		indicator.parent = this

		GUI.Orientation.setOrientation.call(this, orientation)
		setIndicatorSize(width, height)

		GUI.Margin.constructor.call(this)

		GUI.Texture.constructor.call(this, x, y, width, height, file, window)
		indicator.top()

		indicator.bind(EventType.MouseDown, indicator_onMouseDown)
		this.bind(EventType.MouseDown, onMouseDown)
	}

	function setIndicatorSize(width, height)
	{
		if (_orientation == Orientation.Horizontal)
		{
			indicator.setSize(anx(RANGE_INDICATOR_SIZE), height)
		}
		else if (_orientation == Orientation.Vertical)
		{
			indicator.setSize(width, any(RANGE_INDICATOR_SIZE))
		}
	}

	function destroy()
	{
		if (activeRange == this)
			activeRange = null

		indicator = indicator.destroy()
		GUI.Texture.destroy.call(this)
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
		local min = _minimum, max = _maximum

		if (min > max)
		{
			min = _maximum
			max = _minimum
		}

		if (value < min)
			value = min
		else if (value > max)
			value = max

		local oldValue = _value
		_value = value

		local position = getPositionPx()
		local size = getSizePx()

		local indicatorPosition = indicator.getPositionPx()
		local indicatorSize = indicator.getSizePx()

		position.x += _marginPx.left
		position.y += _marginPx.top

		if (_orientation == Orientation.Horizontal)
		{
			size.width -= indicatorSize.width + _marginPx.left + _marginPx.right
			indicator.setPositionPx(position.x + size.width * getPercentage(), position.y)
		}
		else if (_orientation == Orientation.Vertical)
		{
			size.height -= indicatorSize.height + _marginPx.top + _marginPx.bottom
			indicator.setPositionPx(position.x, position.y + size.height * getPercentage())
		}

		if (value != oldValue)
		{
			call(EventType.Change)
			callEvent("GUI.onChange", this)
		}
	}

	function getMinimum()
	{
		return _minimum
	}

	function setMinimum(minimum)
	{
		_minimum = minimum
		setValue(_value)
	}

	function getMaximum()
	{
		return _maximum
	}

	function setMaximum(maximum)
	{
		_maximum = maximum
		setValue(_value)
	}

	function getStep()
	{
		return _step
	}

	function setStep(step)
	{
		_step = step
	}

	function getSmoothMotion()
	{
		return _smoothMotion
	}

	function setSmoothMotion(bool)
	{
		_smoothMotion = bool
	}

	function changeSection(cursorPositionX, cursorPositionY)
	{
		local position = getPositionPx()
		local size = getSizePx()
		local indicatorSize = indicator.getSizePx()

		if (_smoothMotion)
		{
			local newValue = _value
			local valuesCount = _maximum - _minimum
			if (valuesCount < 0)
				valuesCount = -valuesCount
			++valuesCount

			if (valuesCount < 2)
				return

			if (_orientation == Orientation.Horizontal)
			{
				local halfWidth = indicatorSize.width / 2
				local newPos = cursorPositionX - halfWidth
				local minPos = position.x + _marginPx.left
				local maxPos = position.x + size.width - _marginPx.right - indicatorSize.width

				if (newPos < minPos)
				{
					newPos = minPos
					cursorPositionX = minPos + halfWidth
				}
				else if (newPos > maxPos)
				{
					newPos = maxPos
					cursorPositionX = maxPos + halfWidth
				}

				local distance = size.width - indicatorSize.width - _marginPx.left - _marginPx.right
				local segmentWidth = distance / valuesCount
				local currentWidth = distance - (maxPos + halfWidth) + cursorPositionX

				if (distance - currentWidth < segmentWidth)
					newValue = _maximum
				else
				{
					local currentStep = (currentWidth / segmentWidth).tointeger()
					newValue = _minimum + (currentStep * _step)
				}

				indicator.setPositionPx(newPos, position.y)
			}
			else if (_orientation == Orientation.Vertical)
			{
				local halfHeight = indicatorSize.height / 2
				local newPos = cursorPositionY - halfHeight
				local minPos = position.y + _marginPx.top
				local maxPos = position.y + size.height - _marginPx.bottom - indicatorSize.height

				if (newPos < minPos)
				{
					newPos = minPos
					cursorPositionY = minPos + halfHeight
				}
				else if (newPos > maxPos)
				{
					newPos = maxPos
					cursorPositionY = maxPos + halfHeight
				}

				local distance = size.height - indicatorSize.height - _marginPx.top - _marginPx.bottom
				local segmentHeight = distance / valuesCount
				local currentHeight = distance - (maxPos + halfHeight) + cursorPositionY

				if (distance - currentHeight < segmentHeight)
					newValue = _maximum
				else
				{
					local currentStep = (currentHeight / segmentHeight).tointeger()
					newValue = _minimum + (currentStep * _step)
				}

				indicator.setPositionPx(position.x, newPos)
			}

			if (newValue != _value)
			{
				_value = newValue
				call(EventType.Change)
				callEvent("GUI.onChange", this)
			}
		}
		else
		{
			// calculating distance and make it positive number
			local distance = _maximum - _minimum

			if (distance < 0)
				distance = -distance

			// normalizing distance
			distance -= distance % _step

			// setting margin, calculating percentage cursor location on slider, center the percentageLocation
			local percentageLocation

			position.x += _marginPx.left
			position.y += _marginPx.top

			if (_orientation == Orientation.Horizontal)
			{
				size.width -= _marginPx.left + _marginPx.right

				percentageLocation = (cursorPositionX - position.x).tofloat() / (size.width - indicatorSize.width)
				percentageLocation -= (indicatorSize.width / 2).tofloat() / size.width
			}
			else
			{
				size.height -= _marginPx.top + _marginPx.bottom

				percentageLocation = (cursorPositionY - position.y).tofloat() / (size.height - indicatorSize.height)
				percentageLocation -= (indicatorSize.height / 2).tofloat() / size.height
			}

			// inverting percentage if max < min, calculating newValue, adding distance between ranges
			local isMaxLessThanMin = (_maximum < _minimum)

			if (isMaxLessThanMin)
				percentageLocation = 1.0 - percentageLocation

			local newValue = percentageLocation * distance

			if (isMaxLessThanMin)
				newValue += (_minimum - distance)
			else
				newValue += (_maximum - distance)

			// normalizing newValue
			newValue -= newValue % _step

			setValue(newValue)
		}
	}

	function setAlpha(alpha)
	{
		GUI.Texture.setAlpha.call(this, alpha)
		indicator.setAlpha(alpha)
	}

	function top()
	{
		GUI.Texture.top.call(this)
		indicator.top()
	}

	function setVisible(visible)
	{
		GUI.Texture.setVisible.call(this, visible)
		indicator.setVisible(visible)
	}

	function setPositionPx(x, y)
	{
		local position = getPositionPx()
		local indicatorPosition = indicator.getPositionPx()

		GUI.Texture.setPositionPx.call(this, x, y)
		indicator.setPositionPx(x + (indicatorPosition.x - position.x), y + (indicatorPosition.y - position.y))
	}

	function setPosition(x, y)
	{
		setPositionPx(nax(x), nay(y))
	}

	function setSizePx(width, height)
	{
		GUI.Texture.setSizePx.call(this, width, height)
		setIndicatorSize(anx(width), any(height))
		setValue(_value)
	}

	function setSize(width, height)
	{
		setSizePx(nax(width), nay(height))
	}

	function setMarginPx(top, right, bottom, left)
	{
		GUI.Margin.setMarginPx.call(this, top, right, bottom, left)

		local size = getSizePx()
		local indicatorSize = indicator.getSizePx()

		if (_orientation == Orientation.Horizontal)
		{
			size.height -= _marginPx.bottom
			indicator.setSizePx(indicatorSize.width, size.height)
		}
		else if (_orientation == Orientation.Vertical)
		{
			size.width -= _marginPx.right
			indicator.setSizePx(size.width, indicatorSize.height)
		}

		setValue(_value)
	}

	function setMargin(top, right, bottom, left)
	{
		setMarginPx(top, right, bottom, left)
	}

	static function getActiveRange()
	{
		return activeRange
	}

	static function setActiveRange(range)
	{
		activeRange = range
	}

	static function indicator_onMouseDown(self, button)
	{
		if (button != MOUSE_LMB)
			return

		local range = self.parent
		activeRange = range
	}

	static function onMouseDown(self, button)
	{
		if (button != MOUSE_LMB)
			return

		local cursorPosition = getCursorPositionPx()

		self.changeSection(cursorPosition.x, cursorPosition.y)
		activeRange = self
	}

	static function onMouseRelease(button)
	{
		if (button != MOUSE_LMB)
			return

		if (!activeRange)
			return

		activeRange = null
	}

	static function onMouseMove(x, y)
	{
		if (!activeRange)
			return

		local cursorPositionPx = getCursorPositionPx()
		activeRange.changeSection(cursorPositionPx.x, cursorPositionPx.y)
	}
}

addEventHandler("onMouseRelease", GUI.Range.onMouseRelease)
addEventHandler("onMouseMove", GUI.Range.onMouseMove)
