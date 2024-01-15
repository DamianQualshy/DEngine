function randomRange(x, z){
	if(x > z){
		local temp = x;
		x = z;
		z = temp;
	}

	if(x < 0){
		x = 0;
	}

	return x + floor(rand() % (z - x + 1));
}

function min(a, b){
	return (a < b) ? a : b;
}
function max(a, b){
	return (a > b) ? a : b;
}


function lerp(start, end, t){
	return start + t * (end - start);
}