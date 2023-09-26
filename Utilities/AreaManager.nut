class Area
{
	name = null
	world = null

	points = null

	minY = null
	maxY = null

	constructor(arg)
	{
		name = arg.name
		points = arg.points
		world = arg.world.toupper()

		if ("minY" in arg)
			minY = arg.minY

		if ("maxY" in arg)
			maxY = arg.maxY
	}

	function isIn(x, y, z, world)
	{
		if (world != this.world)
			return false

		if (minY != null && maxY != null
			&& y > maxY || y < minY)
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
}

function AreaManager::add(area)
{
	if (!(area.world in worlds))
		worlds[area.world] <- []

	local areas = worlds[area.world]
	local idx = areas.find(area)

	if (idx == null)
	{
		areas.push(area)

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

		return true
	}

	return false
}

if (CLIENT_SIDE)
{
	addEvent("onEnterZone");
	addEvent("onExitZone");

	AreaManager.heroAreas <- {}

	function AreaManager::process()
	{
		local heroWorld = getWorld()
		if(!(heroWorld in worlds)) return;

		local areas = worlds[heroWorld]
		local heroPosition = getPlayerPosition(heroId)

		foreach (area in areas)
		{
			local isIn = area.isIn(heroPosition.x, heroPosition.y, heroPosition.z, heroWorld)

			if (!(area in heroAreas) && isIn)
			{
				heroAreas[area] <- true
				callEvent("onEnterZone", area);
			}
			else if ((area in heroAreas) && !isIn)
			{
				delete heroAreas[area]
				callEvent("onExitZone", area);
			}
		}
	}
}

else if (SERVER_SIDE)
{
	addEvent("onPlayerEnterZone");
	addEvent("onPlayerExitZone");

	AreaManager.playersAreas <- []

	for (local pid = 0, end = getMaxSlots(); pid < getMaxSlots(); ++pid)
		AreaManager.playersAreas.push({})

	function AreaManager::process()
	{
		for (local pid = 0, end = getMaxSlots(); pid < getMaxSlots(); ++pid)
		{
			if(!isPlayerConnected(pid)) continue;
			if(!isPlayerSpawned(pid)) continue;

			local playerWorld = getPlayerWorld(pid)
				if (!(playerWorld in worlds)) continue;

			local areas = worlds[playerWorld]

			local playerAreas = playersAreas[pid]
			local playerPosition = getPlayerPosition(pid)

			foreach (area in areas)
			{
				local isIn = area.isIn(playerPosition.x, playerPosition.y, playerPosition.z, playerWorld)

				if (!(area in playerAreas) && isIn)
				{
					playerAreas[area] <- true
					callEvent("onPlayerEnterZone", pid, area);
				}
				else if ((area in playerAreas) && !isIn)
				{
					delete playerAreas[area]
					callEvent("onPlayerExitZone", pid, area);
				}
			}
		}
	}
}

setTimer(function(){
	AreaManager.process()
}, 500, 0)
