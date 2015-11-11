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
	this.actions.push(new TriggerAction(0,["computer"],8,[{ id : 0, effect : function(world1) {
		terminal.echo("You turn to your desktop, the page is open and ready. You salivate in anticipation.");
		var _g = world1.agent.brain.needs[0];
		_g.set_value(_g.value - 0.2);
	}}]));
};
Desk.__name__ = true;
Desk.__super__ = Location;
Desk.prototype = $extend(Location.prototype,{
});
var Fridge = function(world) {
	var _g = this;
	Location.call(this,"Fridge","The new fridge");
	this.foods = [{ name : "tin of beans", descriptions : ["It says best before June 2012"], effects : function(brain) {
		var _g1 = brain.needs[2];
		_g1.set_value(_g1.value - 0.2);
		var _g2 = brain.needs[4];
		_g2.set_value(_g2.value + 0.1);
		var _g3 = brain.needs[3];
		_g3.set_value(_g3.value - 0.05);
	}},{ name : "tin of beans", descriptions : ["It says best before June 2012"], effects : function(brain1) {
		var _g4 = brain1.needs[2];
		_g4.set_value(_g4.value - 0.2);
		var _g5 = brain1.needs[4];
		_g5.set_value(_g5.value + 0.1);
	}},{ name : "tin of beans", descriptions : ["It says best before June 2012"], effects : function(brain2) {
		var _g6 = brain2.needs[2];
		_g6.set_value(_g6.value - 0.2);
		var _g7 = brain2.needs[4];
		_g7.set_value(_g7.value + 0.1);
	}},{ name : "tin of beans", descriptions : ["It says best before June 2012"], effects : function(brain3) {
		var _g8 = brain3.needs[2];
		_g8.set_value(_g8.value - 0.2);
		var _g9 = brain3.needs[4];
		_g9.set_value(_g9.value + 0.1);
	}},{ name : "tin of beans", descriptions : ["It says best before June 2012"], effects : function(brain4) {
		var _g10 = brain4.needs[2];
		_g10.set_value(_g10.value - 0.2);
		var _g11 = brain4.needs[4];
		_g11.set_value(_g11.value + 0.1);
	}}];
	this.actions.push(new TriggerAction(2,["eat"],10,[{ id : 2, effect : function(world1) {
		terminal.echo("You " + util_ArrayExtensions.randomElement(Strings.walkingAdjective) + " to the fridge and grab the first thing you see... ");
		var item = util_ArrayExtensions.randomElement(_g.foods);
		terminal.echo("It's a " + item.name + ". " + util_ArrayExtensions.randomElement(item.descriptions) + ". You " + util_ArrayExtensions.randomElement(Strings.eatingDescription) + ".");
		item.effects(world1.agent.brain);
	}}]));
};
Fridge.__name__ = true;
Fridge.__super__ = Location;
Fridge.prototype = $extend(Location.prototype,{
});
var Bed = function(world) {
	Location.call(this,"Bed","The old bed");
	this.actions.push(new TriggerAction(1,["sleep"],40,[{ id : 1, effect : function(world1) {
		terminal.echo("You settle down for forty winks.");
		var rest = Math.random() * 0.5 + 0.3;
		var _g = world1.agent.brain.needs[1];
		_g.set_value(_g.value - rest);
	}}]));
};
Bed.__name__ = true;
Bed.__super__ = Location;
Bed.prototype = $extend(Location.prototype,{
});
var Shower = function(world) {
	Location.call(this,"Shower","The shower.");
	this.actions.push(new TriggerAction(3,["shower"],15,[{ id : 3, effect : function(world1) {
		terminal.echo("You wash the filth off your body.");
		var clean = 0.3;
		var _g = world1.agent.brain.needs[3];
		_g.set_value(_g.value - clean);
	}}]));
};
Shower.__name__ = true;
Shower.__super__ = Location;
Shower.prototype = $extend(Location.prototype,{
});
var Toilet = function(world) {
	Location.call(this,"Toilet","The toilet.");
	this.actions.push(new TriggerAction(4,["toilet"],5,[{ id : 4, effect : function(world1) {
		terminal.echo("You relieve yourself.");
		var _g = world1.agent.brain.needs[4];
		_g.set_value(_g.value - 1.0);
	}}]));
};
Toilet.__name__ = true;
Toilet.__super__ = Location;
Toilet.prototype = $extend(Location.prototype,{
});
var Main = function() {
	this.signal_consoleActionIssued = new msignal_Signal1();
	this.signal_actionButtonPressed = new msignal_Signal1();
	window.onload = $bind(this,this.onWindowLoaded);
};
Main.__name__ = true;
Main.main = function() {
	new Main();
};
Main.prototype = {
	onWindowLoaded: function() {
		this.world = new World();
		this.createTerminal();
		this.generateActionButtons();
		this.generateSliders();
		this.generateGraphs();
		this.connectStrategySelection();
		this.updateHandle = null;
		this.set_updateInterval(1000);
		this.signal_actionButtonPressed.add($bind(this,this.handleAction));
		this.signal_consoleActionIssued.add($bind(this,this.handleAction));
		this.world.agent.brain.signal_selectedAction.add($bind(this,this.handleAction));
	}
	,update: function() {
		var _g = this.world;
		_g.set_minutes(_g.minutes + 1);
		this.world.update(1);
		var $it0 = this.graphs.iterator();
		while( $it0.hasNext() ) {
			var graph = $it0.next();
			var _g1 = 0;
			var _g11 = this.world.agent.brain.needs;
			while(_g1 < _g11.length) {
				var motive = _g11[_g1];
				++_g1;
				var graph1 = this.graphs.h[motive.id];
				graph1.addData({ time : this.world.minutes, value : motive.value},this.world.minutes);
			}
		}
		if(this.world.minutes >= 1440) {
			this.world.gameover = true;
			this.world.clock.stop();
			terminal.echo("Time's up. Better start looking for a job...");
		}
	}
	,handleAction: function(action) {
		this.world.agent.act(action);
		var _g = this.world;
		_g.set_minutes(_g.minutes + action.duration);
		var _g1 = 0;
		var _g11 = action.effects;
		while(_g1 < _g11.length) {
			var effect = _g11[_g1];
			++_g1;
			var graph = this.graphs.h[effect.id];
			graph.addData({ time : this.world.minutes, value : this.world.agent.brain.needs[effect.id].value},this.world.minutes);
		}
	}
	,createTerminal: function() {
		var _g = this;
		terminal.push(function(command,terminal) {
			var recognizedCommand = false;
			var $it0 = _g.world.context.iterator();
			while( $it0.hasNext() ) {
				var location = $it0.next();
				var _g1 = 0;
				var _g2 = location.actions;
				while(_g1 < _g2.length) {
					var action = _g2[_g1];
					++_g1;
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
						_g.signal_consoleActionIssued.dispatch(action);
					}
				}
			}
			if(!recognizedCommand && command.length != 0) terminal.echo(util_ArrayExtensions.randomElement(Strings.unrecognizedCommand));
		},{ greetings : false, name : ">"});
		terminal.echo("You have 24 hours...");
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
						_g2.signal_actionButtonPressed.dispatch(action[0]);
					};
				})(action);
			}
		}
	}
	,generateSliders: function() {
		var _g = this;
		this.updateRateElement = window.document.getElementById("clockspeed");
		noUiSlider.create(this.updateRateElement,{ connect : "lower", start : 1, range : { 'min' : [0,0.1], 'max' : 10}, format : new wNumb({ decimals : 1}), pips : { mode : "range", density : 10}});
		this.createTooltips(this.updateRateElement);
		this.updateRateElement.noUiSlider.on("change",function(values,handle,rawValues) {
			_g.set_updateInterval(1000 / values[handle] | 0);
		});
		this.updateRateElement.noUiSlider.on("update",function(values1,handle1,rawValues1) {
			_g.updateTooltips(_g.updateRateElement,handle1,values1[handle1]);
		});
	}
	,connectStrategySelection: function() {
		var _g = this;
		this.strategyElement = window.document.getElementById("strategy");
		this.strategyElement.addEventListener("change",function() {
			if(_g.strategyElement.value != null) _g.world.agent.aiMode = _g.strategyElement.value;
		},false);
	}
	,createTooltips: function(slider) {
		var tipHandles = slider.getElementsByClassName("noUi-handle");
		var _g1 = 0;
		var _g = tipHandles.length;
		while(_g1 < _g) {
			var i = _g1++;
			var div = window.document.createElement("div");
			div.className += "tooltip";
			tipHandles[i].appendChild(div);
			this.updateTooltips(slider,i,0);
		}
	}
	,updateTooltips: function(slider,handleIdx,value) {
		var tipHandles = slider.getElementsByClassName("noUi-handle");
		tipHandles[handleIdx].innerHTML = "<span class='tooltip'>" + (value == null?"null":"" + value) + "</span>";
	}
	,generateGraphs: function() {
		this.graphs = new haxe_ds_IntMap();
		var _g = 0;
		var _g1 = this.world.agent.brain.needs;
		while(_g < _g1.length) {
			var motive = _g1[_g];
			++_g;
			var graph = new NeedGraph(motive,[{ time : 0, value : motive.value}],"#graphs",150,100);
			this.graphs.h[motive.id] = graph;
		}
	}
	,set_updateInterval: function(time) {
		if(this.updateHandle != null) window.clearInterval(this.updateHandle);
		this.updateHandle = window.setInterval($bind(this,this.update),time);
		return time;
	}
};
var ai_Action = function(id,duration,effects) {
	this.id = id;
	this.duration = duration;
	this.effects = effects;
};
ai_Action.__name__ = true;
var TriggerAction = function(id,trigger,duration,effects) {
	ai_Action.call(this,id,duration,effects);
	this.trigger = trigger;
};
TriggerAction.__name__ = true;
TriggerAction.__super__ = ai_Action;
TriggerAction.prototype = $extend(ai_Action.prototype,{
});
Math.__name__ = true;
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
var Reflect = function() { };
Reflect.__name__ = true;
Reflect.isFunction = function(f) {
	return typeof(f) == "function" && !(f.__name__ || f.__ename__);
};
Reflect.compareMethods = function(f1,f2) {
	if(f1 == f2) return true;
	if(!Reflect.isFunction(f1) || !Reflect.isFunction(f2)) return false;
	return f1.scope == f2.scope && f1.method == f2.method && f1.method != null;
};
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
var Agent = function(brain) {
	this.brain = brain;
	this.aiMode = "highest_needs";
};
Agent.__name__ = true;
Agent.prototype = {
	act: function(action) {
		this.brain.act(action);
	}
	,update: function(dt) {
		this.brain.update(dt);
	}
};
var World = function() {
	this.clock = new FlipClock.Factory(window.document.getElementById("time"));
	this.clock.stop();
	this.set_minutes(0);
	this.gameover = false;
	this.context = new haxe_ds_GenericStack();
	this.context.add(new Desk(this));
	this.context.add(new Bed(this));
	this.context.add(new Fridge(this));
	this.context.add(new Shower(this));
	this.context.add(new Toilet(this));
	var needs = [];
	needs.push(new ai_Need(0,0.20,0.03,1.0,null,"Boredom"));
	needs.push(new ai_Need(1,0.07,0.01,1.0,null,"Tiredness"));
	needs.push(new ai_Need(2,0.25,0.04,1.0,null,"Hunger"));
	needs.push(new ai_Need(3,0.10,0.02,1.0,null,"Hygiene"));
	needs.push(new ai_Need(4,0.30,0.03,1.0,null,"Bladder"));
	this.agent = new Agent(new ai_Brain(this,needs));
};
World.__name__ = true;
World.prototype = {
	update: function(dt) {
		this.agent.update(dt);
		var _g = 0;
		var _g1 = this.agent.brain.needs;
		while(_g < _g1.length) {
			var need = _g1[_g];
			++_g;
			if(need.value >= 1.0) this.gameover = true;
		}
	}
	,set_minutes: function(min) {
		if(this.clock != null) this.clock.setTime(min * 60);
		return this.minutes = min;
	}
	,queryContextForActions: function(need) {
		var actions = [];
		var $it0 = this.context.iterator();
		while( $it0.hasNext() ) {
			var location = $it0.next();
			var _g = 0;
			var _g1 = location.actions;
			while(_g < _g1.length) {
				var action = _g1[_g];
				++_g;
				var addedAction = false;
				var _g2 = 0;
				var _g3 = action.effects;
				while(_g2 < _g3.length) {
					var effect = _g3[_g2];
					++_g2;
					if(need.id == effect.id) {
						actions.push(action);
						break;
					}
				}
			}
		}
		return actions;
	}
};
var ai_Brain = function(world,needs) {
	this.signal_selectedAction = new msignal_Signal1();
	this.world = world;
	this.needs = needs;
	this.needTraits = new haxe_ds_IntMap();
};
ai_Brain.__name__ = true;
ai_Brain.prototype = {
	act: function(action) {
		var _g = 0;
		var _g1 = action.effects;
		while(_g < _g1.length) {
			var effect = _g1[_g];
			++_g;
			effect.effect(this.world);
		}
	}
	,update: function(dt) {
		var _g = 0;
		var _g1 = this.needs;
		while(_g < _g1.length) {
			var motive = _g1[_g];
			++_g;
			motive.update(dt);
		}
		var need;
		var _g2 = this.world.agent.aiMode;
		switch(_g2) {
		case "highest_needs":
			need = this.getGreatestNeed();
			break;
		case "true_random":
			need = util_ArrayExtensions.randomElement(this.needs);
			break;
		case "weighted_random":
			need = this.needs[0];
			break;
		default:
			need = null;
		}
		if(need != null) this.actOnNeed(need);
	}
	,getGreatestNeed: function() {
		var idx = 0;
		var value = 0;
		var _g1 = 0;
		var _g = this.needs.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(this.needs[i].value > value) {
				value = this.needs[idx].value;
				idx = i;
			}
		}
		return this.needs[idx];
	}
	,getWeightedRandomNeed: function() {
		return this.needs[0];
	}
	,getRandomNeed: function() {
		return util_ArrayExtensions.randomElement(this.needs);
	}
	,actOnNeed: function(need) {
		var actions = this.world.queryContextForActions(need);
		this.signal_selectedAction.dispatch((function($this) {
			var $r;
			if(!(actions != null && actions.length != 0)) throw new js__$Boot_HaxeError("FAIL: array != null && array.length != 0");
			$r = actions[Std.random(actions.length)];
			return $r;
		}(this)));
	}
	,findActions: function(need) {
		return this.world.queryContextForActions(need);
	}
};
var ai_Need = function(id,initialValue,growthRate,growthModifier,growthCurve,tag) {
	if(tag == null) tag = "Unnamed Motive";
	if(growthModifier == null) growthModifier = 1.0;
	if(growthRate == null) growthRate = 0.01;
	this.id = id;
	this.set_value(initialValue);
	this.growthRate = growthRate;
	this.growthModifier = growthModifier;
	this.tag = tag;
	if(growthCurve != null) this.growthCurve = growthCurve; else this.growthCurve = $bind(this,this.linear);
};
ai_Need.__name__ = true;
ai_Need.prototype = {
	update: function(dt) {
		var _g = this;
		_g.set_value(_g.value + this.growthCurve(dt * this.growthRate * this.growthModifier));
	}
	,set_value: function(v) {
		return v < 0?this.value = 0:v > 1?this.value = 1:this.value = v;
	}
	,linear: function(v) {
		return v;
	}
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
var msignal_Signal = function(valueClasses) {
	if(valueClasses == null) valueClasses = [];
	this.valueClasses = valueClasses;
	this.slots = msignal_SlotList.NIL;
	this.priorityBased = false;
};
msignal_Signal.__name__ = true;
msignal_Signal.prototype = {
	add: function(listener) {
		return this.registerListener(listener);
	}
	,addOnce: function(listener) {
		return this.registerListener(listener,true);
	}
	,addWithPriority: function(listener,priority) {
		if(priority == null) priority = 0;
		return this.registerListener(listener,false,priority);
	}
	,addOnceWithPriority: function(listener,priority) {
		if(priority == null) priority = 0;
		return this.registerListener(listener,true,priority);
	}
	,remove: function(listener) {
		var slot = this.slots.find(listener);
		if(slot == null) return null;
		this.slots = this.slots.filterNot(listener);
		return slot;
	}
	,removeAll: function() {
		this.slots = msignal_SlotList.NIL;
	}
	,registerListener: function(listener,once,priority) {
		if(priority == null) priority = 0;
		if(once == null) once = false;
		if(this.registrationPossible(listener,once)) {
			var newSlot = this.createSlot(listener,once,priority);
			if(!this.priorityBased && priority != 0) this.priorityBased = true;
			if(!this.priorityBased && priority == 0) this.slots = this.slots.prepend(newSlot); else this.slots = this.slots.insertWithPriority(newSlot);
			return newSlot;
		}
		return this.slots.find(listener);
	}
	,registrationPossible: function(listener,once) {
		if(!this.slots.nonEmpty) return true;
		var existingSlot = this.slots.find(listener);
		if(existingSlot == null) return true;
		if(existingSlot.once != once) throw new js__$Boot_HaxeError("You cannot addOnce() then add() the same listener without removing the relationship first.");
		return false;
	}
	,createSlot: function(listener,once,priority) {
		if(priority == null) priority = 0;
		if(once == null) once = false;
		return null;
	}
	,get_numListeners: function() {
		return this.slots.get_length();
	}
};
var msignal_Signal0 = function() {
	msignal_Signal.call(this);
};
msignal_Signal0.__name__ = true;
msignal_Signal0.__super__ = msignal_Signal;
msignal_Signal0.prototype = $extend(msignal_Signal.prototype,{
	dispatch: function() {
		var slotsToProcess = this.slots;
		while(slotsToProcess.nonEmpty) {
			slotsToProcess.head.execute();
			slotsToProcess = slotsToProcess.tail;
		}
	}
	,createSlot: function(listener,once,priority) {
		if(priority == null) priority = 0;
		if(once == null) once = false;
		return new msignal_Slot0(this,listener,once,priority);
	}
});
var msignal_Signal1 = function(type) {
	msignal_Signal.call(this,[type]);
};
msignal_Signal1.__name__ = true;
msignal_Signal1.__super__ = msignal_Signal;
msignal_Signal1.prototype = $extend(msignal_Signal.prototype,{
	dispatch: function(value) {
		var slotsToProcess = this.slots;
		while(slotsToProcess.nonEmpty) {
			slotsToProcess.head.execute(value);
			slotsToProcess = slotsToProcess.tail;
		}
	}
	,createSlot: function(listener,once,priority) {
		if(priority == null) priority = 0;
		if(once == null) once = false;
		return new msignal_Slot1(this,listener,once,priority);
	}
});
var msignal_Signal2 = function(type1,type2) {
	msignal_Signal.call(this,[type1,type2]);
};
msignal_Signal2.__name__ = true;
msignal_Signal2.__super__ = msignal_Signal;
msignal_Signal2.prototype = $extend(msignal_Signal.prototype,{
	dispatch: function(value1,value2) {
		var slotsToProcess = this.slots;
		while(slotsToProcess.nonEmpty) {
			slotsToProcess.head.execute(value1,value2);
			slotsToProcess = slotsToProcess.tail;
		}
	}
	,createSlot: function(listener,once,priority) {
		if(priority == null) priority = 0;
		if(once == null) once = false;
		return new msignal_Slot2(this,listener,once,priority);
	}
});
var msignal_Slot = function(signal,listener,once,priority) {
	if(priority == null) priority = 0;
	if(once == null) once = false;
	this.signal = signal;
	this.set_listener(listener);
	this.once = once;
	this.priority = priority;
	this.enabled = true;
};
msignal_Slot.__name__ = true;
msignal_Slot.prototype = {
	remove: function() {
		this.signal.remove(this.listener);
	}
	,set_listener: function(value) {
		if(value == null) throw new js__$Boot_HaxeError("listener cannot be null");
		return this.listener = value;
	}
};
var msignal_Slot0 = function(signal,listener,once,priority) {
	if(priority == null) priority = 0;
	if(once == null) once = false;
	msignal_Slot.call(this,signal,listener,once,priority);
};
msignal_Slot0.__name__ = true;
msignal_Slot0.__super__ = msignal_Slot;
msignal_Slot0.prototype = $extend(msignal_Slot.prototype,{
	execute: function() {
		if(!this.enabled) return;
		if(this.once) this.remove();
		this.listener();
	}
});
var msignal_Slot1 = function(signal,listener,once,priority) {
	if(priority == null) priority = 0;
	if(once == null) once = false;
	msignal_Slot.call(this,signal,listener,once,priority);
};
msignal_Slot1.__name__ = true;
msignal_Slot1.__super__ = msignal_Slot;
msignal_Slot1.prototype = $extend(msignal_Slot.prototype,{
	execute: function(value1) {
		if(!this.enabled) return;
		if(this.once) this.remove();
		if(this.param != null) value1 = this.param;
		this.listener(value1);
	}
});
var msignal_Slot2 = function(signal,listener,once,priority) {
	if(priority == null) priority = 0;
	if(once == null) once = false;
	msignal_Slot.call(this,signal,listener,once,priority);
};
msignal_Slot2.__name__ = true;
msignal_Slot2.__super__ = msignal_Slot;
msignal_Slot2.prototype = $extend(msignal_Slot.prototype,{
	execute: function(value1,value2) {
		if(!this.enabled) return;
		if(this.once) this.remove();
		if(this.param1 != null) value1 = this.param1;
		if(this.param2 != null) value2 = this.param2;
		this.listener(value1,value2);
	}
});
var msignal_SlotList = function(head,tail) {
	this.nonEmpty = false;
	if(head == null && tail == null) {
		if(msignal_SlotList.NIL != null) throw new js__$Boot_HaxeError("Parameters head and tail are null. Use the NIL element instead.");
		this.nonEmpty = false;
	} else if(head == null) throw new js__$Boot_HaxeError("Parameter head cannot be null."); else {
		this.head = head;
		if(tail == null) this.tail = msignal_SlotList.NIL; else this.tail = tail;
		this.nonEmpty = true;
	}
};
msignal_SlotList.__name__ = true;
msignal_SlotList.prototype = {
	get_length: function() {
		if(!this.nonEmpty) return 0;
		if(this.tail == msignal_SlotList.NIL) return 1;
		var result = 0;
		var p = this;
		while(p.nonEmpty) {
			++result;
			p = p.tail;
		}
		return result;
	}
	,prepend: function(slot) {
		return new msignal_SlotList(slot,this);
	}
	,append: function(slot) {
		if(slot == null) return this;
		if(!this.nonEmpty) return new msignal_SlotList(slot);
		if(this.tail == msignal_SlotList.NIL) return new msignal_SlotList(slot).prepend(this.head);
		var wholeClone = new msignal_SlotList(this.head);
		var subClone = wholeClone;
		var current = this.tail;
		while(current.nonEmpty) {
			subClone = subClone.tail = new msignal_SlotList(current.head);
			current = current.tail;
		}
		subClone.tail = new msignal_SlotList(slot);
		return wholeClone;
	}
	,insertWithPriority: function(slot) {
		if(!this.nonEmpty) return new msignal_SlotList(slot);
		var priority = slot.priority;
		if(priority >= this.head.priority) return this.prepend(slot);
		var wholeClone = new msignal_SlotList(this.head);
		var subClone = wholeClone;
		var current = this.tail;
		while(current.nonEmpty) {
			if(priority > current.head.priority) {
				subClone.tail = current.prepend(slot);
				return wholeClone;
			}
			subClone = subClone.tail = new msignal_SlotList(current.head);
			current = current.tail;
		}
		subClone.tail = new msignal_SlotList(slot);
		return wholeClone;
	}
	,filterNot: function(listener) {
		if(!this.nonEmpty || listener == null) return this;
		if(Reflect.compareMethods(this.head.listener,listener)) return this.tail;
		var wholeClone = new msignal_SlotList(this.head);
		var subClone = wholeClone;
		var current = this.tail;
		while(current.nonEmpty) {
			if(Reflect.compareMethods(current.head.listener,listener)) {
				subClone.tail = current.tail;
				return wholeClone;
			}
			subClone = subClone.tail = new msignal_SlotList(current.head);
			current = current.tail;
		}
		return this;
	}
	,contains: function(listener) {
		if(!this.nonEmpty) return false;
		var p = this;
		while(p.nonEmpty) {
			if(Reflect.compareMethods(p.head.listener,listener)) return true;
			p = p.tail;
		}
		return false;
	}
	,find: function(listener) {
		if(!this.nonEmpty) return null;
		var p = this;
		while(p.nonEmpty) {
			if(Reflect.compareMethods(p.head.listener,listener)) return p.head;
			p = p.tail;
		}
		return null;
	}
};
var util_ArrayExtensions = function() { };
util_ArrayExtensions.__name__ = true;
util_ArrayExtensions.randomElementFromArrays = function(arrays) {
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
		if(n < lengths[i]) return util_ArrayExtensions.randomElement(arrays[i]);
		i++;
	}
	throw new js__$Boot_HaxeError("Failed to get random element");
};
util_ArrayExtensions.randomElement = function(array) {
	if(!(array != null && array.length != 0)) throw new js__$Boot_HaxeError("FAIL: array != null && array.length != 0");
	return array[Std.random(array.length)];
};
util_ArrayExtensions.noNulls = function(array) {
	if(!(array != null)) throw new js__$Boot_HaxeError("FAIL: array != null");
	var _g = 0;
	while(_g < array.length) {
		var e = array[_g];
		++_g;
		if(e == null) return false;
	}
	return true;
};
util_ArrayExtensions.binarySearchCmp = function(a,x,min,max,comparator) {
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
util_ArrayExtensions.binarySearch = function(a,x,min,max) {
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
var util_FloatExtensions = function() { };
util_FloatExtensions.__name__ = true;
util_FloatExtensions.clamp = function(v,min,max) {
	if(v < min) return min; else if(v > max) return max; else return v;
};
util_FloatExtensions.max = function(a,b) {
	if(a > b) return a; else return b;
};
util_FloatExtensions.min = function(a,b) {
	if(a < b) return a; else return b;
};
util_FloatExtensions.inRangeInclusive = function(p,x1,x2) {
	return p >= Math.min(x1,x2) && p <= Math.max(x1,x2);
};
util_FloatExtensions.inRangeExclusive = function(p,x1,x2) {
	return p > Math.min(x1,x2) && p < Math.max(x1,x2);
};
util_FloatExtensions.lerp = function(v,a,b) {
	return (b - a) * v + a;
};
util_FloatExtensions.coslerp = function(v,a,b) {
	var c = (1 - Math.cos(v * Math.PI)) / 2;
	return a * (1 - c) + b * c;
};
util_FloatExtensions.sign = function(x) {
	if(x > 0) return 1; else if(x < 0) return -1; else return 0;
};
util_FloatExtensions.fpart = function(x) {
	if(x < 0) return 1 - (x - Math.floor(x)); else return x - Math.floor(x);
};
util_FloatExtensions.rfpart = function(x) {
	return 1.0 - (x < 0?1 - (x - Math.floor(x)):x - Math.floor(x));
};
util_FloatExtensions.wrap = function(x,lower,upper) {
	if(!(lower <= upper)) throw new js__$Boot_HaxeError("FAIL: lower <= upper");
	var range = upper - lower + 1;
	x = (x - lower) % range;
	if(x < 0) return upper + 1 + x; else return lower + x;
};
var util_StringExtensions = function() { };
util_StringExtensions.__name__ = true;
util_StringExtensions.reverse = function(s) {
	if(!(s != null)) throw new js__$Boot_HaxeError("FAIL: s != null");
	var arr = s.split("");
	arr.reverse();
	return arr.join("");
};
util_StringExtensions.repeat = function(s,times) {
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
util_StringExtensions.contains = function(s,substr) {
	return s.indexOf(substr) >= 0;
};
util_StringExtensions.capitalize = function(s) {
	return HxOverrides.substr(s,0,1).toUpperCase() + HxOverrides.substr(s,1,s.length - 1);
};
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
String.__name__ = true;
Array.__name__ = true;
msignal_SlotList.NIL = new msignal_SlotList(null,null);
Strings.walkingAdjective = ["shuffle","waddle","dodder","shamble","lurch","stumble","reel","stagger"];
Strings.eatingDescription = ["wolf it down","gobble it greedily","feast on it","voraciously scarf it down"];
Strings.unrecognizedCommand = ["You flail uselessly."];
js_d3__$D3_InitPriority.important = "important";
Main.main();
})(typeof console != "undefined" ? console : {log:function(){}});

//# sourceMappingURL=game.js.map