class GUI.RadioButton extends GUI.CheckBox
{
#private:
	_group = null

#public:
	static activeRadio = {}

	constructor(arg = null)
	{
		base.constructor(arg)

		if ("group" in arg)
			setGroup(arg.group)
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
		if (_group == null)
			return

		if (checked)
		{
			if (this == activeRadio[_group])
				return

			if (activeRadio[_group] != null)
				activeRadio[_group].setChecked(false)

			activeRadio[_group] = this.weakref()
			base.setChecked(checked)
		}
		else
			base.setChecked(checked)
	}

	function onClick(self)
	{
		if (self.isCancelled())
			return

		if (self.getChecked())
 			return

		base.onClick(self)
	}
}