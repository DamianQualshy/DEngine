class GUI.Collection
{
#private:
	_positionPx = null
	_visible = false

#public:
	childs = null

	constructor(x, y)
	{
		_positionPx = { x = nax(x), y = nay(y) }
		childs = []
	}

	function destroy()
	{
		foreach (item in childs)
			item.pointer.destroy()
	}

	function insert(pointer)
	{
		if (getChildIdx(pointer) != -1)
			return

		local bodyPos = getPositionPx()
		local childPos = pointer.getPositionPx()

		childs.push({offset = clone childPos, pointer = pointer})
		pointer.setPositionPx(bodyPos.x + childPos.x, bodyPos.y + childPos.y)
	}

	function remove(pointer)
	{
		childs.remove(getChildIdx(pointer))
	}

	function getChildIdx(pointer)
	{
		for(local i = 0, end = childs.len(); i < end; ++i)
		{
			if (childs[i].pointer == pointer)
				return i
		}

		return -1
	}

	function getPositionPx()
	{
        return _positionPx
	}

	function getPosition()
	{
        return { x = nax(_positionPx.x), y = nay(_positionPx.y) }
	}

	function setPosition(x, y)
	{
		setPositionPx(nax(x), nay(y))
	}

	function setPositionPx(x, y)
	{
		_positionPx.x = x
		_positionPx.y = y

		foreach(item in childs)
			item.pointer.setPositionPx(item.offset.x + x, item.offset.y + y)
	}

	function getChildPositionPx(pointer)
	{
		return childs[getChildIdx(pointer)]
	}

	function setChildPositionPx(pointer, x, y)
	{
		local bodyPos = getPositionPx()
		local child = childs[getChildIdx(pointer)]

		child.offset.x = x
		child.offset.y = y

		pointer.setPositionPx(bodyPos.x + x, bodyPos.y + y)
	}

	function getChildPosition(pointer)
	{
		local position = getChildPositionPx(pointer)
		return {x = anx(position.x), y = anx(position.y)}
	}

	function setChildPosition(pointer, x, y)
	{
		setChildPositionPx(pointer, nax(x), nay(y))
	}

	function getVisible()
	{
		return _visible
	}

	function setVisible(visible)
	{
		foreach (item in childs)
			item.pointer.setVisible(visible)
		
		_visible = visible
	}

	function top()
	{
		foreach (item in childs)
			item.pointer.top()
	}
}
