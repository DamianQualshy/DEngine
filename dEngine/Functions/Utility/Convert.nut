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

	local _argument;

	switch(_type){
		case "integer":
			if(typeof(argument) == "bool") {
				_argument = boolToInt(argument);
			} else _argument = argument.tointeger();
		break;
		case "string":
			_argument = argument.tostring();
		break;
		case "bool":
			_argument = toBool(argument);
		break;
		case "float":
			if(typeof(argument) == "string") {
				_argument = argument.tointeger().tofloat();
			} else _argument = argument.tofloat();
		break;
		case "char":
			if(typeof(argument) == "integer") {
				_argument = argument.tochar();
			} else _argument = argument.tointeger().tochar();
		break;
		default:
			print(format("Wrong argument type %s! Can't convert %s", _type, typeof(argument)));
			_argument = null;
		break;
	}
	return _argument;
}