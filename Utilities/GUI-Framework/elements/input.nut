enum Input
{
	Text,
	Password,
	Numbers
}

local ref =
{
	activeInput = null
}

local GUIInputClasses = classes(GUI.Texture, GUI.Alignment)
class GUI.Input extends GUIInputClasses
{
#private:
	_type = null

	_inputColor = null

	_placeholderColor = null
	_placeholderText = ""

	_paddingPx = 2
	_text = ""
	_hashSymbol = "#"

	_isDotPresent = false
	_isScientificEPresent = false
#public:
	draw = null
	selector = "|"
	maxLetters = 1000

	constructor(arg = null)
	{
		_type = "type" in arg ? arg.type : Input.Text

		_placeholderText = "placeholderText" in arg ? arg.placeholderText : _placeholderText

		_inputColor = Color(255, 255, 255, 255)
		_placeholderColor = Color(255, 255, 255, 255)
		
		if ("paddingPx" in arg)
			_paddingPx = arg.paddingPx
		else if ("padding" in arg)
			_paddingPx = nax(arg.padding)

		_text = "text" in arg ? arg.text : _text
		_hashSymbol = "hashSymbol" in arg ? arg.hashSymbol : _hashSymbol
		selector = "selector" in arg ? arg.selector : selector
		maxLetters = "maxLetters" in arg ? arg.maxLetters : maxLetters

		draw = GUI.Draw("draw" in arg ? arg.draw : null)
		draw.setDisabled(true)

		setInputColor("inputColor" in arg ? arg.inputColor : _inputColor)
		setPlaceholderColor("placeholderColor" in arg ? arg.placeholderColor : _placeholderColor)

		GUI.Texture.constructor.call(this, arg)
		draw.setText(_text != "" ? _text : _placeholderText)
		
		setAlignment("align" in arg ? arg.align : Align.Left)
		bind(EventType.MouseDown, onMouseDown.bindenv(this))
	}

	function setVisible(bool)
	{
		GUI.Texture.setVisible.call(this, bool)
		draw.setVisible(bool)
	}

	function setDisabled(disabled)
	{
		GUI.Texture.setDisabled.call(this, disabled)
		if(disabled && getActive())
			setActive(false)
	}

	function setPositionPx(x, y)
	{
		local positionPx = getPositionPx()
		GUI.Texture.setPositionPx.call(this, x, y)

		local offsetXPx = x - positionPx.x
		local offsetYPx = y - positionPx.y

		local drawPositionPx = draw.getPositionPx()
		draw.setPositionPx(drawPositionPx.x + offsetXPx, drawPositionPx.y + offsetYPx)
	}

	function setSizePx(width, height)
	{
		GUI.Texture.setSizePx.call(this, width, height)
		updateDrawPosition()
	}

	function setAlignment(alignment)
	{
		GUI.Alignment.setAlignment.call(this, alignment)
		updateDrawPosition()
	}

	function getType()
	{
		return _type
	}

	function setType(type)
	{
		if (type == Input.Numbers && _type != Input.Numbers)
		{
			_type = type
			setText("")
		}
		else
		{
			_type = type
			setText(getText())
		}
	}

	function getText()
	{
		return _text
	}

	function setText(text)
	{
		_text = text

		local active = getActive()
		if(!active && _text == "")
		{
			draw.setText(_placeholderText)
			draw.setColor(_placeholderColor)

			updateDrawPosition()
			return
		}

		if(_type == Input.Numbers)
		{
			_isDotPresent = text.find(".") != null
			_isScientificEPresent = text.find("e") != null || text.find("E") != null
		}

		local curText = (_type == Input.Password) ? cutText(hash(_text)) : cutText(_text)
		draw.setText(active ? curText + selector : curText)
		updateDrawPosition()
	}

	function getInputColor()
	{
		return clone _inputColor
	}

	function setInputColor(color)
	{
		local isColorInstance = typeof color == "Color"

		if (isColorInstance || "r" in color)
			_inputColor.r = color.r

		if (isColorInstance || "g" in color)
			_inputColor.g = color.g
		
		if (isColorInstance || "b" in color)
			_inputColor.b = color.b

		if (isColorInstance || "a" in color)
			_inputColor.a = color.a

		if(getActive())
			draw.setColor(color)
	}

	function getPlaceholderColor()
	{
		return clone _placeholderColor
	}

	function setPlaceholderColor(color)
	{
		local isColorInstance = typeof color == "Color"

		if (isColorInstance || "r" in color)
			_placeholderColor.r = color.r

		if (isColorInstance || "g" in color)
			_placeholderColor.g = color.g
		
		if (isColorInstance || "b" in color)
			_placeholderColor.b = color.b

		if (isColorInstance || "a" in color)
			_placeholderColor.a = color.a

		if(!getActive() && _text == "")
			draw.setColor(color)
	}

	function getPaddingPx()
	{
		return _paddingPx
	}

	function setPaddingPx(padding)
	{
		_paddingPx = padding
		updateDrawPosition()
	}

	function getPadding()
	{
		return anx(_paddingPx)
	}

	function setPadding(padding)
	{
		setPaddingPx(nax(padding))
	}

	function getPlaceholderText()
	{
		return _placeholderText
	}

	function setPlaceholderText(text)
	{
		if(!getActive())
		{
			draw.setText(text)
			updateDrawPosition()
		}

		_placeholderText = text
	}

	function getHashSymbol()
	{
		return _hashSymbol
	}

	function setHashSymbol(hashSymbol)
	{
		_hashSymbol = hashSymbol
		setText(_text)
	}

	function getActive()
	{
		return ref.activeInput == this
	}

	function setActive(active)
	{
		if (active && ref.activeInput && ref.activeInput != this)
			ref.activeInput.setActive(false)

		ref.activeInput = (active) ? this.weakref() : null

		setText(_text)
	}

	function cutText(text)
	{
		local sizePx = getSizePx()
		local finishText = ""

		local oldFont = textGetFont()
		textSetFont(draw.getFont())

		for (local i = text.len(); i > 0; i--)
		{
			local char = text.slice(i-1, i);
			if(textWidthPx(finishText + char) < sizePx.width - (2 * _paddingPx))
				finishText = char + finishText
			else
			{
				textSetFont(oldFont)
				return finishText
			}
		}

		textSetFont(oldFont)
		return finishText
	}

	function hash(text)
	{
		local endText = ""
		for (local i = 0, len = text.len(); i < len; i++)
			endText += _hashSymbol

		return endText
	}

	function removeLetter()
	{
		if (_text.len() < 1)
			return

		if (getDisabled())
			return

		setText(_text.slice(0, _text.len()-1))
		call(EventType.RemoveLetter, _text)
		callEvent("GUI.onInputRemoveLetter", this, _text)
	}

	function addLetter(letter)
	{
		if(_text.len() >= maxLetters)
			return

		if (getDisabled())
			return

		if(_type == Input.Numbers)
		{
			if((_text.len() == 0 && (letter == "-" || letter == "+"))
			|| (!_isDotPresent && (letter == "."))
			|| (!_isScientificEPresent && (letter == "e" || letter == "E"))
			|| letter == "0" || letter == "1" || letter == "2" || letter == "3" || letter == "4"
			|| letter == "5" || letter == "6" || letter == "7" || letter == "8" || letter == "9" || letter == "0")
				_text += letter
		}
		else
			_text += letter

		setText(_text)
		call(EventType.InsertLetter, letter)
		callEvent("GUI.onInputInsertLetter", this, letter)
	}

	function updateDrawPosition()
	{
		local positionPx = getPositionPx()
		local sizePx = getSizePx()
		local sizeDrawPx = draw.getSizePx()
		
		switch(_alignment)
		{
			case Align.Left:
				draw.setPositionPx(positionPx.x + _paddingPx, positionPx.y + sizePx.height / 2 - sizeDrawPx.height/2)
				break
				
			case Align.Center:
				draw.setPositionPx(positionPx.x + sizePx.width/2 - sizeDrawPx.width / 2, positionPx.y + sizePx.height/2 - sizeDrawPx.height/2)
				break

			case Align.Right:
				draw.setPositionPx(positionPx.x + sizePx.width - (sizeDrawPx.width + _paddingPx), positionPx.y + sizePx.height/2 - sizeDrawPx.height/2)
				break
		}
	}

	function onMouseDown(self, button)
	{
		if (button != MOUSE_BUTTONLEFT)
			return

		if (ref.activeInput == this)
			return

		setActive(true)
	}

	static function onKeyDown(key)
	{
		if (!ref.activeInput)
			return

		cancelEvent()
	}

	static function onKeyInput(key, letter)
	{
		if (!ref.activeInput)
			return

		if (letter == '\b')
			ref.activeInput.removeLetter()
		else if (letter >= 32)
			ref.activeInput.addLetter(letter.tochar())
	}

	static function hasActiveInput()
	{
		return ref.activeInput != null
	}
}

addEventHandler("onKeyDown", GUI.Input.onKeyDown)
addEventHandler("onKeyInput", GUI.Input.onKeyInput)