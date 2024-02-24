class GUI.Collection extends GUI.Base
{
#private:
	_positionPx = null

#public:
	childs = null

	constructor(arg = null)
	{
		base.constructor(arg)

		if ("positionPx" in arg)
			_positionPx = {x = arg.positionPx.x, y = arg.positionPx.y}
		else if("position" in arg)
			_positionPx = {x = nax(arg.position.x), y = nay(arg.position.y)}
		else if ("relativePositionPx" in arg)
		{
			local collectionPositionPx = collection.getPositionPx()
			_positionPx = {x = collectionPositionPx.x + arg.relativePositionPx.x, y = collectionPositionPx.y + arg.relativePositionPx.y}
		}
		else if ("relativePosition" in arg)
		{
			local collectionPositionPx = collection.getPositionPx()
			_positionPx = {x = collectionPositionPx.x + nax(arg.relativePosition.x), y = collectionPositionPx.y + nay(arg.relativePosition.y)}
		}
		else
			_positionPx = {x = 0, y = 0}

		childs = []
	}

	function add(child)
	{
		insert(childs.len(), child)
	}

	function insert(idx, child)
	{
		childs.insert(idx, child)
		child.collection = this
	}

	function remove(child)
	{
		childs.remove(childs.find(child))
	}

	function getPositionPx()
	{
		return _positionPx
	}

	function setPositionPx(x, y)
	{
		local offsetXPx = x - _positionPx.x
		local offsetYPx = y - _positionPx.y

		_positionPx.x = x
		_positionPx.y = y

		foreach(child in childs)
		{
			local childPositionPx = child.getPositionPx()
			child.setPositionPx(childPositionPx.x + offsetXPx, childPositionPx.y + offsetYPx)
		}
	}

	function setVisible(visible)
	{
		foreach (child in childs)
			child.setVisible(visible)
		
		base.setVisible(visible)
	}

	function setDisabled(disabled)
	{
		foreach (child in childs)
			child.setDisabled(disabled)
		
		base.setDisabled(disabled)
	}

	function top()
	{
		foreach (child in childs)
			child.top()
	}
}