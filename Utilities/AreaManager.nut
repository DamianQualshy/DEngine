class Area
{
	points = null

	minY = null
	maxY = null

	bbox = null

	world = null

	constructor(arg)
	{
		points = arg.points
		world = arg.world.toupper()

		if ("minY" in arg)
			minY = arg.minY

		if ("maxY" in arg)
			maxY = arg.maxY

		local pointsCount = points.len()

		if (pointsCount < 1)
			return

		bbox = {minX = points[0].x, maxX = points[0].x, minZ = points[0].z, maxZ = points[0].z}

		for (local i = 1; i < pointsCount; ++i)
		{
			local point = points[i]

			if (bbox.minX > point.x)
				bbox.minX = point.x

			if (bbox.maxX < point.x)
				bbox.maxX = point.x

			if (bbox.minZ > point.z)
				bbox.minZ = point.z

			if (bbox.maxZ < point.z)
				bbox.maxZ = point.z
		}
	}

	function isIn(x, y, z, world)
	{
		if (world != this.world)
			return false

		if (minY != null && maxY != null
			&& y > maxY || y < minY)
			return false

		if (bbox != null
			&& (x < bbox.minX || x > bbox.maxX || z < bbox.minZ || z > bbox.maxZ))
			return false

		local pointsCount = points.len()
		local j = pointsCount - 1

		local isIn = false

		for (local i = 0; i < pointsCount; j = i++)
		{
			if ( (points[i].z > z) != (points[j].z > z)
			&& (x < (points[j].x - points[i].x) * (z - points[i].z) / (points[j].z - points[i].z) + points[i].x) )
			{
				isIn = !isIn
			}
		}

		return isIn
	}
}


AreaManager <- {
	worlds = {}

	enterCallbacks = {}
	exitCallbacks = {}
}

function AreaManager::add(area, onEnter, onExit)
{
	if (!(area.world in worlds))
		worlds[area.world] <- []

	local areas = worlds[area.world]
	local idx = areas.find(area)

	if (idx == null)
	{
		areas.push(area)

		enterCallbacks[area] <- onEnter
		exitCallbacks[area] <- onExit

		return true
	}

	return false
}

function AreaManager::remove(area)
{
	local areas = worlds[area.world]
	local idx = areas.find(area)

	if (idx != null)
	{
		areas.remove(idx)

		delete enterCallbacks[area]
		delete exitCallbacks[area]

		return true
	}

	return false
}

if (CLIENT_SIDE)
{
	AreaManager.heroAreas <- {}

	function AreaManager::process()
	{
		local heroWorld = getWorld()

		if (!(heroWorld in worlds))
			return

		local areas = worlds[heroWorld]
		local heroPosition = getPlayerPosition(heroId)

		foreach (area in areas)
		{
			local isIn = area.isIn(heroPosition.x, heroPosition.y, heroPosition.z, heroWorld)

			if (!(area in heroAreas) && isIn)
			{
				heroAreas[area] <- true
				enterCallbacks[area]()
			}
			else if ((area in heroAreas) && !isIn)
			{
				delete heroAreas[area]
				exitCallbacks[area]()
			}
		}
	}
}

else if (SERVER_SIDE)
{
	AreaManager.playersAreas <- []

	for (local pid = 0, end = getMaxSlots(); pid < getMaxSlots(); ++pid)
		AreaManager.playersAreas.push({})

	function AreaManager::process()
	{
		for (local pid = 0, end = getMaxSlots(); pid < getMaxSlots(); ++pid)
		{
			if (!isPlayerSpawned(pid))
				continue

			local playerWorld = getPlayerWorld(pid)

			if (!(playerWorld in worlds))
				continue

			local areas = worlds[playerWorld]

			local playerAreas = playersAreas[pid]
			local playerPosition = getPlayerPosition(pid)

			foreach (area in areas)
			{
				local isIn = area.isIn(playerPosition.x, playerPosition.y, playerPosition.z, playerWorld)

				if (!(area in playerAreas) && isIn)
				{
					playerAreas[area] <- true
					enterCallbacks[area](pid)
				}
				else if ((area in playerAreas) && !isIn)
				{
					delete playerAreas[area]
					exitCallbacks[area](pid)
				}
			}
		}
	}
}

setTimer(function()
{
	AreaManager.process()
}, 500, 0)
