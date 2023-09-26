	// Server Information
SERVER_NAME <- "Gothic Role-Play";

SCRIPT_VERSION <- "DEngine 0.1"

	// Database Information
database <- {
	host = "localhost",
	user = "root",
	pass = "",
	db = "immersivekhorinis"
}

	// Packets
packet <- Packet();

enum packets {
	login,
	login_register,
	login_success,
	login_fail,
	creator,
	creator_facetaken,
	creator_scale,
	afk,
	useitem,
	statsupdate
}

enum packets_items {
	ITEM_PERMPOTION,
	ITEM_TEMPPOTION,
	ITEM_POTION,
	ITEM_FOOD,
	ITEM_DRINK,
	ITEM_PLANT,
	ITEM_CONSUMABLE,
	ITEM_MISC
}

enum packets_stats {
	guildname,
	level,
	experience,
	learnpoints,
	stamina,
	strength,
	dexterity,
	mana,
	health,
	onehand,
	twohand,
	bow,
	cbow,
	professionname,
	professionlevel,
	professionexp,
	mining,
	hunting,
	herbalism,
	sneaking,
	picklock,
	runes,
	alchem,
	smithing,
	trophy,
	acrobatic,
	magiccircle
}

	// Stat Update
enum statupdate {
	instance,
	guildname,
	classid,
	level,
	experience,
	learnpoints,
	stamina,
	strength,
	dexterity,
	mana,
	max_mana,
	health,
	max_health,
	onehand,
	twohand,
	bow,
	cbow,
	profession_name,
	profession_lvl,
	profession_exp,
	mining,
	hunting,
	herbalism,
	sneaking,
	picklock,
	pickpocket,
	runes,
	alchemy,
	smith,
	trophy,
	acrobatic,
	magic_circle
}

	// Ore Types
enum oreType {
	MAGIC
}

	// GUI
guiOpened <- null;

enum guiCheck {
	login,
	creator,
	anim,
	stats
}
loginGUIvisible <- null;
creatorGUIvisible <- null;
animGUIvisible <- null;
statsGUIvisible <- null;
statsGUIswitch_num <- null;

	// States
stateBusy <- null;

isHeroResting <- null;
isHeroAFK <- null;
isHeroExcavating <- null;

	// Admin Control Panel
enum perm {
	PLAYER,
	LEADER,
	MODERATOR,
	ADMIN
}

	// Calendar
const LENGTH_OF_DAY = 10800000.0;
//debug const LENGTH_OF_DAY = 4000.0;

	// Virtual World
enum virtualworlds {
	VOID,
	LOGIN,
	CREATOR,
	GAME,
	AFK,
	TESTING
}

	// Items
enum itemFlag {
	ITEM_ONEH,
	ITEM_TWOH,
	ITEM_DUALBLADE,
	ITEM_BOW,
	ITEM_CBOW,
	ITEM_AMMUNITION,
	ITEM_PERMPOTION,
	ITEM_TEMPPOTION,
	ITEM_POTION,
	ITEM_FOOD,
	ITEM_DRINK,
	ITEM_PLANT,
	ITEM_RING,
	ITEM_AMULET,
	ITEM_BELT,
	ITEM_ARMOR,
	ITEM_HELMET,
	ITEM_SHIELD,
	ITEM_SCROLL,
	ITEM_RUNE,
	ITEM_NOTES,
	ITEM_BOOKS,
	ITEM_RECIPIES,
	ITEM_KEY,
	ITEM_TROPHY,
	ITEM_LOOT,
	ITEM_CONSUMABLE,
	ITEM_TOOL,
	ITEM_CRAFTING,
	ITEM_MISC
}

enum statRestore {
	RESTORE_HEALTH,
	RESTORE_MANA
}

	// Creator
enum creator_gender {
	MALE,
	FEMALE
}

enum creator_race {
	PALE,
	WHITE,
	LATINO,
	BLACK
}

enum animations {
	ACTIVE,
	REACTION,
	IDLE
}

	// Player
guilds <- {
	UNASSIGNED = "Guildless",

	DIGGER = "Digger",

	SHADOW = "Shadow",
	OC_GUARD = "Guard",
	OREBARON = "Ore Baron",
	FIREMAGE = "Fire Mage",

	ROGUE = "Rogue",
	NC_MERCENARY = "Mercenary",
	WATERMAGE = "Water Mage",

	ARCHFIREMAGE = "Arch Fire Mage",
	ARCHWATERMAGE = "Arch Water Mage",
	NECROMANCER = "Necromancer",

	PSIONIC = "Psionic",
	TEMPLAR = "Templar",
	GURU = "Guru",

	CITIZEN = "Citizen",
	NOVICE = "Novice",

	MILITIA = "Miltia",
	PALADIN = "Paladin",

	MERCENARY = "Mercenary",
	DRAGONHUNTER = "Dragon Hunter",

	BANDIT = "Bandit",
	PIRATE = "Pirate",

	DEMONHUNTER = "Demon Hunter",
	ROYALGUARD = "Royal Guard",
	ARAXOS = "Araxos Mercenary"
}

prof <- {
	NONE = "None",

	HERBALIST = "Herbalist",
	HUNTER = "Hunter",
	MINER = "Miner",

	LUMBERJACK = "Lumberjack",
	FISHERMAN = "Fisherman",

	COOK = "Cook",
	FARMER = "Farmer",

	ARMORSMITH = "Armorsmith",
	WEAPONSMITH = "Weaponsmith",
	BOWYER = "Bowyer",
	ALCHEMIST = "Alchemist",

	RUNEMAKER = "Runemaker",
	SCROLLWRITER = "Scrollwriter",

	CARPENTER = "Carpenter",
	TAILOR = "Tailor",

	LIBRARIAN = "Librarian",

	MERCHANT = "Merchant",
	GUARD = "Guard",
	MESSENGER = "Messenger"
}