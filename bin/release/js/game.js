(function (console) { "use strict";
var $estr = function() { return js_Boot.__string_rec(this,''); };
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var HxOverrides = function() { };
HxOverrides.__name__ = true;
HxOverrides.substr = function(s,pos,len) {
	if(pos != null && pos != 0 && len != null && len < 0) return "";
	if(len == null) len = s.length;
	if(pos < 0) {
		pos = s.length + pos;
		if(pos < 0) pos = 0;
	} else if(len < 0) len = s.length + len - pos;
	return s.substr(pos,len);
};
HxOverrides.iter = function(a) {
	return { cur : 0, arr : a, hasNext : function() {
		return this.cur < this.arr.length;
	}, next : function() {
		return this.arr[this.cur++];
	}};
};
var Strings = function() { };
Strings.__name__ = true;
var Location = function(tag,description) {
	this.tag = tag;
	this.description = description;
	this.actions = [];
};
Location.__name__ = true;
var Desk = function(world) {
	Location.call(this,"Desktop","The old rig, designed for a hacker on steroids");
	this.actions.push(new Action(["computer"],8,[{ problem : 0, effect : function(world1) {
		terminal.echo("You turn to your desktop, the page is open and ready. You salivate in anticipation.");
	}}]));
};
Desk.__name__ = true;
Desk.__super__ = Location;
Desk.prototype = $extend(Location.prototype,{
});
var Fridge = function(world) {
	var _g = this;
	Location.call(this,"Fridge","The new fridge");
	this.foods = [{ name : "tin of beans", descriptions : ["It says best before June 2012"], effects : function(actor) {
		var _g1 = actor.motives[2];
		_g1.set_value(_g1.value - 0.2);
		var _g2 = actor.motives[4];
		_g2.set_value(_g2.value + 0.1);
		var _g3 = actor.motives[3];
		_g3.set_value(_g3.value - 0.05);
	}},{ name : "tin of beans", descriptions : ["It says best before June 2012"], effects : function(actor1) {
		var _g4 = actor1.motives[2];
		_g4.set_value(_g4.value - 0.2);
		var _g5 = actor1.motives[4];
		_g5.set_value(_g5.value + 0.1);
	}},{ name : "tin of beans", descriptions : ["It says best before June 2012"], effects : function(actor2) {
		var _g6 = actor2.motives[2];
		_g6.set_value(_g6.value - 0.2);
		var _g7 = actor2.motives[4];
		_g7.set_value(_g7.value + 0.1);
	}},{ name : "tin of beans", descriptions : ["It says best before June 2012"], effects : function(actor3) {
		var _g8 = actor3.motives[2];
		_g8.set_value(_g8.value - 0.2);
		var _g9 = actor3.motives[4];
		_g9.set_value(_g9.value + 0.1);
	}},{ name : "tin of beans", descriptions : ["It says best before June 2012"], effects : function(actor4) {
		var _g10 = actor4.motives[2];
		_g10.set_value(_g10.value - 0.2);
		var _g11 = actor4.motives[4];
		_g11.set_value(_g11.value + 0.1);
	}}];
	this.actions.push(new Action(["eat"],10,[{ problem : 2, effect : function(world1) {
		terminal.echo("You " + markov_util_ArrayExtensions.randomElement(Strings.walkingAdjective) + " to the fridge and grab the first thing you see... ");
		var item = markov_util_ArrayExtensions.randomElement(_g.foods);
		terminal.echo("It's a " + item.name + ". " + markov_util_ArrayExtensions.randomElement(item.descriptions) + ". You " + markov_util_ArrayExtensions.randomElement(Strings.eatingDescription) + ".");
		item.effects(world1.actor);
	}}]));
};
Fridge.__name__ = true;
Fridge.__super__ = Location;
Fridge.prototype = $extend(Location.prototype,{
});
var Bed = function(world) {
	Location.call(this,"Bed","The old bed");
	this.actions.push(new Action(["sleep"],40,[{ problem : 1, effect : function(world1) {
		terminal.echo("You settle down for forty winks.");
	}}]));
};
Bed.__name__ = true;
Bed.__super__ = Location;
Bed.prototype = $extend(Location.prototype,{
});
var Shower = function(world) {
	Location.call(this,"Shower","The shower.");
	this.actions.push(new Action(["shower"],15,[{ problem : 3, effect : function(world1) {
		terminal.echo("You wash the filth off your body.");
	}}]));
};
Shower.__name__ = true;
Shower.__super__ = Location;
Shower.prototype = $extend(Location.prototype,{
});
var Toilet = function(world) {
	Location.call(this,"Toilet","The toilet.");
	this.actions.push(new Action(["toilet"],5,[{ problem : 4, effect : function(world1) {
		terminal.echo("You relieve yourself.");
	}}]));
};
Toilet.__name__ = true;
Toilet.__super__ = Location;
Toilet.prototype = $extend(Location.prototype,{
});
var Motive = function(id,initialValue,drainRate,drainModifier,tag,drainCurve) {
	if(tag == null) tag = "Unnamed Motive";
	if(drainModifier == null) drainModifier = 1.0;
	if(drainRate == null) drainRate = 0.01;
	this.id = id;
	this.set_value(initialValue);
	this.drainRate = drainRate;
	this.modifier = drainModifier;
	this.tag = tag;
	if(drainCurve != null) this.drainCurve = drainCurve; else this.drainCurve = function(v) {
		return v;
	};
};
Motive.__name__ = true;
Motive.prototype = {
	update: function(dt) {
		var _g = this;
		_g.set_value(_g.value + this.drainCurve(dt * this.drainRate * this.modifier));
	}
	,set_value: function(v) {
		return v < 0?this.value = 0:v > 1?this.value = 1:this.value = v;
	}
};
var Action = function(trigger,duration,effects) {
	this.trigger = trigger;
	this.duration = duration;
	this.effects = effects;
};
Action.__name__ = true;
var Actor = function(world) {
	this.world = world;
	this.motives = [];
	this.traits = new haxe_ds_IntMap();
	this.experiences = [];
	this.autonomous = true;
	this.motives.push(new Motive(0,0.50,0.03,1.0,"Boredom"));
	this.motives.push(new Motive(1,0.07,0.01,1.0,"Tiredness"));
	this.motives.push(new Motive(2,0.5,0.04,1.0,"Hunger"));
	this.motives.push(new Motive(3,0.3,0.06,1.0,"Hygiene"));
	this.motives.push(new Motive(4,0.5,0.07,1.0,"Bladder"));
};
Actor.__name__ = true;
Actor.prototype = {
	act: function() {
		var _g = 0;
		var _g1 = this.experiences;
		while(_g < _g1.length) {
			var action = _g1[_g];
			++_g;
			var _g2 = 0;
			var _g3 = action.effects;
			while(_g2 < _g3.length) {
				var effect = _g3[_g2];
				++_g2;
				effect.effect(this.world);
				this.motives[effect.problem].update(action.duration);
			}
		}
		this.experiences = [];
	}
	,step: function(dt) {
		var _g = 0;
		var _g1 = this.motives;
		while(_g < _g1.length) {
			var motive = _g1[_g];
			++_g;
			motive.update(dt);
		}
	}
};
var World = function() {
	this.livesRuined = 0;
	this.feelingsHurt = 0;
	this.set_minutes(0);
	this.lastUpdateMinutes = 0;
	this.actor = new Actor(this);
	this.actions = [];
	this.context = new haxe_ds_GenericStack();
};
World.__name__ = true;
World.prototype = {
	update: function(dt) {
		this.actor.step(dt);
	}
	,set_minutes: function(min) {
		if(this.clock != null) this.clock.setTime(min * 60);
		return this.minutes = min;
	}
};
var Main = function() {
	window.onload = $bind(this,this.onWindowLoaded);
};
Main.__name__ = true;
Main.main = function() {
	new Main();
};
Main.prototype = {
	handleAction: function(action) {
		this.world.actor.experiences.push(action);
		this.world.actor.act();
		var _g = this.world;
		_g.set_minutes(_g.minutes + action.duration);
		var _g1 = 0;
		var _g11 = action.effects;
		while(_g1 < _g11.length) {
			var effect = _g11[_g1];
			++_g1;
			var graph = this.graphs.h[effect.problem];
			graph.addData({ time : this.world.minutes, value : this.world.actor.motives[effect.problem].value},this.world.minutes);
		}
	}
	,flail: function() {
		terminal.echo(markov_util_ArrayExtensions.randomElement(Strings.unrecognizedCommand),{ });
	}
	,onWindowLoaded: function() {
		var _g = this;
		this.gameOver = false;
		this.world = new World();
		this.world.clock = new FlipClock.Factory(window.document.getElementById("time"),{ });
		this.world.clock.stop();
		this.world.context.add(new Desk(this.world));
		this.world.context.add(new Bed(this.world));
		this.world.context.add(new Fridge(this.world));
		this.world.context.add(new Shower(this.world));
		this.world.context.add(new Toilet(this.world));
		this.generateActionButtons();
		this.generateSettingsButtons();
		terminal.push(function(command,terminal) {
			var recognizedCommand = false;
			var $it0 = _g.world.context.iterator();
			while( $it0.hasNext() ) {
				var location = $it0.next();
				var _g12 = 0;
				var _g21 = location.actions;
				while(_g12 < _g21.length) {
					var action = _g21[_g12];
					++_g12;
					var containsParts = true;
					var _g3 = 0;
					var _g4 = action.trigger;
					while(_g3 < _g4.length) {
						var part = _g4[_g3];
						++_g3;
						if(!(command.indexOf(part) >= 0)) {
							containsParts = false;
							break;
						}
					}
					if(action.trigger.length != 0 && containsParts) {
						recognizedCommand = true;
						_g.handleAction(action);
					}
				}
			}
			if(!recognizedCommand && command.length != 0) terminal.echo(markov_util_ArrayExtensions.randomElement(Strings.unrecognizedCommand),{ });
			_g.generateActionButtons();
		},{ greetings : false, name : ">"});
		terminal.echo("You have 24 hours...",{ });
		this.graphs = new haxe_ds_IntMap();
		var _g5 = 0;
		var _g13 = this.world.actor.motives;
		while(_g5 < _g13.length) {
			var motive1 = _g13[_g5];
			++_g5;
			var graph2 = new NeedGraph(motive1,[{ time : 0, value : motive1.value}],"#graphs",200,100);
			this.graphs.h[motive1.id] = graph2;
		}
		var f = window.setInterval(function() {
			var _g1 = _g.world;
			_g1.set_minutes(_g1.minutes + 1);
			_g.world.update(1);
			var $it1 = _g.graphs.iterator();
			while( $it1.hasNext() ) {
				var graph = $it1.next();
				var _g11 = 0;
				var _g2 = _g.world.actor.motives;
				while(_g11 < _g2.length) {
					var motive = _g2[_g11];
					++_g11;
					var graph1 = _g.graphs.h[motive.id];
					graph1.addData({ time : _g.world.minutes, value : motive.value},_g.world.minutes);
				}
			}
			if(_g.world.minutes >= 1440) {
				_g.gameOver = true;
				_g.world.clock.stop();
				terminal.echo("Time's up. Better start looking for a job...",{ });
			}
		},1000);
	}
	,generateActionButtons: function() {
		var _g2 = this;
		var actions = window.document.getElementById("actions");
		while(actions.hasChildNodes()) actions.removeChild(actions.lastChild);
		var $it0 = this.world.context.iterator();
		while( $it0.hasNext() ) {
			var location = $it0.next();
			var _g = 0;
			var _g1 = location.actions;
			while(_g < _g1.length) {
				var action = [_g1[_g]];
				++_g;
				var triggers = action[0].trigger.toString();
				var btn = window.document.createElement("button");
				var t = window.document.createTextNode(triggers);
				btn.appendChild(t);
				actions.appendChild(btn);
				btn.onclick = (function(action) {
					return function() {
						_g2.handleAction(action[0]);
					};
				})(action);
			}
		}
	}
	,generateSettingsButtons: function() {
		var _g = this;
		var settings = window.document.getElementById("settings");
		var btn = window.document.createElement("button");
		var t = window.document.createTextNode("toggle AI");
		btn.appendChild(t);
		settings.appendChild(btn);
		btn.onclick = function() {
			_g.world.actor.autonomous = !_g.world.actor.autonomous;
		};
	}
};
var NeedGraph = function(need,data,elementId,width,height) {
	this.maxY = 1;
	this.minY = 0;
	var _g = this;
	this.data = data;
	this.title = need.tag;
	this.elementId = elementId;
	this.graphId = StringTools.replace(elementId,"#","") + "_" + (need.id == null?"null":"" + need.id);
	var margin_top = 20;
	var margin_right = 20;
	var margin_bottom = 30;
	var margin_left = 50;
	this.width = width - margin_left - margin_right;
	this.height = height - margin_top - margin_bottom;
	this.x = d3.scale.linear().range([0,width]);
	this.y = d3.scale.linear().range([height,0]);
	this.x.domain(d3.extent(data,function(d) {
		return d.time;
	}));
	this.y.domain([this.minY,this.maxY]);
	this.xAxis = d3.svg.axis().scale(this.x).orient("bottom").ticks(4);
	this.yAxis = d3.svg.axis().scale(this.y).orient("left").ticks(4);
	this.line = d3.svg.line().x(function(d1) {
		return _g.x(d1.time);
	}).y(function(d2) {
		return _g.y(d2.value);
	});
	this.svg = d3.select(elementId).append("svg").attr("class",this.graphId).attr("width",width + margin_left + margin_right).attr("height",height + margin_top + margin_bottom).append("g").attr("transform","translate(" + margin_left + "," + margin_top + ")");
	this.svg.append("g").attr("class","xaxis").attr("transform","translate(0," + height + ")").call(this.xAxis);
	this.svg.append("g").attr("class","yaxis").call(this.yAxis);
	this.svg.append("g").attr("class","title").append("text").attr("x",width / 2).attr("y",-margin_top / 2).attr("text-anchor","middle").text(need.tag);
	this.svg.append("path").datum(data).attr("class","line").attr("d",this.line);
};
NeedGraph.__name__ = true;
NeedGraph.prototype = {
	updateData: function(minutes) {
		var _g = this;
		this.x.domain([0,minutes]);
		this.line = d3.svg.line().x(function(d) {
			return _g.x(d.time);
		}).y(function(d1) {
			return _g.y(d1.value);
		});
		var sel = d3.select("." + this.graphId).transition();
		sel.select(".line").attr("d",this.line);
		sel.select(".xaxis").call(this.xAxis);
		sel.select(".yaxis").call(this.yAxis);
	}
	,addData: function(d,worldMinutes) {
		this.data.push(d);
		this.updateData(worldMinutes);
	}
};
Math.__name__ = true;
var Std = function() { };
Std.__name__ = true;
Std.random = function(x) {
	if(x <= 0) return 0; else return Math.floor(Math.random() * x);
};
var StringTools = function() { };
StringTools.__name__ = true;
StringTools.replace = function(s,sub,by) {
	return s.split(sub).join(by);
};
var haxe_IMap = function() { };
haxe_IMap.__name__ = true;
var haxe_ds_GenericCell = function(elt,next) {
	this.elt = elt;
	this.next = next;
};
haxe_ds_GenericCell.__name__ = true;
var haxe_ds_GenericStack = function() {
};
haxe_ds_GenericStack.__name__ = true;
haxe_ds_GenericStack.prototype = {
	add: function(item) {
		this.head = new haxe_ds_GenericCell(item,this.head);
	}
	,iterator: function() {
		var l = this.head;
		return { hasNext : function() {
			return l != null;
		}, next : function() {
			var k = l;
			l = k.next;
			return k.elt;
		}};
	}
};
var haxe_ds_IntMap = function() {
	this.h = { };
};
haxe_ds_IntMap.__name__ = true;
haxe_ds_IntMap.__interfaces__ = [haxe_IMap];
haxe_ds_IntMap.prototype = {
	keys: function() {
		var a = [];
		for( var key in this.h ) {
		if(this.h.hasOwnProperty(key)) a.push(key | 0);
		}
		return HxOverrides.iter(a);
	}
	,iterator: function() {
		return { ref : this.h, it : this.keys(), hasNext : function() {
			return this.it.hasNext();
		}, next : function() {
			var i = this.it.next();
			return this.ref[i];
		}};
	}
};
var js__$Boot_HaxeError = function(val) {
	Error.call(this);
	this.val = val;
	this.message = String(val);
	if(Error.captureStackTrace) Error.captureStackTrace(this,js__$Boot_HaxeError);
};
js__$Boot_HaxeError.__name__ = true;
js__$Boot_HaxeError.__super__ = Error;
js__$Boot_HaxeError.prototype = $extend(Error.prototype,{
});
var js_Boot = function() { };
js_Boot.__name__ = true;
js_Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) t = "object";
	switch(t) {
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) return o[0];
				var str2 = o[0] + "(";
				s += "\t";
				var _g1 = 2;
				var _g = o.length;
				while(_g1 < _g) {
					var i1 = _g1++;
					if(i1 != 2) str2 += "," + js_Boot.__string_rec(o[i1],s); else str2 += js_Boot.__string_rec(o[i1],s);
				}
				return str2 + ")";
			}
			var l = o.length;
			var i;
			var str1 = "[";
			s += "\t";
			var _g2 = 0;
			while(_g2 < l) {
				var i2 = _g2++;
				str1 += (i2 > 0?",":"") + js_Boot.__string_rec(o[i2],s);
			}
			str1 += "]";
			return str1;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			if (e instanceof js__$Boot_HaxeError) e = e.val;
			return "???";
		}
		if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str.length != 2) str += ", \n";
		str += s + k + " : " + js_Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str += "\n" + s + "}";
		return str;
	case "function":
		return "<function>";
	case "string":
		return o;
	default:
		return String(o);
	}
};
var js_d3__$D3_InitPriority = function() { };
js_d3__$D3_InitPriority.__name__ = true;
var markov_util_ArrayExtensions = function() { };
markov_util_ArrayExtensions.__name__ = true;
markov_util_ArrayExtensions.randomElementFromArrays = function(arrays) {
	if(!(arrays != null && arrays.length != 0)) throw new js__$Boot_HaxeError("FAIL: arrays != null && arrays.length != 0");
	var totalLength = 0;
	var lengths = [];
	var _g = 0;
	while(_g < arrays.length) {
		var array = arrays[_g];
		++_g;
		if(!(array != null && array.length != 0)) throw new js__$Boot_HaxeError("FAIL: array != null && array.length != 0");
		totalLength += array.length;
		lengths.push(totalLength);
	}
	var n = Math.random() * totalLength;
	var i = 0;
	while(i < lengths.length) {
		if(n < lengths[i]) return markov_util_ArrayExtensions.randomElement(arrays[i]);
		i++;
	}
	throw new js__$Boot_HaxeError("Failed to get random element");
};
markov_util_ArrayExtensions.randomElement = function(array) {
	if(!(array != null && array.length != 0)) throw new js__$Boot_HaxeError("FAIL: array != null && array.length != 0");
	return array[Std.random(array.length)];
};
markov_util_ArrayExtensions.noNulls = function(array) {
	if(!(array != null)) throw new js__$Boot_HaxeError("FAIL: array != null");
	var _g = 0;
	while(_g < array.length) {
		var e = array[_g];
		++_g;
		if(e == null) return false;
	}
	return true;
};
markov_util_ArrayExtensions.binarySearchCmp = function(a,x,min,max,comparator) {
	if(!(a != null)) throw new js__$Boot_HaxeError("FAIL: a != null");
	if(!(min >= 0 && min < a.length)) throw new js__$Boot_HaxeError("FAIL: min >= 0 && min < a.length");
	if(!(max >= 0 && max < a.length)) throw new js__$Boot_HaxeError("FAIL: max >= 0 && max < a.length");
	if(!(comparator != null)) throw new js__$Boot_HaxeError("FAIL: comparator != null");
	var low = min;
	var high = max + 1;
	var middle;
	while(low < high) {
		middle = low + (high - low >> 1);
		if(comparator(a[middle],x) < 0) low = middle + 1; else high = middle;
	}
	if(low <= max && comparator(a[low],x) == 0) return low; else return ~low;
};
markov_util_ArrayExtensions.binarySearch = function(a,x,min,max) {
	if(!(a != null)) throw new js__$Boot_HaxeError("FAIL: a != null");
	if(!(min >= 0 && min < a.length)) throw new js__$Boot_HaxeError("FAIL: min >= 0 && min < a.length");
	if(!(max >= 0 && max < a.length)) throw new js__$Boot_HaxeError("FAIL: max >= 0 && max < a.length");
	var low = min;
	var high = max + 1;
	var middle;
	while(low < high) {
		middle = low + (high - low >> 1);
		if(a[middle] < x) low = middle + 1; else high = middle;
	}
	if(low <= max && a[low] == x) return low; else return ~low;
};
var markov_util_FloatExtensions = function() { };
markov_util_FloatExtensions.__name__ = true;
markov_util_FloatExtensions.clamp = function(v,min,max) {
	if(v < min) return min; else if(v > max) return max; else return v;
};
markov_util_FloatExtensions.max = function(a,b) {
	if(a > b) return a; else return b;
};
markov_util_FloatExtensions.min = function(a,b) {
	if(a < b) return a; else return b;
};
markov_util_FloatExtensions.inRangeInclusive = function(p,x1,x2) {
	return p >= Math.min(x1,x2) && p <= Math.max(x1,x2);
};
markov_util_FloatExtensions.inRangeExclusive = function(p,x1,x2) {
	return p > Math.min(x1,x2) && p < Math.max(x1,x2);
};
markov_util_FloatExtensions.lerp = function(v,a,b) {
	return (b - a) * v + a;
};
markov_util_FloatExtensions.coslerp = function(v,a,b) {
	var c = (1 - Math.cos(v * Math.PI)) / 2;
	return a * (1 - c) + b * c;
};
markov_util_FloatExtensions.sign = function(x) {
	if(x > 0) return 1; else if(x < 0) return -1; else return 0;
};
markov_util_FloatExtensions.fpart = function(x) {
	if(x < 0) return 1 - (x - Math.floor(x)); else return x - Math.floor(x);
};
markov_util_FloatExtensions.rfpart = function(x) {
	return 1.0 - (x < 0?1 - (x - Math.floor(x)):x - Math.floor(x));
};
markov_util_FloatExtensions.wrap = function(x,lower,upper) {
	if(!(lower <= upper)) throw new js__$Boot_HaxeError("FAIL: lower <= upper");
	var range = upper - lower + 1;
	x = (x - lower) % range;
	if(x < 0) return upper + 1 + x; else return lower + x;
};
var markov_util_StringExtensions = function() { };
markov_util_StringExtensions.__name__ = true;
markov_util_StringExtensions.reverse = function(s) {
	if(!(s != null)) throw new js__$Boot_HaxeError("FAIL: s != null");
	var arr = s.split("");
	arr.reverse();
	return arr.join("");
};
markov_util_StringExtensions.repeat = function(s,times) {
	if(!(s != null)) throw new js__$Boot_HaxeError("FAIL: s != null");
	if(!(times >= 1)) throw new js__$Boot_HaxeError("FAIL: times >= 1");
	var output = "";
	var _g = 0;
	while(_g < times) {
		var i = _g++;
		output += s;
	}
	return output;
};
markov_util_StringExtensions.contains = function(s,substr) {
	return s.indexOf(substr) >= 0;
};
markov_util_StringExtensions.capitalize = function(s) {
	return HxOverrides.substr(s,0,1).toUpperCase() + HxOverrides.substr(s,1,s.length - 1);
};
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
String.__name__ = true;
Array.__name__ = true;
Strings.walkingAdjective = ["shuffle","waddle","dodder","shamble","lurch","stumble","reel","stagger"];
Strings.eatingDescription = ["wolf it down","gobble it greedily","feast on it","voraciously scarf it down"];
Strings.unrecognizedCommand = ["You flail uselessly."];
js_d3__$D3_InitPriority.important = "important";
Main.main();
})(typeof console != "undefined" ? console : {log:function(){}});
