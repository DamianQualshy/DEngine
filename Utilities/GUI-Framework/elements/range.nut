// This script was made with a help of Calysto Canem
local ref =
{
	activeRange = null
}

local GUIRangeClasses = classes(GUI.Texture, GUI.Orientation, GUI.Margin)
class GUI.Range extends GUIRangeClasses
{
#private:
	_step = 1
	_value = 0
	_minimum = 0
	_maximum = 100
	_smoothMotion = false
	_indicatorSizePx = 0

#public:
	indicator = null

	constructor(arg = null)
	{
		indicator = GUI.Texture("indicator" in arg ? arg.indicator : null)

		GUI.Margin.constructor.call(this, arg)
		_orientation = "orientation" in arg ? arg.orientation : Orientation.Horizontal
		_step = "step" in arg ? arg.step : _step
		_value = "value" in arg ? arg.value : _value
		_minimum = "minimum" in arg ? arg.minimum : _minimum
		_maximum = "maximum" in arg ? arg.maximum : _maximum
		_smoothMotion = "smoothMotion" in arg ? arg.smoothMotion : _smoothMotion

		GUI.Texture.constructor.call(this, arg)
		bind(EventType.MouseDown, onMouseDown)
		indicator.top()
		indicator.bind(EventType.MouseDown, indicator_onMouseDown)
		indicator.parent = this

		if ("indicatorSizePx" in arg)
			setIndicatorSizePx(arg.indicatorSizePx)
		else if ("indicatorSize" in arg)
			setIndicatorSize(arg.indicatorSize)
		else
			setIndicatorSizePx(RANGE_INDICATOR_SIZE)
	}

	function setIndicatorSizePx(indicatorSize)
	{
		_indicatorSizePx = indicatorSize
		updateIndicatorSize()
	}

	function setIndicatorSize(indicatorSize)
	{
		switch (_orientation)
		{
			case Orientation.Horizontal:
				setIndicatorSizePx(nax(indicatorSize))
				break

			case Orientation.Vertical:
				setIndicatorSizePx(nay(indicatorSize))
				break
		}
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

		if (value != _value)
		{
			_value = value
			updateIndicatorPosition()
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

		if (_value < minimum)
			setValue(minimum)
		else
			updateIndicatorPosition()
	}

	function getMaximum()
	{
		return _maximum
	}

	function setMaximum(maximum)
	{
		_maximum = maximum

		if (_value > maximum)
			setValue(maximum)
		else
			updateIndicatorPosition()
	}

	function getStep()
	{
		return _step
	}

	function setStep(step)
	{
		_step = step
	}

	function setVisible(visible)
	{
		GUI.Texture.setVisible.call(this, visible)
		indicator.setVisible(visible)
	}

	function setDisabled(disabled)
	{
		GUI.Texture.setDisabled.call(this, disabled)
		indicator.setDisabled(disabled)
	}

	function top()
	{
		GUI.Texture.top.call(this)
		indicator.top()
	}

	function setPositionPx(x, y)
	{
		local positionPx = getPositionPx()
		GUI.Texture.setPositionPx.call(this, x, y)
		
		local offsetXPx = x - positionPx.x
		local offsetYPx = y - positionPx.y

		local indicatorPositionPx = indicator.getPositionPx()
		indicator.setPositionPx(indicatorPositionPx.x + offsetXPx, indicatorPositionPx.y + offsetYPx)
	}

	function setSizePx(width, height)
	{
		GUI.Texture.setSizePx.call(this, width, height)
		updateIndicatorSize()
	}

	function setMarginPx(top, right, bottom, left)
	{
		GUI.Margin.setMarginPx.call(this, top, right, bottom, left)
		updateIndicatorSize()
	}

	function getSmoothMotion()
	{
		return _smoothMotion
	}

	function setSmoothMotion(bool)
	{
		_smoothMotion = bool
	}

	function getPercentage()
	{
		return fabs(_value - _minimum) / fabs(_maximum - _minimum)
	}

	function updateIndicatorPosition()
	{
		local positionPx = getPositionPx()
		local sizePx = getSizePx()
		local marginPx = getMarginPx()
		local indicatorSizePx = indicator.getSizePx()

		positionPx.x += marginPx.left
		positionPx.y += marginPx.top

		switch (_orientation)
		{
			case Orientation.Horizontal:
				sizePx.width -= indicatorSizePx.width + marginPx.left + marginPx.right
				indicator.setPositionPx(positionPx.x + sizePx.width * getPercentage(), positionPx.y)
				break

			case Orientation.Vertical:
				sizePx.height -= indicatorSizePx.height + marginPx.top + marginPx.bottom
				indicator.setPositionPx(positionPx.x, positionPx.y + sizePx.height * getPercentage())
				break
		}
	}

	function updateIndicatorSize()
	{
		local sizePx = getSizePx()
		local marginPx = getMarginPx()

		switch (_orientation)
		{
			case Orientation.Horizontal:
				indicator.setSizePx(_indicatorSizePx, sizePx.height - marginPx.top - marginPx.bottom)
				break

			case Orientation.Vertical:
				indicator.setSizePx(sizePx.width - marginPx.left - marginPx.right, _indicatorSizePx)
				break
		}

		updateIndicatorPosition()
	}

	function changeSection(cursorPositionX, cursorPositionY)
	{
		local positionPx = getPositionPx()
		local sizePx = getSizePx()
		local indicatorSizePx = indicator.getSizePx()
		local marginPx = getMarginPx()

		if (_smoothMotion)
		{
			local newValue = _value
			local valuesCount = _maximum - _minimum

			valuesCount = valuesCount < 0 ? -valuesCount : valuesCount
			++valuesCount

			if (valuesCount < 2)
				return

			switch (_orientation)
			{
				case Orientation.Horizontal:
				{
					local halfWidth = indicatorSizePx.width / 2
					local newPos = cursorPositionX - halfWidth
					local minPos = positionPx.x + marginPx.left
					local maxPos = positionPx.x + sizePx.width - marginPx.right - indicatorSizePx.width

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

					local distance = sizePx.width - indicatorSizePx.width - marginPx.left - marginPx.right
					local segmentWidth = distance / valuesCount
					local currentWidth = distance - (maxPos + halfWidth) + cursorPositionX

					if (distance - currentWidth < segmentWidth)
						newValue = _maximum
					else
					{
						local currentStep = (currentWidth / segmentWidth).tointeger()
						newValue = _minimum + (currentStep * _step)
					}

					indicator.setPositionPx(newPos, positionPx.y + marginPx.top)
					break
				}

				case Orientation.Vertical:
				{
					local halfHeight = indicatorSizePx.height / 2
					local newPos = cursorPositionY - halfHeight
					local minPos = positionPx.y + marginPx.top
					local maxPos = positionPx.y + sizePx.height - marginPx.bottom - indicatorSizePx.height

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

					local distance = sizePx.height - indicatorSizePx.height - marginPx.top - marginPx.bottom
					local segmentHeight = distance / valuesCount
					local currentHeight = distance - (maxPos + halfHeight) + cursorPositionY

					if (distance - currentHeight < segmentHeight)
						newValue = _maximum
					else
					{
						local currentStep = (currentHeight / segmentHeight).tointeger()
						newValue = _minimum + (currentStep * _step)
					}

					indicator.setPositionPx(positionPx.x + marginPx.right, newPos)
					break
				}
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
			distance = distance < 0 ? -distance : distance

			// normalizing distance
			distance -= distance % _step

			// setting marginPx, calculating percentage cursor location on slider, center the percentageLocation
			local percentageLocation

			positionPx.x += marginPx.left
			positionPx.y += marginPx.top

			if (_orientation == Orientation.Horizontal)
			{
				sizePx.width -= marginPx.left + marginPx.right

				percentageLocation = (cursorPositionX - positionPx.x).tofloat() / (sizePx.width - indicatorSizePx.width)
				percentageLocation -= (indicatorSizePx.width / 2).tofloat() / sizePx.width
			}
			else
			{
				sizePx.height -= marginPx.top + marginPx.bottom

				percentageLocation = (cursorPositionY - positionPx.y).tofloat() / (sizePx.height - indicatorSizePx.height)
				percentageLocation -= (indicatorSizePx.height / 2).tofloat() / sizePx.height
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

	function indicator_onMouseDown(self, button)
	{
		if (button != MOUSE_BUTTONLEFT)
			return

		local range = self.parent
		ref.activeRange = range.weakref()
	}

	function onMouseDown(self, button)
	{
		if (button != MOUSE_BUTTONLEFT)
			return

		local cursorPosition = getCursorPositionPx()

		self.changeSection(cursorPosition.x, cursorPosition.y)
		ref.activeRange = self.weakref()
	}

	static function onMouseUp(button)
	{
		if (button != MOUSE_BUTTONLEFT)
			return

		if (!ref.activeRange)
			return

		ref.activeRange = null
	}

	static function onMouseMove(x, y)
	{
		if (!ref.activeRange)
			return

		local cursorPositionPx = getCursorPositionPx()
		ref.activeRange.changeSection(cursorPositionPx.x, cursorPositionPx.y)
	}

	static function getActiveRange()
	{
		return ref.activeRange
	}

	static function setActiveRange(range)
	{
		ref.activeRange = (range != null) ? range.weakref() : null
	}
}

addEventHandler("onMouseUp", GUI.Range.onMouseUp)
addEventHandler("onMouseMove", GUI.Range.onMouseMove)