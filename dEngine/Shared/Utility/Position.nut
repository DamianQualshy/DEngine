function generateRandomPosition(id) {
	local angle = random(0, 360);
	local distance = random(0, NPCs[id].getRoamDistance());
	local radians = angle * (PI / 180);

	local offsetX = distance * cos(radians);
	local offsetZ = distance * sin(radians);

	local newPos = {
		x = NPCs[id].getSpawnPosition().x + offsetX,
		y = NPCs[id].getSpawnPosition().y,
		z = NPCs[id].getSpawnPosition().z + offsetZ
	};

	return newPos;
}
