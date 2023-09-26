local function clamp(x, min, max)
{
	if (x < min)
		return min

	if (x > max)
		return max

	return x
}

local function wrap(x, min, max)
{
	local range_size = max - min + 1

    if (x < min)
        x += range_size * ((min - x) / range_size + 1)

    return min + (x - min) % range_size
}

local function lerp(a, b, t)
{
	return a + (b - a) * t
}

class CameraPoint
{
	position = null
	rotation = null

	positionLerpSpeed = 300 // centimeters per sec
	rotationLerpSpeed = 300 // centimeters per sec

	waitTime = 0

	constructor()
	{
		position = {x = 0, y = 0, z = 0}
		rotation = {x = 0, y = 0, z = 0}
	}

	static function create(arg)
	{
		local point = this()

		if ("position" in arg)
			point.setPosition(arg.position[0], arg.position[1], arg.position[2])

		if ("rotation" in arg)
			point.setRotation(arg.rotation[0], arg.rotation[1], arg.rotation[2])

		if ("lerpSpeed" in arg)
			point.setLerpSpeed(arg.lerpSpeed)
		else
		{
			if ("positionLerpSpeed" in arg)
				point.setPositionLerpSpeed(arg.positionLerpSpeed)

			if ("rotationLerpSpeed" in arg)
				point.setRotationLerpSpeed(arg.rotationLerpSpeed)
		}

		if ("waitTime" in arg)
			point.setWaitTime(arg.waitTime)

		return point
	}

	function setPosition(x,y,z)
	{
		this.position.x = x
		this.position.y = y
		this.position.z = z
	}

	function setRotation(x,y,z)
	{
		this.rotation.x = x
		this.rotation.y = y
		this.rotation.z = z
	}

	function setPositionLerpSpeed(speed)
	{
		this.positionLerpSpeed = speed
	}

	function setRotationLerpSpeed(speed)
	{
		this.rotationLerpSpeed = speed
	}

	function setLerpSpeed(speed)
	{
		this.positionLerpSpeed = speed
		this.rotationLerpSpeed = speed
	}

	function setWaitTime(waitTime)
	{
		this.waitTime = waitTime
	}
}

addEvent("CameraPath.onCreate")
addEvent("CameraPath.onStart")
addEvent("CameraPath.onTransition")
addEvent("CameraPath.onStop")

local activeCameraPath = null

class CameraPath
{
	points = null

	currentPointId = -1
	targetPointId = -1

	currentPositionLerpDuration = -1
	currentRotationLerpDuration = -1
	currentWaitDuration = -1
	currentLerpTime = -1

	isPlaying = false
	isLooping = false

	designerName = ""

	constructor(designerName = "")
	{
		points = []

		if (designerName == "")
		{
			local info = getstackinfos(2)
			designerName = info.src + " line:" + info.line
		}

		this.designerName = designerName

		callEvent("CameraPath.onCreate", this)
	}

	function addPoint(cameraPoint)
	{
		points.push(cameraPoint)
	}

	function createPoint(arg)
	{
		local point = CameraPoint.create(arg)
		this.points.push(point)

		return point
	}

	function _transition(fromId, toId)
	{
		this.currentPointId = fromId
		this.targetPointId = toId

		local currentPoint = points[fromId]
		local targetPoint = points[toId]

		local distance = getDistance3d(currentPoint.position.x, currentPoint.position.y, currentPoint.position.z, targetPoint.position.x, targetPoint.position.y, targetPoint.position.z)

		this.currentPositionLerpDuration = distance / currentPoint.positionLerpSpeed * 1000
		this.currentRotationLerpDuration = distance / currentPoint.rotationLerpSpeed * 1000
		this.currentWaitDuration = ((currentPositionLerpDuration > currentRotationLerpDuration) ? currentPositionLerpDuration : currentRotationLerpDuration) + currentPoint.waitTime

		this.currentLerpTime = 0

		callEvent("CameraPath.onTransition", this, fromId, toId)
	}

	function start()
	{
		if (activeCameraPath != null)
			return

		activeCameraPath = this

		Camera.movementEnabled = false
		Camera.modeChangeEnabled = false

		this.isPlaying = true

		_transition(0, 1)

		Camera.setPosition(this.points[0].position.x, this.points[0].position.y, this.points[0].position.z)
		Camera.setRotation(this.points[0].rotation.x, this.points[0].rotation.y, this.points[0].rotation.z)

		callEvent("CameraPath.onStart", this)
	}

	function stop()
	{
		if (activeCameraPath != this)
			return

		activeCameraPath = null

		Camera.movementEnabled = true
		Camera.modeChangeEnabled = true

		this.currentPointId = -1
		this.targetPointId = -1

		this.currentLerpTime = -1

		this.isPlaying = false

		callEvent("CameraPath.onStop", this)
	}

	function play()
	{
		this.isPlaying = true
	}

	function pause()
	{
		this.isPlaying = false
	}

	function setLooping(looping)
	{
		this.isLooping = looping
	}

	function render(dt)
	{
		if (!isPlaying)
			return

		local currentPoint = this.points[this.currentPointId]
		local targetPoint = this.points[this.targetPointId]

		this.currentLerpTime += dt
		local lerpTimeFloat = this.currentLerpTime.tofloat()

		local tPosition = clamp(lerpTimeFloat / this.currentPositionLerpDuration, 0.0, 1.0)

		Camera.setPosition(
			lerp(currentPoint.position.x, targetPoint.position.x, tPosition)
			lerp(currentPoint.position.y, targetPoint.position.y, tPosition)
			lerp(currentPoint.position.z, targetPoint.position.z, tPosition)
		)

		local tRotation = clamp(lerpTimeFloat / this.currentRotationLerpDuration, 0.0, 1.0)

		Camera.setRotation(
			lerp(currentPoint.rotation.x, targetPoint.rotation.x, tRotation)
			lerp(currentPoint.rotation.y, targetPoint.rotation.y, tRotation)
			lerp(currentPoint.rotation.z, targetPoint.rotation.z, tRotation)
		)

		local tWait = clamp(lerpTimeFloat / this.currentWaitDuration, 0.0, 1.0)

		if(tPosition == 1.0 && tRotation == 1.0 && tWait == 1.0)
		{
			local pointsCount = this.points.len()

			this.currentPointId = wrap(++this.currentPointId, 0, pointsCount - 1)
			this.targetPointId += 1

			if (this.targetPointId != pointsCount)
				_transition(this.currentPointId, this.targetPointId)
			else
			{
				if (!this.isLooping)
					this.stop()
				else
					this._transition(0, 1)
			}
		}
	}
}

local before = getTickCount()
addEventHandler("onRender", function()
{
	local now = getTickCount()

	local dt = now - before

	if (activeCameraPath != null)
		activeCameraPath.render(dt)

	before = now
})
