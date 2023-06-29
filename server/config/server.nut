	// Server Information
SERVER_NAME <- "Gothic Role-Play";

SCRIPT_VERSION <- "DEngine 0.1"

	// Server Configuration



	// Database Information
database <- {
	host = "localhost",
	user = "root",
	pass = "",
	db = "dengine"
}

	// Admin Control Panel

enum perm {
	PLAYER,
	LEADER,
	MODERATOR,
	ADMIN
}

	// Creator

const MALE = 0;
const FEMALE = 1;

const PALE = 0;
const WHITE = 1;
const LATINO = 2;
const BLACK = 3;