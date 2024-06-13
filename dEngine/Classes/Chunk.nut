chunks <- [];
chunkManager <- {};

class Chunk {
	id = null;
	name = null;

	_type = null;
	_world = null;

	pos = {x = null, z = null};

	borders = {a = null, b = null, c = null, d = null};

	_area = null;

	constructor(id, _type, _world, x, z, size){
		this.id = id;
		this.name = format("Chunk %d", this.id);

		this._type = _type;
		this._world = _world;

		this.borders = this.calcSquare(x, z, size);

		this.pos = {x = x, z = z}

		this._area = Area({
			name = this.name,
			world = _world,
			isChunk = true,
			points = [
				{x = borders.a[0], z = borders.a[1]},
				{x = borders.b[0], z = borders.b[1]},
				{x = borders.c[0], z = borders.c[1]},
				{x = borders.d[0], z = borders.d[1]}
			]
		})

		chunkManager[this.id] <- this;
		chunks.append(this.id = this._area);
		chunks.sort();
	}

	function calcSquare(x, z, size){
		this.borders.a = [x, z];
		this.borders.b = [x + size, z];
		this.borders.c = [x + size, z + size];
		this.borders.d = [x, z + size];
		return this.borders;
	}

	function calcCenter(){
		local a = this.borders.a;
		local b = this.borders.b;
		local c = this.borders.c;
		local d = this.borders.d;

		this.pos.x = (a[0] + b[0] + c[0] + d[0]) / 4;
		this.pos.z = (a[1] + b[1] + c[1] + d[1]) / 4;
		return this.pos;
	}
}