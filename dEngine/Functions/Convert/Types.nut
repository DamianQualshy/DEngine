function toBool(argument){
	switch(typeof(argument)){
		case "integer":
			if(argument <= 0) return false;
			if(argument >= 1) return true;
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

function convert(argument, _type){
	if(typeof(argument) == _type) return argument;

	switch(_type){
		case "integer":
			if(typeof(argument) == "bool") {
				argument = boolToInt(argument);
			} else argument = argument.tointeger();
		break;
		case "string":
			argument = argument.tostring();
		break;
		case "bool":
			argument = toBool(argument);
		break;
		case "float":
			if(typeof(argument) == "string") {
				argument = argument.tointeger().tofloat();
			} else argument = argument.tofloat();
		break;
		case "char":
			if(typeof(argument) == "integer") {
				argument = argument.tochar();
			} else argument = argument.tointeger().tochar();
		break;
		default:
			print(format("Wrong argument type %s! Can't convert %s", _type, typeof(argument)));
			argument = null;
		break;
	}
	return argument;
}