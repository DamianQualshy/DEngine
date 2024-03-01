class GUI.NumberInput extends GUI.Input
{
	// Variables for configuration:
	_minValue = -32768
    _maxValue = 32767
	_isFloatAccepted = true

	// Variables for input operation:
	_isDotTyped = false
	_isDotPresent = false

	constructor(arg)
	{
		_minValue = "minValue" in arg ? arg.minValue : _minValue
		_maxValue = "maxValue" in arg ? arg.maxValue : _maxValue
		_isFloatAccepted = "acceptFloat" in arg ? arg.acceptFloat : _isFloatAccepted

		base.constructor(arg)
		_updateValue('=', _text)
	}

    function getMinValue() {
        return _minValue
    }

    function setMinValue(minValue)
    {
        _minValue = minValue
		_updateValue('=', _text)
    }

    function getMaxValue() {
        return _maxValue
    }

    function setMaxValue(maxValue)
    {
        _maxValue = maxValue
		_updateValue('=', _text)
    }

	function setText(text)
	{
		base.setText(text)
		_isDotPresent = _isFloatAccepted ? _text.find(".") != null : false
	}

	function isFloatAccepted() {
		return _isFloatAccepted
	}

	function setFloatAccepted(isFloatAccepted)
	{
		_isFloatAccepted = isFloatAccepted
		_updateValue('=', _text)
	}

	function _addText(text)
	{
		_isDotTyped = _isDotPresent

		foreach (idx, letter in text)
		{
			if (letter == '-')
			{
				if (idx == 0 && _text.len() == 0)
					continue
				else
					return
			}

			if (_isFloatAccepted && letter == '.')
			{
				if (_isDotTyped)
				{
					_isDotTyped = false
					return
				}

				_isDotTyped = true
				continue
			}

			if (letter < '0' || letter > '9')
				return
		}

		base._addText(text)
	}

	function _updateValue(opcode, value)
	{
		if (_text == "-")
		{
			_value = -1
			return
		}

		switch (opcode)
		{
			case '+':
				if (!_isDotPresent && _isDotTyped)
					_isDotPresent = true
				break

			case '-':
				if (value.find(".") != null)
					_isDotPresent = false
				break
		}

		try
		{
			local value = _isFloatAccepted ? _text.tofloat() : _text.tointeger()
			value = clamp(value, _minValue, _maxValue)
		}
		catch (e)
		{
			_text = ""
			_value = null
			_isDotPresent = false
			_updateTextFromLen()
		}
	}
}