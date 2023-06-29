local GUIButtonClasses = classes(GUI.Texture, GUI.Alignment, GUI.Offset)
class GUI.Button extends GUIButtonClasses
{
#public:
	draw = null

	constructor(x, y, width, height, file, text = null, window = null)
	{
		GUI.Texture.constructor.call(this, x, y, width, height, file, window)

		if (text != null)
		{
			draw = GUI.Draw(0, 0, text)
			draw.setDisabled(true)

			GUI.Offset.constructor.call(this)
			setAlignment(Align.Center)
		}
	}

	function destroy()
	{
		if (draw)
			draw = draw.destroy()

		GUI.Texture.destroy.call(this)
	}

	function setOffsetPx(x, y)
	{
		GUI.Offset.setOffsetPx.call(this, x, y)
		setAlignment(getAlignment())
	}

	function setOffset(x, y)
	{
		setOffsetPx(nax(x), nay(y))
	}

	function setAlignment(alignment)
	{
		GUI.Alignment.setAlignment.call(this, alignment)

		local position = getPositionPx()
		local size = getSizePx()

		switch (alignment)
		{
			case Align.Left:
				draw.leftPx(position.x + _offsetPx.x, position.y + _offsetPx.y, size.width, size.height)
				break

			case Align.Center:
				draw.centerPx(position.x + _offsetPx.x, position.y + _offsetPx.y, size.width, size.height)
				break

			case Align.Right:
				draw.rightPx(position.x + _offsetPx.x, position.y + _offsetPx.y, size.width, size.height)
				break
		}
	}

	function setVisible(visible)
	{
		GUI.Texture.setVisible.call(this, visible)

		if (draw)
			draw.setVisible(visible)
	}

	function setAlpha(alpha)
	{
		GUI.Texture.setAlpha.call(this, alpha)

		if (draw)
			draw.setAlpha(alpha)
	}

	function top()
	{
		GUI.Texture.top.call(this)

		if (draw)
			draw.top()
	}

	function setPositionPx(x, y)
	{
		GUI.Texture.setPositionPx.call(this, x, y)

		if (draw)
			setAlignment(getAlignment())
	}

	function setPosition(x, y)
	{
		setPositionPx(nax(x), nay(y))
	}

	function setSizePx(width, height)
	{
		GUI.Texture.setSizePx.call(this, width, height)

		if (draw)
			setAlignment(getAlignment())
	}

	function setSize(x, y)
	{
		setSizePx(nax(x), nay(y))
	}

	function getText()
	{
		return draw.getText()
	}

	function setText(text)
	{
		draw.setText(text)
		setAlignment(getAlignment())
	}

	function setFont(font)
	{
		if (!draw)
			return

		draw.setFont(font)
		setAlignment(_alignment)
	}
}
