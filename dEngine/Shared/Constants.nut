// Prototype Hero


// Attributes
const ATR_HITPOINTS = 0;
const ATR_HITPOINTS_MAX = 1;
const ATR_MANA = 2;
const ATR_MANA_MAX = 3;

const ATR_STRENGTH = 4;
const ATR_DEXTERITY = 5;

// Map Corner
	// These were taken from NEWWORLD.ZEN; each ZEN has a varying size and so the map size differs as well
const MAP_MIN_X = -28000;
const MAP_MIN_Z = 50500;
const MAP_MAX_X = 95500;
const MAP_MAX_Z = -42500;

const CHUNK_SIZE = 4000;

// Render
const SIGHTFACTOR_DEFAULT = 1.0;

const SIGHTFACTOR_SPRING = 2.5;
const SIGHTFACTOR_SUMMER = 4.0;
const SIGHTFACTOR_AUTUMN = 1.0;
const SIGHTFACTOR_WINTER = 0.5;

const SUNSIZE_SPRING = 200.0;
const SUNSIZE_SUMMER = 200.0;
const SUNSIZE_AUTUMN = 200.0;
const SUNSIZE_WINTER = 200.0;

const MOONSIZE_SPRING = 400.0;
const MOONSIZE_SUMMER = 400.0;
const MOONSIZE_AUTUMN = 400.0;
const MOONSIZE_WINTER = 400.0;

// Weather
const WEATHER_CLEAR = 0;

const WINDSCALE_SPRING = 0.001;
const WINDSCALE_SUMMER = 0.000;
const WINDSCALE_AUTUMN = 0.005;
const WINDSCALE_WINTER = 0.002;

// Time
const TIMELENGTH_DEFAULT = 6000;

const TIMELENGTH_SPRING_DAY = 6000;
const TIMELENGTH_SPRING_NIGHT = 6000;

const TIMELENGTH_SUMMER_DAY = 9000;
const TIMELENGTH_SUMMER_NIGHT = 3000;

const TIMELENGTH_AUTUMN_DAY = 3000;
const TIMELENGTH_AUTUMN_NIGHT = 9000;

const TIMELENGTH_WINTER_DAY = 1500;
const TIMELENGTH_WINTER_NIGHT = 10500;

enum MONTHS {
	January,
	February,
	March,
	April,
	May,
	June,
	July,
	August,
	September,
	October,
	November,
	December
}

const TIME_DAY = 0;
const TIME_EVENING = 1;
const TIME_NIGHT = 2;
const TIME_DAWN = 3;

const DAYS_IN_MONTH = 30;
const MONTHS_IN_YEAR = 12;

// Dialogue
const self = 0;
const other = 1;

const DIALOG_BACK = 998;
const DIALOG_ENDE = 999;

// GUI
const VS = 8192.0;

// Journal
const LOG_MISSION = 0;
const LOG_NOTE = 1;

const LOG_RUNNING = 1;
const LOG_SUCCESS = 2;
const LOG_FAILED = 3;
const LOG_OBSOLETE = 4;

// NPC Type
const NPCTYPE_AMBIENT = 0;
const NPCTYPE_MAIN = 1;
const NPCTYPE_FRIEND = 2;
const NPCTYPE_ENEMY = 3;

const NPC_TYPE_NEUTRAL = 0;
const NPC_TYPE_AGRESSIVE = 1;
const NPC_TYPE_MONSTER = 2;
const NPC_TYPE_HUMANOID = 3;

// Fight Tactic
const FIGHT_TACTIC_COWARD = 0;
const FIGHT_TACTIC_NORMAL = 1;
const FIGHT_TACTIC_STRONG = 2;
const FIGHT_TACTIC_MASTER = 3;

// AI
enum AIState {
	Idle,
	Talk,
	Roam,
	Walk,
	Attack,
	Flee,
}

enum AIWaynetMovement {
	Walking,
	Running
}

const AI_TASK_EAT = "EATING";