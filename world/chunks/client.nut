local currentChunk;
local playerY;

local areaPoints = [
	{x = 0, y = 0, z = 0},
	{x = 0, y = 0, z = 0},
	{x = 0, y = 0, z = 0},
	{x = 0, y = 0, z = 0}
]

local chunkDraw = GUI.Draw({
	position = {x = 4200, y = 6500},
	text = "chunk name",
	font = "FONT_DEFAULT.TGA"
});
chunkDraw.setVisible(true);

addEventHandler("onEnterZone", function(area){
	if(!area.isChunk) return;

	playerY = getPlayerPosition(heroId).y;

		currentChunk = area;
		createLines(area.points[0], area.points[1], area.points[2], area.points[3]);

	chunkDraw.setText(currentChunk.name);
});

addEventHandler("onExitZone", function(area){
	if(!area.isChunk) return;
});

function createLines(a, b, c, d){
	areaPoints[0] = {x = a.x, y = playerY, z = a.z};
	areaPoints[1] = {x = b.x, y = playerY, z = b.z};
	areaPoints[2] = {x = c.x, y = playerY, z = c.z};
	areaPoints[3] = {x = d.x, y = playerY, z = d.z};
}

addEventHandler("onRender", function(){
	local a = areaPoints[0];
	local b = areaPoints[1];
	local c = areaPoints[2];
	local d = areaPoints[3];

	drawLine3d(a.x, a.y - 1000, a.z, a.x, a.y + 1000, a.z, 153, 194, 0);
	drawLine3d(b.x, b.y - 1000, b.z, b.x, b.y + 1000, b.z, 153, 194, 0);
	drawLine3d(c.x, c.y - 1000, c.z, c.x, c.y + 1000, c.z, 153, 194, 0);
	drawLine3d(d.x, d.y - 1000, d.z, d.x, d.y + 1000, d.z, 153, 194, 0);
});