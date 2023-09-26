class GUI.CheckBox extends GUI.Button
{
#protected:
	_checkedFile = ""
	_uncheckedFile = ""

	_checked = false

#public:
	constructor(arg = null)
	{
		base.constructor(arg)

		_checkedFile = "checkedFile" in arg ? arg.checkedFile : file
		_uncheckedFile = "uncheckedFile" in arg ? arg.uncheckedFile : file

		if ("checked" in arg)
			setChecked(arg.checked)

		if (!("file" in arg))
			file = _checked ? _checkedFile : _uncheckedFile

		this.bind(EventType.Click, onClick)
	}

	function setVisible(visible)
	{
		GUI.Texture.setVisible.call(this, visible)

		if (draw && _checked)
			draw.setVisible(visible)
	}

	function getCheckedFile()
	{
		return _checkedFile
	}

	function setCheckedFile(checkedFile)
	{
		_checkedFile = checkedFile
		file = _checked ? _checkedFile : _uncheckedFile
	}

	function getUncheckedFile()
	{
		return _uncheckedFile
	}

	function setUncheckedFile(uncheckedFile)
	{
		_uncheckedFile = uncheckedFile
		file = _checked ? _checkedFile : _uncheckedFile
	}

	function getChecked()
	{
		return _checked
	}

	function setChecked(checked)
	{
		_checked = checked

		if (draw && _visible)
			draw.setVisible(checked)
		
		file = checked ? _checkedFile : _uncheckedFile
	}

	function onClick(self)
	{
		if (self.isCancelled())
			return

		self.setChecked(!self._checked)
	}
}