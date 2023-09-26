// locals

local freeCamEnabled = false
local freeCamPaused = false

local freeCamMovementSpeed = 300.0 // centimeters per sec
local freeCamRotationSpeed = 100.0 // centimeters per sec

local function toggleEventHandler(toggle, name, handler)
{
	local func = toggle ? addEventHandler : removeEventHandler
	func(name, handler)
}

local function onMouseMove(x, y)
{
	if (freeCamPaused)
		return

	local cameraRotation = Camera.getRotation()
	local resolution = getResolution()

	cameraRotation.x += x / resolution.x.tofloat() * freeCamRotationSpeed
	cameraRotation.y += y / resolution.y.tofloat() * freeCamRotationSpeed

	Camera.setRotation(cameraRotation.x, cameraRotation.y, cameraRotation.z)
}

local function onRender()
{
	if (freeCamPaused)
		return

	if (chatInputIsOpen())
		return

	local cameraPosition = Camera.getPosition()
	local cameraRotation = Camera.getRotation()

	local deltaTime = WorldTimer.frameTimeSecs

	local movementAcceleration = freeCamMovementSpeed * deltaTime
	local rotationAcceleration = freeCamRotationSpeed * deltaTime

	local vecForward = Camera.vobMatrix.getAtVector()
	local vecRight = Camera.vobMatrix.getRightVector()

	local isForwardKeyPressed = isKeyPressed(KEY_UP) || isKeyPressed(KEY_W)
	local isBackwardKeyPressed = isKeyPressed(KEY_DOWN) || isKeyPressed(KEY_S)

	local isControlPressed = isKeyPressed(KEY_LCONTROL) || isKeyPressed(KEY_RCONTROL)

	if (isKeyPressed(KEY_LSHIFT) || isKeyPressed(KEY_RSHIFT))
	{
		movementAcceleration *= 3
		rotationAcceleration *= 1.5
	}

	if (isForwardKeyPressed && !isBackwardKeyPressed)
		cameraPosition += vecForward * movementAcceleration
	else if (isBackwardKeyPressed && !isForwardKeyPressed)
		cameraPosition -= vecForward * movementAcceleration

	if (isKeyPressed(KEY_LEFT) && !isKeyPressed(KEY_RIGHT))
		if (!isControlPressed)
			cameraRotation.y -= rotationAcceleration
		else
			cameraRotation.z -= rotationAcceleration
	else if (isKeyPressed(KEY_RIGHT) && !isKeyPressed(KEY_LEFT))
		if (!isControlPressed)
			cameraRotation.y += rotationAcceleration
		else
			cameraRotation.z += rotationAcceleration

	if (isKeyPressed(KEY_SPACE) && !isKeyPressed(KEY_X))
		cameraPosition.y += movementAcceleration
	else if (isKeyPressed(KEY_X) && !isKeyPressed(KEY_SPACE))
		cameraPosition.y -= movementAcceleration

	if (isKeyPressed(KEY_NEXT) && !isKeyPressed(KEY_PRIOR))
		cameraRotation.x += rotationAcceleration
	else if (isKeyPressed(KEY_PRIOR) && !isKeyPressed(KEY_NEXT))
		cameraRotation.x -= rotationAcceleration

	if (isKeyPressed(KEY_A) && !isKeyPressed(KEY_D))
		cameraPosition -= vecRight * movementAcceleration
	else if (isKeyPressed(KEY_D) && !isKeyPressed(KEY_A))
		cameraPosition += vecRight * movementAcceleration

	Camera.setPosition(cameraPosition.x, cameraPosition.y, cameraPosition.z)
	Camera.setRotation(cameraRotation.x, cameraRotation.y, cameraRotation.z)
}

// public functions

isFreeCamEnabled <- @() freeCamEnabled
function enableFreeCam(toggle)
{
	if (freeCamEnabled == toggle)
		return

	Camera.modeChangeEnabled = !toggle
	Camera.movementEnabled = !toggle

	setFreeze(toggle)

	toggleEventHandler(toggle, "onRender", onRender)
	toggleEventHandler(toggle, "onMouseMove", onMouseMove)

	freeCamEnabled = toggle
}

isFreeCamPaused <- @() freeCamPaused
function pauseFreeCam(toggle)
{
	if (freeCamPaused == toggle)
		return

	freeCamPaused = toggle
}

getFreeCamMovementSpeed <- @() freeCamMovementSpeed
function setFreeCamMovementSpeed(speed)
{
	freeCamMovementSpeed = speed
}

getFreeCamRotationSpeed <- @() freeCamRotationSpeed
function setFreeCamRotationSpeed(speed)
{
	freeCamRotationSpeed = speed
}
