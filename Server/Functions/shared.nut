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

function toBool(argument){
	local arg = typeof(argument);
	switch(arg){
		case "integer":
			if(argument == 0) return false;
			if(argument == 1) return true;
		break;
		case "string":
			if(argument == "false") return false;
			if(argument == "true") return true;
		break;
		case "bool":
			return argument;
		break;
		default: return false;
	}
}

function boolToInt(argument){
	if(argument == false) return 0;
	if(argument == true) return 1;
}