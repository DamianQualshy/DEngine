enum Input
{
    Text,
    Password,
    Numbers
}

local activeInput = null

class GUI.Input extends GUI.Texture
{
#private:
    _type = null
    _align = null
    _inputColor = null
    _inputAlpha = 255
    _placeholderColor = null
    _placeholderAlpha = 255
    _placeholderText = ""
    _margin = 2
    _text = ""
    _isDotPresent = false
    _isScientificEPresent = false
    _hashSymbol = "#"
#public:
    draw = null
    distance = null
    selector = "|"
    maxLetters = 1000

    constructor(x, y, w, h, file, font, type, align = Align.Left, placeholderText = "", margin = 2, window = null)
    {
		draw = GUI.Draw(x, y, placeholderText)
		draw.setDisabled(true)
        draw.setFont(font)

        _inputColor = {r = 255, g = 255, b = 255}
        _placeholderColor = {r = 255, g = 255, b = 255}
        _placeholderText = placeholderText

        _align = align
        _type = type
        _margin = margin

		base.constructor(x, y, w, h, file, window)
		draw.top()

        alignText()
    }

    function alignText()
    {
        local pos = base.getPositionPx()
        local size = base.getSizePx()
        local sizeDraw = draw.getSizePx()
        switch(_align)
        {
            case Align.Left:
                draw.setPositionPx(pos.x + _margin, pos.y + size.height/2 - sizeDraw.height/2)
                break
            case Align.Center:
                draw.setPositionPx(pos.x + size.width/2 - sizeDraw.width/2, pos.y + size.height/2 - sizeDraw.height/2)
                break
            case Align.Right:
                draw.setPositionPx(pos.x + size.width - (sizeDraw.width + _margin), pos.y + size.height/2 - sizeDraw.height/2)
                break
        }
    }

    function setVisible(bool)
    {
        base.setVisible(bool)
        draw.setVisible(bool)
    }

    function destroy()
	{
		base.destroy()
		draw.destroy()
	}

    function setPosition(x, y)
    {
        setPositionPx(nax(x), nay(y))
    }

    function setPositionPx(x, y)
    {
        base.setPositionPx(x, y)
        alignText()
    }

    function getColor()
    {
        return _inputColor
    }

    function setColor(r, g, b)
    {
        _inputColor.r = r
        _inputColor.g = g
        _inputColor.b = b

        if(getActive() || _text != "")
            draw.setColor(_inputColor.r, _inputColor.g, _inputColor.b)
    }

    function getAlpha()
    {
        return _inputAlpha
    }

    function setAlpha(alpha)
    {
        draw.setAlpha(alpha)
        base.setAlpha(alpha)

        _inputAlpha = alpha

        if(getActive() || _text != "")
            draw.setAlpha(_inputAlpha)
    }

    function setText(text)
    {
        _text = text

        local active = getActive()

        if(!active && _text == "")
        {
            draw.setText(_placeholderText)
            draw.setColor(_placeholderColor.r, _placeholderColor.g, _placeholderColor.b)
            draw.setAlpha(_placeholderAlpha)
            alignText()

            return
        }
        else if (active)
        {
            draw.setColor(_inputColor.r, _inputColor.g, _inputColor.b)
            draw.setAlpha(_inputAlpha)
        }

        if(_type == Input.Numbers)
        {
            _isDotPresent = text.find(".") != null
            _isScientificEPresent = text.find("e") != null || text.find("E") != null
        }

        if(active)
        {
            if(_type == Input.Password)
                draw.setText(cutText(hash(_text) + selector))
            else
                draw.setText(cutText(_text + selector))
        }
        else
        {
            if(_type == Input.Password)
                draw.setText(cutText(hash(_text)))
            else
                draw.setText(cutText(_text))
        }

        alignText()
    }

    function getText()
    {
        return _text
    }

    function setPlaceholderColor(r, g, b)
    {
        _placeholderColor.r = r
        _placeholderColor.g = g
        _placeholderColor.b = b

        if(!getActive() && _text == "")
            draw.setColor(_placeholderColor.r, _placeholderColor.g, _placeholderColor.b)
    }

    function getPlaceholderColor()
    {
        return _placeholderColor
    }

    function setPlaceholderAlpha(alpha)
    {
        _placeholderAlpha = alpha

        if(!getActive() && _text == "")
            draw.setAlpha(_placeholderAlpha)
    }

    function getPlaceholderAlpha()
    {
        return _placeholderAlpha
    }

    function setPlaceholderText(holder)
    {
        if(!getActive() && _text == "")
        {
            draw.setText(holder)
            alignText()
        }

        _placeholderText = holder

    }

    function getPlaceholderText()
    {
        return _placeholderText
    }

    function getHashSymbol() {
        return _hashSymbol
    }

    function setHashSymbol(hashSymbol) {
        _hashSymbol = hashSymbol
        setText(_text)
    }

    function setDisabled(disable)
    {
        setActive(false)
        base.setDisabled(disable)

        if(disable && getActive())
            setActive(false)
    }

    function getActive()
    {
        return activeInput == this
    }

    function setActive(active)
    {
        if (active && activeInput && activeInput != this)
            activeInput.setActive(false)

        activeInput = (active) ? this : null

        setText(_text)
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

    function getType()
    {
        return _type
    }

    static function cutText(text)
    {
        local size = base.getSizePx()
        local finishText = ""

        local oldFont = textGetFont()
		textSetFont(draw.getFont())

        for (local i = text.len(); i > 0; i--)
        {
            local char = text.slice(i-1, i);
            if(textWidthPx(finishText + char) < size.width - (2*_margin))
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
        for(local i = 0, len = text.len(); i < len; i++)
            endText += _hashSymbol

        return endText
    }

    function removeLetter()
    {
        if(_text.len() < 1)
            return

        setText(_text.slice(0, _text.len()-1))

        if(!base.getDisabled())
        {
            call(EventType.RemoveLetter, _text)
            callEvent("GUI.onInputRemoveLetter", this, _text)
        }
    }

    function addLetter(key)
    {
        if(_text.len() >= maxLetters)
            return

        local letter = getKeyLetter(key)

        if(!letter)
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

        if(!base.getDisabled())
        {
            call(EventType.InsertLetter, letter)
            callEvent("GUI.onInputInsertLetter", this, letter)
        }
    }

    static function onKey(key)
    {
        if (!activeInput)
            return

        cancelEvent()

        if(key == KEY_BACK)
            activeInput.removeLetter()
        else
            activeInput.addLetter(key)

        activeInput.alignText()
    }

    static function onMouseClick(button)
    {
        if (button != MOUSE_LMB)
			return

        if (!activeInput)
            return

        if (GUI.Base.getElementPointedByCursor() instanceof this)
            return

        activeInput.setActive(false)
    }

    static function onMouseDown(self, button)
    {
        if (button != MOUSE_LMB)
			return

		if (!(self instanceof this))
			return

        if (activeInput == self)
            return

        self.setActive(true)
    }

    static function hasActiveInput()
    {
        return activeInput != null
    }
}

addEventHandler("onKey", GUI.Input.onKey)
addEventHandler("onMouseClick", GUI.Input.onMouseClick.bindenv(GUI.Input))
addEventHandler("GUI.onMouseDown", GUI.Input.onMouseDown.bindenv(GUI.Input))
