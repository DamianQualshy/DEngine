Seasons <- {
	"Spring" : {
		months = [
			MONTHS.March,
			MONTHS.April,
			MONTHS.May
		],

		daylength = TIMELENGTH_SPRING_DAY,
		nightlength = TIMELENGTH_SPRING_NIGHT,

		weather = WEATHER_RAIN,
		windScale = WINDSCALE_SPRING,

		darkSky = false,
		dontRain = false,

		rainStart = {hour = 16, minute = 30},
		rainEnd = {hour = 18, minute = 0},

		fogColor = {
			[TIME_DAY] = {r = 82, g = 109, b = 198},
			[TIME_EVENING] = {r = 255, g = 255, b = 0},
			[TIME_NIGHT] = {r = 18, g = 16, b = 60},
			[TIME_DAWN] = {r = 134, g = 104, b = 125}
		},
		cloudsColor = {r = 255, g = 255, b = 255},

		sunSize = SUNSIZE_SPRING,
		sunColor = {r = 255, g = 200, b = 120, a = 230},
		sunTexture = "UNSUN5.TGA",

		moonSize = MOONSIZE_SPRING,
		moonColor = {r = 255, g = 255, b = 255, a = 255},
		moonTexture = "MOON.TGA",

		skyLighting = {r = 255, g = 255, b = 255},

		sightFactor = SIGHTFACTOR_SPRING
	},
	"Summer" : {
		months = [
			MONTHS.June,
			MONTHS.July,
			MONTHS.August
		],

		daylength = TIMELENGTH_SUMMER_DAY,
		nightlength = TIMELENGTH_SUMMER_NIGHT,

		weather = WEATHER_RAIN,
		windScale = WINDSCALE_SUMMER,

		darkSky = false,
		dontRain = true,

		rainStart = {hour = 0, minute = 0},
		rainEnd = {hour = 0, minute = 0},

		fogColor = {
			[TIME_DAY] = {r = 82, g = 109, b = 198},
			[TIME_EVENING] = {r = 255, g = 255, b = 0},
			[TIME_NIGHT] = {r = 18, g = 16, b = 60},
			[TIME_DAWN] = {r = 134, g = 104, b = 125}
		},
		cloudsColor = {r = 255, g = 255, b = 255},

		sunSize = SUNSIZE_SUMMER,
		sunColor = {r = 255, g = 200, b = 120, a = 230},
		sunTexture = "UNSUN5.TGA",

		moonSize = MOONSIZE_SUMMER,
		moonColor = {r = 255, g = 255, b = 255, a = 255},
		moonTexture = "MOON.TGA",

		skyLighting = {r = 255, g = 255, b = 255},

		sightFactor = SIGHTFACTOR_SUMMER
	},
	"Autumn" : {
		months = [
			MONTHS.September,
			MONTHS.October,
			MONTHS.November
		],

		daylength = TIMELENGTH_AUTUMN_DAY,
		nightlength = TIMELENGTH_AUTUMN_NIGHT,

		weather = WEATHER_RAIN,
		windScale = WINDSCALE_AUTUMN,

		darkSky = true,
		dontRain = false,

		rainStart = {hour = 10, minute = 0},
		rainEnd = {hour = 20, minute = 0},

		fogColor = {
			[TIME_DAY] = {r = 116, g = 89, b = 75},
			[TIME_EVENING] = {r = 80, g = 90, b = 80},
			[TIME_NIGHT] = {r = 120, g = 140, b = 180},
			[TIME_DAWN] = {r = 120, g = 140, b = 180}
		},
		cloudsColor = {r = 255, g = 255, b = 255},

		sunSize = SUNSIZE_AUTUMN,
		sunColor = {r = 255, g = 200, b = 120, a = 230},
		sunTexture = "UNSUN5.TGA",

		moonSize = MOONSIZE_AUTUMN,
		moonColor = {r = 255, g = 255, b = 255, a = 255},
		moonTexture = "MOON.TGA",

		skyLighting = {r = 255, g = 255, b = 255},

		sightFactor = SIGHTFACTOR_AUTUMN
	},
	"Winter" : {
		months = [
			MONTHS.December,
			MONTHS.January,
			MONTHS.February
		],

		daylength = TIMELENGTH_WINTER_DAY,
		nightlength = TIMELENGTH_WINTER_NIGHT,

		weather = WEATHER_SNOW,
		windScale = WINDSCALE_WINTER,

		darkSky = true,
		dontRain = false,

		rainStart = {hour = 0, minute = 0},
		rainEnd = {hour = 23, minute = 59},

		fogColor = {
			[TIME_DAY] = {r = 90, g = 80, b = 80},
			[TIME_EVENING] = {r = 90, g = 80, b = 80},
			[TIME_NIGHT] = {r = 90, g = 80, b = 80},
			[TIME_DAWN] = {r = 90, g = 80, b = 80}
		},
		cloudsColor = {r = 255, g = 255, b = 255},

		sunSize = SUNSIZE_WINTER,
		sunColor = {r = 255, g = 200, b = 120, a = 230},
		sunTexture = "UNSUN5.TGA",

		moonSize = MOONSIZE_WINTER,
		moonColor = {r = 255, g = 255, b = 255, a = 255},
		moonTexture = "MOON.TGA",

		skyLighting = {r = 255, g = 255, b = 255},

		sightFactor = SIGHTFACTOR_WINTER
	}
}