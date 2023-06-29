local GUIItemRenderClasses = classes(ItemRender, GUI.Base)
class GUI.ItemRender extends GUIItemRenderClasses {
	constructor(x, y, width, height, instance, window = null)
	{
		GUI.Base.constructor.call(this)
		ItemRender.constructor.call(this, x, y, width, height, instance)

		if (window)
			window.insert(this)
	}

	function setPositionPx(x, y)
	{
		ItemRender.setPositionPx.call(this, x, y)
		GUI.Base.setPositionPx.call(this, x, y)
	}

	function setPosition(x, y)
	{
		ItemRender.setPosition.call(this, x, y)
		GUI.Base.setPosition.call(this, x, y)
	}

	function setSizePx(width, height)
	{
		ItemRender.setSizePx.call(this, width, height)
		GUI.Base.setSizePx.call(this, width, height)
	}

	function setSize(width, height)
	{
		ItemRender.setSize.call(this, width, height)
		GUI.Base.setSize.call(this, width, height)
	}

	function top()
	{
		GUI.Base.top.call(this)
		ItemRender.top.call(this)
	}

	function getVisible()
	{
		return	this.visible
	}

	function setVisible(visible)
	{
		GUI.Base.setVisible.call(this, visible)
		this.visible = visible
	}

	function setRotation(rotX, rotY, rotZ)
	{
		this.rotX = rotX
		this.rotY = rotY
		this.rotZ = rotZ
	}

	function getRotation(rotX, rotY, rotZ)
	{
		return	{
			rotX = this.rotX,
			rotY = this.rotY,
			rotZ = this.rotZ,
		}
	}

	function setZbias(zbias)
	{
		this.zbias = zbias
	}

	function getZbias()	{
		return this.zbias
	}

	function setLightingswell(lightingswell)
	{
		this.lightingswell = lightingswell
	}

	function getLightingswell()
	{
		return this.lightingswell
	}

	function setVisual(visual)
	{
		this.visual = visual
	}

	function getVisual()
	{
		return this.visual
	}

	function setInstance(instance)
	{
		this.instance = instance
	}

	function getInstance()
	{
		return this.instance
	}
}
