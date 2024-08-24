Chunks <- [];

class Chunk extends Area {
	constructor(x, z, world) {
		local chunkPoints = [
			{x = x, z = z},
			{x = (x + CHUNK_SIZE <= MAP_MAX_X) ? x + CHUNK_SIZE : MAP_MAX_X, z = z},
			{x = (x + CHUNK_SIZE <= MAP_MAX_X) ? x + CHUNK_SIZE : MAP_MAX_X, z = (z - CHUNK_SIZE >= MAP_MAX_Z) ? z - CHUNK_SIZE : MAP_MAX_Z},
			{x = x, z = (z - CHUNK_SIZE >= MAP_MAX_Z) ? z - CHUNK_SIZE : MAP_MAX_Z}
		];

		base.constructor({
			points = chunkPoints,
			world = world
		});

		Chunks.append(this);
		AreaManager.add(Chunks.top(), null, null);
	}
}

function createChunksForMap() {
	for (local x = MAP_MIN_X; x < MAP_MAX_X + CHUNK_SIZE; x += CHUNK_SIZE) {
		for (local z = MAP_MIN_Z; z > MAP_MAX_Z - CHUNK_SIZE; z -= CHUNK_SIZE) {
			Chunk(x, z, getServerWorld());
		}
	}
}