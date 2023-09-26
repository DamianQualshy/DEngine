local lines = [];
local worldSize = 500000;
local chunkSize = 10000;

local draw = Draw(5200, 7500, "pos");
local draw2 = Draw(4200, 6500, "pos");

addEventHandler("onInit", function(){
	setTimer(function(){
		updateLines()
	}, 1000, 0);

	draw.visible = true;
	draw2.visible = true;
});

function updateLines() {
	local currentChunk = null;
	local playerX = getPlayerPosition(heroId).x;
	local playerZ = getPlayerPosition(heroId).z;

	if(lines.len() != 0){
		foreach(line in lines){
			line.visible = false;
		}
		lines.clear();
	}

	foreach (chunk in chunks) {
		if(isPlayerInsideChunk(playerX, playerZ, chunk)){
			currentChunk = chunk;
			createLines(chunk.borders.a, chunk.borders.b, chunk.borders.c, chunk.borders.d);
			break;
		}
	}

	foreach(line in lines){
		line.visible = true;
		line.setColor(153, 194, 0);
	}

	draw.text = format("%f %f %f", playerX, getPlayerPosition(heroId).y, playerZ);
	draw2.text = currentChunk.name;
}

function isPlayerInsideChunk(playerX, playerZ, chunk){
	local isInside = false;
	local j = chunk.borders.d.len() - 1;

	for (local i = 0; i < chunk.borders.d.len(); j = i++) {
		local aX = chunk.borders.a[0];
		local aZ = chunk.borders.a[1];
		local bX = chunk.borders.b[0];
		local bZ = chunk.borders.b[1];
		local cX = chunk.borders.c[0];
		local cZ = chunk.borders.c[1];
		local dX = chunk.borders.d[0];
		local dZ = chunk.borders.d[1];

		if ((aZ > playerZ) != (dZ > playerZ) &&
			(playerX < (dX - aX) * (playerZ - aZ) / (dZ - aZ) + aX)) {
			isInside = !isInside;
		}
	}

	return isInside;
}


function createLines(a, b, c, d){
	lines.push(Line3d(a[0], -5000.0, a[1], a[0], 5000.0, a[1]));
	lines.push(Line3d(b[0], -5000.0, b[1], b[0], 5000.0, b[1]));
	lines.push(Line3d(c[0], -5000.0, c[1], c[0], 5000.0, c[1]));
	lines.push(Line3d(d[0], -5000.0, d[1], d[0], 5000.0, d[1]));
}