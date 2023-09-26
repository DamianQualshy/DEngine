local symbols = "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z";
local maxChunkNameLength = 8;

local worldSize = 500000;
local chunkSize = 10000;

chunks <- [];

class Chunk {
	name = null;

	size = null;

	center = {x = null, z = null};

	borders = {a = null, b = null, c = null, d = null};

	constructor(x, z, size){
		this.name = "";

		this.size = size;

		this.center.x = x;
		this.center.z = z;

		this.borders = this.calcSquare(x, z, size);
	}

	function calcSquare(x, z, size){
		this.borders.a = [x + size / 2.0, z + size / 2.0];
		this.borders.b = [x - size / 2.0, z + size / 2.0];
		this.borders.c = [x - size / 2.0, z - size / 2.0];
		this.borders.d = [x + size / 2.0, z - size / 2.0];
		/* print(format("%d, %d", x + size / 2.0, z + size / 2.0));
		print(format("%d, %d", x - size / 2.0, z + size / 2.0));
		print(format("%d, %d", x - size / 2.0, z - size / 2.0));
		print(format("%d, %d", x + size / 2.0, z - size / 2.0)); */
		//print(format("Chunk %s: %f/%f, %f/%f, %f/%f, %f/%f", this.name, this.borders[0][0], this.borders[0][1], this.borders[1][0], this.borders[1][1], this.borders[2][0], this.borders[2][1], this.borders[3][0], this.borders[3][1]));
		return this.borders;
	}

	function giveName(){
		local randomChar = split(symbols, " ");
		local randomIndex = rand() % randomChar.len();

		this.name += randomChar[randomIndex];
	}
}

addEventHandler("onInit", function(){
	for(local x = -worldSize, z = -worldSize; x <= worldSize, z <= worldSize; x += chunkSize, z += chunkSize){
		chunks.push(Chunk(x, z, chunkSize));
	}
});