local GUITextureClasses = classes(Texture, GUI.Base)
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

	constructor(x, y, width, height, file, window = null)
	{
		GUI.Base.constructor.call(this)
		Texture.constructor.call(this, x, y, width, height, file)

		_nextFrameTime = getTickCount()

		if (window)
			window.insert(this)
	}

	function setPositionPx(x, y)
	{
		Texture.setPositionPx.call(this, x, y)
		GUI.Base.setPositionPx.call(this, x, y)
	}

	function setPosition(x, y)
	{
		Texture.setPosition.call(this, x, y)
		GUI.Base.setPosition.call(this, x, y)
	}

	function setSizePx(width, height)
	{
		Texture.setSizePx.call(this, width, height)
		GUI.Base.setSizePx.call(this, width, height)
	}

	function setSize(width, height)
	{
		Texture.setSize.call(this, width, height)
		GUI.Base.setSize.call(this, width, height)
	}

	function top()
	{
		GUI.Base.top.call(this)
		Texture.top.call(this)
	}

	function getAlpha()
	{
		return alpha
	}

	function setAlpha(alpha)
	{
		this.alpha = alpha
	}

	function getVisible()
	{
		return visible
	}

	function setVisible(visible)
	{
		GUI.Base.setVisible.call(this, visible)
		this.visible = visible
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
