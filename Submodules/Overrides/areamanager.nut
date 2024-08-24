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
				callEvent("onEnterArea", area)
			}
			else if ((area in heroAreas) && !isIn)
			{
				delete heroAreas[area]
				callEvent("onExitArea", area)
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
					callEvent("onPlayerEnterArea", pid, area)
				}
				else if ((area in playerAreas) && !isIn)
				{
					delete playerAreas[area]
					callEvent("onPlayerExitArea", pid, area)
				}
			}
		}
	}
}

setTimer(function()
{
	AreaManager.process()
}, 500, 0)
