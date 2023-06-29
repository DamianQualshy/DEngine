class GUI.RadioButton extends GUI.CheckBox
{
#private:
	_group = null

#public:
	static activeRadio = {}

	constructor(x, y, width, height, file, selector, group = null, window = null)
	{
		base.constructor(x, y, width, height, file, selector, window)

		if (group)
			setGroup(group)

		enableDeselection(false)
	}

	function destroy()
	{
		if (activeRadio[_group] == this)
			activeRadio[_group] = null

		base.destroy()
	}

	function getGroup()
	{
		return _group
	}

	function setGroup(group)
	{
		if (_group != null)
			delete activeRadio[_group]

		_group = group

		if (group != null)
		{
			if (!(group in activeRadio))
				activeRadio[group] <- null
		}
	}

	function setChecked(checked)
	{
		if (_group != null && checked)
		{
			if (this == GUI.RadioButton.activeRadio[_group])
				return

			if (GUI.RadioButton.activeRadio[_group] != null)
				GUI.RadioButton.activeRadio[_group].setChecked(false)

			GUI.RadioButton.activeRadio[_group] = this
			base.setChecked(checked)
		}
		else
			base.setChecked(checked)
	}
}
