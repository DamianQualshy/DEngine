class GUI.PasswordInput extends GUI.Input
{
	// Variables for configuration:
	_hashSymbol = "#"

	constructor(arg)
	{
		base.constructor(arg)
		setHashSymbol("hashSymbol" in arg ? arg.hashSymbol : _hashSymbol)
	}

	function getHashSymbol() {
		return _hashSymbol
	}

	function setHashSymbol(hashSymbol)
	{
		_hashSymbol = hashSymbol
		_updateTextFromLen()
	}

	function _updateVisibleText(visibleText)
	{
		local hashString = ""
		foreach (letter in visibleText)
			hashString += "#"

		_visibleText = hashString
	}
}