local symbols = "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z";
local maxChunkNameLength = 8;

local _sqlworld = "";

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

		callEvent("onChunkInit", this.id, this._type, this._world, this.borders);
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

function giveName(){
	local _name = "";
	for (local i = 0; i < maxChunkNameLength; ++i) {
		local randomChar = split(symbols, " ");
		local randomIndex = rand() % randomChar.len();
		_name += randomChar[randomIndex];
	}
	return _name;
}

if(SERVER_SIDE){
	addEventHandler("onInit", function(){
		local result = MySQL.query("SELECT * FROM Chunks");
		local row = MySQL.fetchAssoc(result);
		if(row != null){
			local result_chunks_arr = [];
			for(local i = 0, end = MySQL.numRows(result); i < end; i++){
				result_chunks_arr.append(MySQL.fetchAssoc(result));
			}
				MySQL.freeResult(result);
			foreach(chunk in result_chunks_arr){
				if(chunk == null) break;
					if(_sqlworld != chunk.World) _sqlworld = chunk.World;
				Chunk(chunk.Chunk_ID, chunk.Type, chunk.World, chunk.X, chunk.Z, chunk.Size);
			}
		} else {
			local id = 0;
			for(local x = -worldSize; x <= worldSize; x += chunkSize){
				for(local z = -worldSize; z <= worldSize; z += chunkSize){
					Chunk(id, 0, getServerWorld(), x, z, chunkSize);
					id++;
				}
			}
			foreach(chunk in chunkManager){
				local result = MySQL.query("SELECT * FROM Chunks WHERE Name = '" + chunk.name + "'");
				local row = MySQL.fetchAssoc(result);
					MySQL.freeResult(result);
				if(row == null){
					MySQL.insert("Chunks", {
						Name = chunk.name,
						Type = chunk._type,
						World = chunk._world,
						X = chunk.pos.x,
						Z = chunk.pos.z,
						Size = chunkSize
					});
				}
			}
		}

		foreach(chunk in chunks){
			AreaManager.add(chunk);
		}
	});
}

if(CLIENT_SIDE){
	addEventHandler("onInit", function(){
		local id = 0;
		for(local x = -worldSize; x <= worldSize; x += chunkSize){
			for(local z = -worldSize; z <= worldSize; z += chunkSize){
				if(_sqlworld == "") _sqlworld = getWorld();
				Chunk(id, 0, _sqlworld, x, z, chunkSize);
				id++;
			}
		}
		foreach(chunk in chunks){
			AreaManager.add(chunk);
		}
	});
}