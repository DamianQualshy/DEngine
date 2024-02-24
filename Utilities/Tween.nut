local pi = PI;

# LINEAR

local function linear(t, b, c, d) { return c * t / d + b }

# END-LINEAR



# QUAD

local function inQuad(t, b, c, d) { return c * pow(t / d, 2) + b }

local function outQuad(t, b, c, d) {
  t = t / d;
  return -c * t * (t - 2) + b;
}

local function inOutQuad(t, b, c, d) {
	t = t / d * 2;
	if (t < 1)
		return c / 2 * pow(t, 2) + b;
	return -c / 2 * ((t - 1) * (t - 3) - 1) + b;
}

local function outInQuad(t, b, c, d) {
	if (t < d / 2)
		return outQuad(t * 2, b, c / 2, d);
	return inQuad((t * 2) - d, b + c / 2, c / 2, d);
}

# END-QUAD



# CUBIC

local function inCubic (t, b, c, d) { return c * pow(t / d, 3) + b }

local function outCubic(t, b, c, d) { return c * (pow(t / d - 1, 3) + 1) + b }

local function inOutCubic(t, b, c, d) {
	t = t / d * 2;
	if (t < 1)
		return c / 2 * t * t * t + b;
	t = t - 2;
	return c / 2 * (t * t * t + 2) + b;
}

local function outInCubic(t, b, c, d) {
	if (t < d / 2)
		return outCubic(t * 2, b, c / 2, d);
	return inCubic((t * 2) - d, b + c / 2, c / 2, d)
}

# END-CUBIC



# QUART

local function inQuart(t, b, c, d) { return c * pow(t / d, 4) + b }

local function outQuart(t, b, c, d) { return -c * (pow(t / d - 1, 4) - 1) + b }

local function inOutQuart(t, b, c, d) {
	t = t / d * 2;
	if (t < 1)
		return c / 2 * pow(t, 4) + b;
	return -c / 2 * (pow(t - 2, 4) - 2) + b;
}

local function outInQuart(t, b, c, d) {
	if (t < d / 2)
		return outQuart(t * 2, b, c / 2, d);
	return inQuart((t * 2) - d, b + c / 2, c / 2, d);
}

# END-QUART



# QUINT

local function inQuint(t, b, c, d) { return c * pow(t / d, 5) + b }

local function outQuint(t, b, c, d) { return c * (pow(t / d - 1, 5) + 1) + b }

local function inOutQuint(t, b, c, d) {
	t = t / d * 2;
	if (t < 1)
		return c / 2 * pow(t, 5) + b;
	return c / 2 * (pow(t - 2, 5) + 2) + b;
}

local function outInQuint(t, b, c, d) {
	if (t < d / 2)
		return outQuint(t * 2, b, c / 2, d);
	return inQuint((t * 2) - d, b + c / 2, c / 2, d);
}

# END-QUINT



# SINE

local function inSine(t, b, c, d) { return -c * cos(t / d * (pi / 2)) + c + b }

local function outSine(t, b, c, d) { return c * sin(t / d * (pi / 2)) + b }

local function inOutSine(t, b, c, d) { return -c / 2 * (cos(pi * t / d) - 1) + b }

local function outInSine(t, b, c, d) {
	if (t < d / 2)
		return outSine(t * 2, b, c / 2, d);
	return inSine((t * 2) -d, b + c / 2, c / 2, d);
}

# END-SINE



# EXPO

local function inExpo(t, b, c, d) {
	if (t == 0)
		return b;
	return c * pow(2, 10 * (t / d - 1)) + b - c * 0.001;
}

local function outExpo(t, b, c, d) {
	if (t == d)
		return b + c;
	return c * 1.001 * (-pow(2, -10 * t / d) + 1) + b;
}

local function inOutExpo(t, b, c, d) {
	if (t == 0)
		return b;
	if (t == d)
		return b + c;
	t = t / d * 2;
	if (t < 1)
		return c / 2 * pow(2, 10 * (t - 1)) + b - c * 0.0005;
	return c / 2 * 1.0005 * (-pow(2, -10 * (t - 1)) + 2) + b;
}

local function outInExpo(t, b, c, d) {
	if (t < d / 2)
		return outExpo(t * 2, b, c / 2, d);
	return inExpo((t * 2) - d, b + c / 2, c / 2, d);
}

# END-EXPO



# CIRC

local function inCirc(t, b, c, d) { return(-c * (sqrt(1 - pow(t / d, 2)) - 1) + b) }

local function outCirc(t, b, c, d) { return(c * sqrt(1 - pow(t / d - 1, 2)) + b) }

local function inOutCirc(t, b, c, d) {
	t = t / d * 2;
	if (t < 1)
		return -c / 2 * (sqrt(1 - t * t) - 1) + b;
	t = t - 2;
	return c / 2 * (sqrt(1 - t * t) + 1) + b;
}

local function outInCirc(t, b, c, d) {
	if (t < d / 2)
		return outCirc(t * 2, b, c / 2, d);
	return inCirc((t * 2) - d, b + c / 2, c / 2, d);
}

# END=CIRC



# ELASTIC

local function calculatePAS(p,a,c,d) {
	p = p || d * 0.3;
	a = a || 0;
	if (a < abs(c))
		return p, c, p / 4; // p, a, s
	return {p = p, a = a, s = p / (2 * pi) * asin(c/a)}; // p,a,s
}

local function inElastic(t, b, c, d, a, p) {
	local s;
	if (t == 0)
		return b;
	t = t / d;
	if (t == 1)
		return b + c;
	pas = calculatePAS(p,a,c,d);
	p = pas.p;
	a = pas.a;
	s = pas.s;
	t = t - 1;
	return -(a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b;
}

local function outElastic(t, b, c, d, a, p) {
	local s;
	if (t == 0)
		return b;
	t = t / d;
	if (t == 1)
		return b + c;
	pas = calculatePAS(p,a,c,d);
	p = pas.p;
	a = pas.a;
	s = pas.s;
	return a * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p) + c + b;
}

local function inOutElastic(t, b, c, d, a, p) {
	local s;
	if (t == 0)
		return b;
	t = t / d * 2;
	if (t == 2)
		return b + c;
	pas = calculatePAS(p,a,c,d);
	p = pas.p;
	a = pas.a;
	s = pas.s;
	t = t - 1;
	if (t < 0)
		return -0.5 * (a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b;
	return a * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p ) * 0.5 + c + b;
}

local function outInElastic(t, b, c, d, a, p) {
	if (t < d / 2)
		return outElastic(t * 2, b, c / 2, d, a, p);
	return inElastic((t * 2) - d, b + c / 2, c / 2, d, a, p);
}

# END-ELASTIC



# BACK

local function inBack(t, b, c, d, s) {
	s = s || 1.70158;
	t = t / d;
	return c * t * t * ((s + 1) * t - s) + b;
}

local function outBack(t, b, c, d, s) {
	s = s || 1.70158;
	t = t / d - 1;
	return c * (t * t * ((s + 1) * t + s) + 1) + b;
}

local function inOutBack(t, b, c, d, s) {
	s = (s || 1.70158) * 1.525;
	t = t / d * 2;
	if (t < 1)
		return c / 2 * (t * t * ((s + 1) * t - s)) + b;
	t = t - 2;
	return c / 2 * (t * t * ((s + 1) * t + s) + 2) + b;
}

local function outInBack(t, b, c, d, s) {
	if (t < d / 2)
		return outBack(t * 2, b, c / 2, d, s);
	return inBack((t * 2) - d, b + c / 2, c / 2, d, s);
}

# END-BACK



# BOUNCE

local function outBounce(t, b, c, d) {
  t = t / d;
  if (t < 1 / 2.75)
	return c * (7.5625 * t * t) + b;
  if (t < 2 / 2.75) {
	t = t - (1.5 / 2.75);
	return c * (7.5625 * t * t + 0.75) + b;
  } else if (t < 2.5 / 2.75) {
	t = t - (2.25 / 2.75);
	return c * (7.5625 * t * t + 0.9375) + b;
  }
  t = t - (2.625 / 2.75);
  return c * (7.5625 * t * t + 0.984375) + b;
}

local function inBounce(t, b, c, d) { return c - outBounce(d - t, 0, c, d) + b }

local function inOutBounce(t, b, c, d) {
	if (t < d / 2)
		return inBounce(t * 2, 0, c, d) * 0.5 + b;
	return outBounce(t * 2 - d, 0, c, d) * 0.5 + c * 0.5 + b;
}

local function outInBounce(t, b, c, d) {
	if (t < d / 2)
		return outBounce(t * 2, b, c / 2, d);
	return inBounce((t * 2) - d, b + c / 2, c / 2, d);
}

# END-BOUNCE


local function performEasingOnSubject(subject, target, initial, clock, duration, easing) {
	local t;
	local b;
	local c;
	local d;
	foreach (k, v in target) {
		if (typeof v == "table") {
			performEasingOnSubject(subject[k], v, initial[k], clock, duration, easing)
		} else {
			t = clock;
			b = initial[k];
			c = v - initial[k];
			d = duration;
			subject[k] = easing(t,b,c,d);
		}
	}
}

class Tween {
#private:
	static _timers = [];

	stoped = false;
#public:
	initial = null;
	ended = false;

	duration = -1;
	subject = null;
	target = null;
	easing = null;
	clock = -1;

	constructor(duration, subject, target, easing) {
		this.duration = duration;
		this.subject = subject;
		this.initial = clone subject;
		this.target = target;
		this.easing = easing;
		this.clock = 0;

		Tween._timers.push(this);
	}

	function set(clock) {
		this.clock = clock

		if (this.clock <= 0)
			this.clock = 0
		else
			performEasingOnSubject(this.subject, this.target, this.initial, this.clock, this.duration, this.easing)

		return this.clock >= this.duration
	}

	function reset() {
		set(0);
	}

	function stop() {
		stoped = true;
	}

	static function onRender(dt) {
		local count = _timers.len();
		for (local i = 0; i < count; i++) {
			local tween = _timers[i];
			local result = tween.set(tween.clock + dt);

			if (result || tween.stoped) {
				callEvent("Tween.onEnded", tween);
				tween.ended = true;
				_timers.remove(i);
			}
		}
	}
}

Tween["easing"] <- {
	linear    = linear,
	inQuad    = inQuad,    outQuad    = outQuad,    inOutQuad    = inOutQuad,    outInQuad    = outInQuad,
	inCubic   = inCubic,   outCubic   = outCubic,   inOutCubic   = inOutCubic,   outInCubic   = outInCubic,
	inQuart   = inQuart,   outQuart   = outQuart,   inOutQuart   = inOutQuart,   outInQuart   = outInQuart,
	inQuint   = inQuint,   outQuint   = outQuint,   inOutQuint   = inOutQuint,   outInQuint   = outInQuint,
	inSine    = inSine,    outSine    = outSine,    inOutSine    = inOutSine,    outInSine    = outInSine,
	inExpo    = inExpo,    outExpo    = outExpo,    inOutExpo    = inOutExpo,    outInExpo    = outInExpo,
	inCirc    = inCirc,    outCirc    = outCirc,    inOutCirc    = inOutCirc,    outInCirc    = outInCirc,
	inElastic = inElastic, outElastic = outElastic, inOutElastic = inOutElastic, outInElastic = outInElastic,
	inBack    = inBack,    outBack    = outBack,    inOutBack    = inOutBack,    outInBack    = outInBack,
	inBounce  = inBounce,  outBounce  = outBounce,  inOutBounce  = inOutBounce,  outInBounce  = outInBounce
};

addEventHandler ("onRender", function () {
	local deltaTime = WorldTimer.frameTimeSecs;
	Tween.onRender(deltaTime);
});



# EVENTS

addEvent("Tween.onEnded");