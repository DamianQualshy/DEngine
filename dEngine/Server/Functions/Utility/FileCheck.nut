function doesFileExist(filename, mode){
	try {
		return file(filename, mode);
	} catch(e) {
		print("Error opening file: " + e);
		return null;
	}
}