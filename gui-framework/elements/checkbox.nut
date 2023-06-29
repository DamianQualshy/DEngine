class GUI.CheckBox extends GUI.Button
{
#protected:
	_originalTexture = null
	_selector = null

	_checked = false
	_enableDeselection = true

#public:
	constructor(x, y, width, height, file, selector, window = null)
	{
		if (selector.len() >= 4 && selector.slice(selector.len() - 4).toupper() == ".TGA")
		{
			base.constructor(x, y, width, height, file, null, window)
			_originalTexture = file
		}
		else
		{
			base.constructor(x, y, width, height, file, selector, window)
		}

		_selector = selector
	}

	function setText(text)
	{
		base.setText(text)

		if (draw)
			_selector = text
	}

	function setVisible(visible)
	{
		GUI.Texture.setVisible.call(this, visible)

		if (draw && _checked)
			draw.setVisible(visible)
	}

	function setFile(file)
	{
		if (draw)
			base.setFile(file)
		else
		{
			if (!_checked)
				base.setFile(file)
			else
				_originalTexture = file
		}
	}

	function getChecked()
	{
		return _checked
	}

	function setChecked(checked)
	{
		_checked = checked

		if (draw)
		{
			if (_visible)
				draw.setVisible(checked)
		}
		else
			file = (checked) ? _selector : _originalTexture
	}

	function getSelector()
	{
		return _selector
	}

	function setSelector(text)
	{
		if (draw)
			draw.setText(text)
		else
			_selector = text
	}

	function enableDeselection(deselection)
	{
		_enableDeselection = deselection
	}

	static function onClick(self)
	{
        if (!(self instanceof this))
            return

		if (self._checked && !self._enableDeselection)
			return

		self._checked = !self._checked
		self.setChecked(self._checked)
	}
}

addEventHandler("GUI.onClick", GUI.CheckBox.onClick.bindenv(GUI.CheckBox))
