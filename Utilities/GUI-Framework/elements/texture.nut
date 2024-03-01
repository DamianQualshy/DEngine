local GUITextureClasses = classes(Texture, GUI.Base, GUI.Event)
class GUI.Texture extends GUITextureClasses
{
#protected:
	_scaling = false

	_FPS = 0

	_beginFrame = 0
	_endFrame = 0
	_direction = 1
	_repeat = true
	_isPlaying = true

	_currentFrame = 0
	_nextFrameTime = 0

	constructor(arg = null)
	{
		Texture.constructor.call(this, 0, 0, 0, 0, "")
		GUI.Base.constructor.call(this, arg)
		GUI.Event.constructor.call(this, arg)

		if ("sizePx" in arg)
			Texture.setSizePx.call(this, arg.sizePx.width, arg.sizePx.height)
		else if("size" in arg)
			Texture.setSize.call(this, arg.size.width, arg.size.height)

		if ("positionPx" in arg)
			Texture.setPositionPx.call(this, arg.positionPx.x, arg.positionPx.y)
		else if("position" in arg)
			Texture.setPosition.call(this, arg.position.x, arg.position.y)
		else if ("relativePositionPx" in arg)
		{
			local collectionPositionPx = collection.getPositionPx()
			Texture.setPositionPx.call(this, collectionPositionPx.x + arg.relativePositionPx.x, collectionPositionPx.y + arg.relativePositionPx.y)
		}
		else if ("relativePosition" in arg)
		{
			local collectionPosition = collection.getPosition()
			Texture.setPosition.call(this, collectionPosition.x + arg.relativePosition.x, collectionPosition.y + arg.relativePosition.y)
		}

		file = "file" in arg ? arg.file : file
		rotation = "rotation" in arg ? arg.rotation : rotation

		if ("color" in arg)
			setColor(arg.color)

		_scaling = "scaling" in arg ? arg.scaling : _scaling
		_FPS = "FPS" in arg ? arg.FPS : _FPS
		_beginFrame = "beginFrame" in arg ? arg.beginFrame : _beginFrame
		_endFrame = "endFrame" in arg ? arg.endFrame : _endFrame
		
		if ("direction" in arg)
			setDirection(arg.direction)

		_repeat = "repeat" in arg ? arg.repeat : _repeat
		_isPlaying = "isPlaying" in arg ? arg.isPlaying : _isPlaying
		_currentFrame = "currentFrame" in arg ? arg.currentFrame : _currentFrame
		
		if (getVisible())
			GUI.Event.setElementPointedByCursor(GUI.Event.findElementPointedByCursor())
	}
	
	function setPositionPx(x, y)
	{
		Texture.setPositionPx.call(this, x, y)
		GUI.Event.setPositionPx.call(this, x, y)
	}

	function getPosition()
	{
		return GUI.Base.getPosition.call(this)
	}

	function setPosition(x, y)
	{
		GUI.Base.setPosition.call(this, x, y)
	}

	function setSizePx(width, height)
	{
		Texture.setSizePx.call(this, width, height)
		GUI.Event.setSizePx.call(this, width, height)
	}

	function getSize()
	{
		return GUI.Base.getSize.call(this)
	}

	function setSize(x, y)
	{
		GUI.Base.setSize.call(this, x, y)
	}

	function top()
	{
		Texture.top.call(this)
		GUI.Event.top.call(this)
	}

	function getColor()
	{
		return clone color
	}

	function setColor(color)
	{
		local isColorInstance = typeof color == "Color"

		if (isColorInstance || "r" in color)
			this.color.r = color.r

		if (isColorInstance || "g" in color)
			this.color.g = color.g

		if (isColorInstance || "b" in color)
			this.color.b = color.b
		
		if (isColorInstance || "a" in color)
			this.color.a = color.a
	}

	function setRotation(rotation)
	{
		this.rotation = rotation
	}

	function getRotation()
	{
		return rotation
	}

	function setVisible(visible)
	{
		this.visible = visible
		GUI.Event.setVisible.call(this, visible)
		GUI.Base.setVisible.call(this, visible)
	}

	function setDisabled(disabled)
	{
		GUI.Event.setDisabled.call(this, disabled)
		GUI.Base.setDisabled.call(this, disabled)
	}

	function getFile()
	{
		return file
	}

	function setFile(file)
	{
		this.file = file
	}

	function getScaling()
	{
		return _scaling
	}

	function setScaling(scaling)
	{
		_scaling = scaling
	}

	function getFPS()
	{
		return _FPS
	}

	function setFPS(FPS)
	{
		_FPS = FPS
	}

	function getBeginFrame()
	{
		return _beginFrame
	}

	function setBeginFrame(beginFrame)
	{
		_beginFrame = beginFrame
	}

	function getEndFrame()
	{
		return _endFrame
	}

	function setEndFrame(endFrame)
	{
		_endFrame = endFrame
	}

	function getCurrentFrame()
	{
		return _currentFrame
	}

	function setCurrentFrame(currentFrame)
	{
		if (currentFrame < _beginFrame)
			currentFrame = _beginFrame
		else if (currentFrame > _endFrame)
			currentFrame = _endFrame

		_currentFrame = currentFrame

		local baseName = ""

		for (local ch = file.len() - 1; ch > 0; --ch)
		{
			if (file[ch] == '_')
			{
				baseName = file.slice(0, ch)
				break
			}
		}

		file = baseName+"_A"+currentFrame+".TGA"
	}

	function getDirection()
	{
		return _direction
	}

	function setDirection(direction)
	{
		if (direction > 1)
			direction = 1
		else if (direction < -1)
			direction = -1

		_direction = direction
	}

	function getRepeat()
	{
		return _repeat
	}

	function setRepeat(repeat)
	{
		_repeat = repeat
	}

	function isPlaying()
	{
		return (_isPlaying && _FPS > 0)
	}

	function play()
	{
		_isPlaying = true
	}

	function stop()
	{
		_isPlaying = false
	}

	static function onRender(self)
	{
		if (!(self instanceof this))
			return

		// FPS Animation

		local now = getTickCount()

		if (self.isPlaying())
		{
			if (now >= self._nextFrameTime)
			{
				if (self._direction == 1 && self._currentFrame < self._endFrame
				|| self._direction == -1 && self._currentFrame > self._beginFrame)
					self._currentFrame += self._direction
				else if (self._repeat)
					self._currentFrame = (self._direction == 1) ? self._beginFrame : self._endFrame

				local baseName = ""

				for (local ch = self.file.len() - 1; ch > 0; --ch)
				{
					if (self.file[ch] == '_')
					{
						baseName = self.file.slice(0, ch)
						break
					}
				}

				self.file = baseName+"_A"+self._currentFrame+".TGA"
				self._nextFrameTime += 1000 / self._FPS
			}
		}
		else
			self._nextFrameTime = now
	}

	static function onChangeResolution()
	{
		local scalingProportion = getResolutionChangedScale()

		foreach (object in _objects)
		{
			if (!(object instanceof this))
				break

			if (!object._scaling)
				continue

			local size = object.getSizePx()
			object.setSizePx(size.width * scalingProportion.x, size.height * scalingProportion.y)
		}
	}
}

addEventHandler("GUI.onRender", GUI.Texture.onRender.bindenv(GUI.Texture))
addEventHandler("onChangeResolution", GUI.Texture.onChangeResolution.bindenv(GUI.Texture))