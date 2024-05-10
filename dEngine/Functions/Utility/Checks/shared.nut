function isEmpty(text){
	if(!text || text == "" || text == " "){
		return true;
	} else return false;
}

function startsWith(str, prefix){
	return (str.slice(0, prefix.len()) == prefix);
}