local GUIButtonClasses = classes(GUI.Texture, GUI.Alignment, GUI.Offset)
class GUI.Button extends GUIButtonClasses
{
#public:
	draw = null

	constructor(arg = null)
	{
		if ("draw" in arg)
		{
			draw = GUI.Draw(arg.draw)
			draw.setDisabled(true)

			GUI.Offset.constructor.call(this, arg)
			_alignment = "align" in arg ? arg.align : Align.Center
		}

		GUI.Texture.constructor.call(this, arg)
		if (draw)
			alignDraw()
	}

	function setOffsetPx(x, y)
	{
		GUI.Offset.setOffsetPx.call(this, x, y)

		if (draw)
			alignDraw()
	}

	function setAlignment(alignment)
	{
		GUI.Alignment.setAlignment.call(this, alignment)

		if (draw)
			alignDraw()
	}

	function setVisible(visible)
	{
		GUI.Texture.setVisible.call(this, visible)

		if (draw)
			draw.setVisible(visible)
	}

	function top()
	{
		GUI.Texture.top.call(this)

		if (draw)
			draw.top()
	}

	function setPositionPx(x, y)
	{
		local positionPx = getPositionPx()
		GUI.Texture.setPositionPx.call(this, x, y)

		if (draw)
		{
			local offsetXPx = x - positionPx.x
			local offsetYPx = y - positionPx.y

			local drawPositionPx = draw.getPositionPx()
			draw.setPositionPx(drawPositionPx.x + offsetXPx, drawPositionPx.y + offsetYPx)
		}
	}

	function setSizePx(width, height)
	{
		GUI.Texture.setSizePx.call(this, width, height)

		if (draw)
			alignDraw()
	}

	function getText()
	{
		if (!draw)
			return ""

		return draw.getText()
	}

	function setText(text)
	{
		if (!draw)
			return

		draw.setText(text)
		alignDraw()
	}

	function getFont()
	{
		if (!draw)
			return ""

		return draw.getFont()
	}

	function setFont(font)
	{
		if (!draw)
			return

		draw.setFont(font)
		alignDraw()
	}

	function setScale(x, y)
	{
		if (!draw)
			return

		draw.setScale(x, y)
		alignDraw()
	}

	function alignDraw()
	{
		local positionPx = getPositionPx()
		local offsetPx = getOffsetPx()
		local sizePx = getSizePx()
		local drawSizePx = draw.getSizePx()
		local drawPositionXPx = positionPx.x + offsetPx.x
		local drawPositionYPx = positionPx.y + offsetPx.y + (sizePx.height > 0 ? (sizePx.height - drawSizePx.height) / 2 : 0)

		switch (_alignment)
		{
			case Align.Left:
				draw.setPositionPx(drawPositionXPx, drawPositionYPx)
				break

			case Align.Center:
				draw.setPositionPx(drawPositionXPx + (sizePx.width - drawSizePx.width) / 2, drawPositionYPx)
				break

			case Align.Right:
				draw.setPositionPx(drawPositionXPx + sizePx.width - drawSizePx.width, drawPositionYPx)
				break
		}		
	}
}