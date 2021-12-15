(function ($global) { "use strict";
var $estr = function() { return js_Boot.__string_rec(this,''); },$hxEnums = $hxEnums || {};
function $extend(from, fields) {
	var proto = Object.create(from);
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var Strings = function() { };
Strings.__name__ = true;
var Location = function(tag,description) {
	this.tag = tag;
	this.description = description;
	this.actions = [];
};
Location.__name__ = true;
var Desk = function(world) {
	var _gthis = this;
	Location.call(this,"Desktop","The old rig, designed for a hacker on steroids");
	this.tasks = [{ descriptions : ["You clear out your emails. George Schulz has sent you 44 new messsages about penis enlargement solutions."], effects : function(brain) {
		var fh = brain.needs[0];
		fh.set_value(fh.value - 0.3);
	}},{ descriptions : ["You check your Facebook profile. Two new notifications."], effects : function(brain) {
		var fh = brain.needs[0];
		fh.set_value(fh.value - 0.4);
	}},{ descriptions : ["You watch an amusing video of an acrobatic cat."], effects : function(brain) {
		var fh = brain.needs[0];
		fh.set_value(fh.value - 0.3);
	}},{ descriptions : ["You post an angry rant about the state of student politics today."], effects : function(brain) {
		var fh = brain.needs[0];
		fh.set_value(fh.value - 0.3);
	}},{ descriptions : ["You offend someone who disagrees with you on Twitter."], effects : function(brain) {
		var fh = brain.needs[0];
		fh.set_value(fh.value - 0.4);
	}},{ descriptions : ["You browse a gallery of awkward family photos."], effects : function(brain) {
		var fh = brain.needs[0];
		fh.set_value(fh.value - 0.3);
	}},{ descriptions : ["You watch a video starring an anthropomorphic talking dog."], effects : function(brain) {
		var fh = brain.needs[0];
		fh.set_value(fh.value - 0.4);
	}},{ descriptions : ["You read the daily Dilbert comic."], effects : function(brain) {
		var fh = brain.needs[0];
		fh.set_value(fh.value - 0.5);
	}},{ descriptions : ["You click on some clickbait ads."], effects : function(brain) {
		var fh = brain.needs[0];
		fh.set_value(fh.value - 0.2);
	}}];
	this.actions.push(new TriggerAction(0,["computer"],8,[{ id : 0, effect : function(world) {
		var array = _gthis.tasks;
		var item = array[Std.random(array.length)];
		var array = item.descriptions;
		terminal.echo(array[Std.random(array.length)]);
		item.effects(world.agent.brain);
	}}]));
};
Desk.__name__ = true;
Desk.__super__ = Location;
Desk.prototype = $extend(Location.prototype,{
});
var Fridge = function(world) {
	var _gthis = this;
	Location.call(this,"Fridge","The new fridge");
	this.foods = [{ name : "tin of beans", descriptions : ["It says best before June 2012"], effects : function(brain) {
		var fh = brain.needs[2];
		fh.set_value(fh.value - 0.2);
		var fh = brain.needs[4];
		fh.set_value(fh.value + 0.1);
		var fh = brain.needs[3];
		fh.set_value(fh.value - 0.05);
	}},{ name : "pack of stale biscuits", descriptions : ["They look like they've been open for months"], effects : function(brain) {
		var fh = brain.needs[2];
		fh.set_value(fh.value - 0.1);
		var fh = brain.needs[4];
		fh.set_value(fh.value + 0.03);
	}},{ name : "baked potato with green fur", descriptions : ["A rancid smell emanates from it"], effects : function(brain) {
		var fh = brain.needs[2];
		fh.set_value(fh.value - 0.3);
		var fh = brain.needs[4];
		fh.set_value(fh.value + 0.1);
	}},{ name : "bag of disintegrating salad", descriptions : ["It gives off a noxious, sour odour"], effects : function(brain) {
		var fh = brain.needs[2];
		fh.set_value(fh.value - 0.4);
		var fh = brain.needs[4];
		fh.set_value(fh.value + 0.1);
	}},{ name : "mouldy cheese", descriptions : ["It's hard and tasteless"], effects : function(brain) {
		var fh = brain.needs[2];
		fh.set_value(fh.value - 0.3);
		var fh = brain.needs[4];
		fh.set_value(fh.value + 0.1);
	}},{ name : "shrivelled apple", descriptions : ["It smells worse than a septic tank"], effects : function(brain) {
		var fh = brain.needs[2];
		fh.set_value(fh.value - 0.5);
		var fh = brain.needs[4];
		fh.set_value(fh.value + 0.1);
	}},{ name : "suspicious fish", descriptions : ["Stinks of... fish"], effects : function(brain) {
		var fh = brain.needs[2];
		fh.set_value(fh.value - 0.7);
		var fh = brain.needs[4];
		fh.set_value(fh.value + 0.1);
	}},{ name : "milk-spattered lettuce", descriptions : ["Looks and smells toxic"], effects : function(brain) {
		var fh = brain.needs[2];
		fh.set_value(fh.value - 0.4);
		var fh = brain.needs[4];
		fh.set_value(fh.value + 0.1);
	}},{ name : "raw chicken", descriptions : ["It has a slightly green tinge"], effects : function(brain) {
		var fh = brain.needs[2];
		fh.set_value(fh.value - 0.2);
		var fh = brain.needs[4];
		fh.set_value(fh.value + 0.1);
	}},{ name : "bowl of steamed rice", descriptions : ["It was left in the rice cooker for a few weeks"], effects : function(brain) {
		var fh = brain.needs[2];
		fh.set_value(fh.value - 0.5);
		var fh = brain.needs[4];
		fh.set_value(fh.value + 0.1);
	}},{ name : "pound of ground beef", descriptions : ["Looks as if a small animal has been gnawing on it"], effects : function(brain) {
		var fh = brain.needs[2];
		fh.set_value(fh.value - 0.2);
		var fh = brain.needs[4];
		fh.set_value(fh.value + 0.1);
	}},{ name : "broccoli casserole", descriptions : ["Several weeks old"], effects : function(brain) {
		var fh = brain.needs[2];
		fh.set_value(fh.value - 0.4);
		var fh = brain.needs[4];
		fh.set_value(fh.value + 0.1);
	}},{ name : "dish of burnt refried beans", descriptions : ["They have a smoky carbonized aroma"], effects : function(brain) {
		var fh = brain.needs[2];
		fh.set_value(fh.value - 0.3);
		var fh = brain.needs[4];
		fh.set_value(fh.value + 0.1);
	}},{ name : "pint-glass of rancid milk", descriptions : ["There's something swimming in it"], effects : function(brain) {
		var fh = brain.needs[2];
		fh.set_value(fh.value - 0.3);
		var fh = brain.needs[4];
		fh.set_value(fh.value + 0.1);
	}}];
	this.actions.push(new TriggerAction(2,["eat"],10,[{ id : 2, effect : function(world) {
		var array = _gthis.foods;
		var item = array[Std.random(array.length)];
		var array = Strings.walkingAdjective;
		var tmp = "You " + array[Std.random(array.length)] + " to the fridge and grab the first thing you see... It's a " + item.name + ". ";
		var array = item.descriptions;
		var tmp1 = tmp + array[Std.random(array.length)] + ". You ";
		var array = Strings.eatingDescription;
		terminal.echo(tmp1 + array[Std.random(array.length)] + ".");
		item.effects(world.agent.brain);
	}}]));
};
Fridge.__name__ = true;
Fridge.__super__ = Location;
Fridge.prototype = $extend(Location.prototype,{
});
var Bed = function(world) {
	Location.call(this,"Bed","The old bed");
	this.actions.push(new TriggerAction(1,["sleep"],40,[{ id : 1, effect : function(world) {
		terminal.echo("You settle down for forty winks.");
		var rest = Math.random() * 0.5 + 0.3;
		var fh = world.agent.brain.needs[1];
		fh.set_value(fh.value - rest);
	}}]));
};
Bed.__name__ = true;
Bed.__super__ = Location;
Bed.prototype = $extend(Location.prototype,{
});
var Shower = function(world) {
	Location.call(this,"Shower","The shower.");
	this.actions.push(new TriggerAction(3,["shower"],15,[{ id : 3, effect : function(world) {
		var array = Strings.showeringDescription;
		terminal.echo(array[Std.random(array.length)]);
		var clean = 0.4 + Math.random() * 0.5;
		var fh = world.agent.brain.needs[3];
		fh.set_value(fh.value - clean);
	}}]));
};
Shower.__name__ = true;
Shower.__super__ = Location;
Shower.prototype = $extend(Location.prototype,{
});
var Toilet = function(world) {
	Location.call(this,"Toilet","The toilet.");
	this.actions.push(new TriggerAction(4,["toilet"],5,[{ id : 4, effect : function(world) {
		terminal.echo("You relieve yourself.");
		var fh = world.agent.brain.needs[4];
		fh.set_value(fh.value - 1.0);
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
		var _gthis = this;
		terminal.push(function(command,terminal1) {
			var recognizedCommand = false;
			var location = _gthis.world.context.iterator();
			while(location.hasNext()) {
				var location1 = location.next();
				var _g = 0;
				var _g1 = location1.actions;
				while(_g < _g1.length) {
					var action = _g1[_g];
					++_g;
					var containsParts = true;
					var _g2 = 0;
					var _g3 = action.trigger;
					while(_g2 < _g3.length) {
						var part = _g3[_g2];
						++_g2;
						if(command.indexOf(part) <= 0) {
							containsParts = false;
							break;
						}
					}
					if(action.trigger.length != 0 && containsParts) {
						recognizedCommand = true;
						_gthis.signal_consoleActionIssued.dispatch(action);
					}
				}
			}
			if(!recognizedCommand && command.length != 0) {
				var array = Strings.unrecognizedCommand;
				terminal.echo(array[Std.random(array.length)]);
			}
		},{ greetings : false, name : ">"});
		terminal.echo("You have 24 hours...");
		var _gthis1 = this;
		var actions = window.document.getElementById("actions");
		while(actions.hasChildNodes()) actions.removeChild(actions.lastChild);
		var location = this.world.context.iterator();
		while(location.hasNext()) {
			var location1 = location.next();
			var _g = 0;
			var _g1 = location1.actions;
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
						_gthis1.signal_actionButtonPressed.dispatch(action[0]);
					};
				})(action);
			}
		}
		var _gthis2 = this;
		this.updateRateElement = window.document.getElementById("clockspeed");
		noUiSlider.create(this.updateRateElement,{ connect : "lower", start : 1, range : { "min" : [0,0.1], "max" : 10}, format : new wNumb({ decimals : 1}), pips : { mode : "range", density : 10}});
		this.createTooltips(this.updateRateElement);
		this.updateRateElement.noUiSlider.on("change",function(values,handle,rawValues) {
			_gthis2.set_updateInterval(1000 / values[handle] | 0);
		});
		this.updateRateElement.noUiSlider.on("update",function(values,handle,rawValues) {
			var tipHandles = _gthis2.updateRateElement.getElementsByClassName("noUi-handle");
			tipHandles[handle].innerHTML = "<span class='tooltip'>" + Std.string(values[handle]) + "</span>";
		});
		this.graphs = new haxe_ds_IntMap();
		var _g = 0;
		var _g1 = this.world.agent.brain.needs;
		while(_g < _g1.length) {
			var motive = _g1[_g];
			++_g;
			var graph = new NeedGraph(motive,[{ time : 0, value : motive.value}],"#graphs",150,100);
			this.graphs.h[motive.id] = graph;
		}
		var _gthis3 = this;
		this.strategyElement = window.document.getElementById("strategy");
		this.strategyElement.addEventListener("change",function() {
			if(_gthis3.strategyElement.value != null) {
				_gthis3.world.agent.aiMode = _gthis3.strategyElement.value;
			}
		},false);
		this.updateHandle = null;
		this.set_updateInterval(1000);
		this.signal_actionButtonPressed.add($bind(this,this.handleAction));
		this.signal_consoleActionIssued.add($bind(this,this.handleAction));
		this.world.agent.brain.onActionSelected = $bind(this,this.handleAction);
	}
	,update: function() {
		if(!this.world.gameover) {
			var fh = this.world;
			fh.set_minutes(fh.minutes + 1);
			this.world.update(1);
			var graph = this.graphs.iterator();
			while(graph.hasNext()) {
				var graph1 = graph.next();
				var _g = 0;
				var _g1 = this.world.agent.brain.needs;
				while(_g < _g1.length) {
					var motive = _g1[_g];
					++_g;
					var graph2 = this.graphs.h[motive.id];
					graph2.addData({ time : this.world.minutes, value : motive.value},this.world.minutes);
				}
			}
			if(this.world.minutes >= 1440) {
				this.world.gameover = true;
				this.world.clock.stop();
				terminal.echo("Time's up...");
			}
		}
	}
	,handleAction: function(action) {
		if(!this.world.gameover) {
			this.world.agent.act(action);
			var fh = this.world;
			fh.set_minutes(fh.minutes + action.duration);
			var _g = 0;
			var _g1 = action.effects;
			while(_g < _g1.length) {
				var effect = _g1[_g];
				++_g;
				var graph = this.graphs.h[effect.id];
				graph.addData({ time : this.world.minutes, value : this.world.agent.brain.needs[effect.id].value},this.world.minutes);
			}
		}
	}
	,createTerminal: function() {
		var _gthis = this;
		terminal.push(function(command,terminal1) {
			var recognizedCommand = false;
			var location = _gthis.world.context.iterator();
			while(location.hasNext()) {
				var location1 = location.next();
				var _g = 0;
				var _g1 = location1.actions;
				while(_g < _g1.length) {
					var action = _g1[_g];
					++_g;
					var containsParts = true;
					var _g2 = 0;
					var _g3 = action.trigger;
					while(_g2 < _g3.length) {
						var part = _g3[_g2];
						++_g2;
						if(command.indexOf(part) <= 0) {
							containsParts = false;
							break;
						}
					}
					if(action.trigger.length != 0 && containsParts) {
						recognizedCommand = true;
						_gthis.signal_consoleActionIssued.dispatch(action);
					}
				}
			}
			if(!recognizedCommand && command.length != 0) {
				var array = Strings.unrecognizedCommand;
				terminal.echo(array[Std.random(array.length)]);
			}
		},{ greetings : false, name : ">"});
		terminal.echo("You have 24 hours...");
	}
	,generateActionButtons: function() {
		var _gthis = this;
		var actions = window.document.getElementById("actions");
		while(actions.hasChildNodes()) actions.removeChild(actions.lastChild);
		var location = this.world.context.iterator();
		while(location.hasNext()) {
			var location1 = location.next();
			var _g = 0;
			var _g1 = location1.actions;
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
						_gthis.signal_actionButtonPressed.dispatch(action[0]);
					};
				})(action);
			}
		}
	}
	,generateSliders: function() {
		var _gthis = this;
		this.updateRateElement = window.document.getElementById("clockspeed");
		noUiSlider.create(this.updateRateElement,{ connect : "lower", start : 1, range : { "min" : [0,0.1], "max" : 10}, format : new wNumb({ decimals : 1}), pips : { mode : "range", density : 10}});
		this.createTooltips(this.updateRateElement);
		this.updateRateElement.noUiSlider.on("change",function(values,handle,rawValues) {
			_gthis.set_updateInterval(1000 / values[handle] | 0);
		});
		this.updateRateElement.noUiSlider.on("update",function(values,handle,rawValues) {
			var tipHandles = _gthis.updateRateElement.getElementsByClassName("noUi-handle");
			tipHandles[handle].innerHTML = "<span class='tooltip'>" + Std.string(values[handle]) + "</span>";
		});
	}
	,connectStrategySelection: function() {
		var _gthis = this;
		this.strategyElement = window.document.getElementById("strategy");
		this.strategyElement.addEventListener("change",function() {
			if(_gthis.strategyElement.value != null) {
				_gthis.world.agent.aiMode = _gthis.strategyElement.value;
			}
		},false);
	}
	,createTooltips: function(slider) {
		var tipHandles = slider.getElementsByClassName("noUi-handle");
		var _g = 0;
		var _g1 = tipHandles.length;
		while(_g < _g1) {
			var i = _g++;
			var div = window.document.createElement("div");
			div.className += "tooltip";
			tipHandles[i].appendChild(div);
			var tipHandles1 = slider.getElementsByClassName("noUi-handle");
			tipHandles1[i].innerHTML = "<span class='tooltip'>" + "0" + "</span>";
		}
	}
	,updateTooltips: function(slider,handleIdx,value) {
		var tipHandles = slider.getElementsByClassName("noUi-handle");
		tipHandles[handleIdx].innerHTML = "<span class='tooltip'>" + (value == null ? "null" : "" + value) + "</span>";
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
		if(this.updateHandle != null) {
			window.clearInterval(this.updateHandle);
		}
		this.updateHandle = window.setInterval($bind(this,this.update),time);
		return time;
	}
};
Math.__name__ = true;
var NeedGraph = function(need,data,elementId,width,height) {
	this.maxY = 1;
	this.minY = 0;
	var _gthis = this;
	this.data = data;
	this.title = need.tag;
	this.elementId = elementId;
	this.graphId = StringTools.replace(elementId,"#","") + "_" + (need.id == null ? "null" : "" + need.id);
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
	this.line = d3.svg.line().x(function(d) {
		return _gthis.x(d.time);
	}).y(function(d) {
		return _gthis.y(d.value);
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
		var _gthis = this;
		this.x.domain([0,minutes]);
		this.line = d3.svg.line().x(function(d) {
			return _gthis.x(d.time);
		}).y(function(d) {
			return _gthis.y(d.value);
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
var ArrayExtensions = function() { };
ArrayExtensions.__name__ = true;
ArrayExtensions.randomElement = function(array) {
	return array[Std.random(array.length)];
};
var Needs = function(id,duration,effects) {
	this.id = id;
	this.duration = duration;
	this.effects = effects;
};
Needs.__name__ = true;
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
var Brain = function(world,needs) {
	this.onActionSelected = null;
	this.world = world;
	this.needs = needs;
	this.needTraits = new haxe_ds_IntMap();
	this.actionTraits = new haxe_ds_IntMap();
};
Brain.__name__ = true;
Brain.prototype = {
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
			var need = _g1[_g];
			++_g;
			need.update(dt);
		}
		var aiMode = this.world.agent.aiMode;
		var need;
		switch(aiMode) {
		case "highest_needs":
			var idx = 0;
			var value = 0;
			var _g = 0;
			var _g1 = this.needs.length;
			while(_g < _g1) {
				var i = _g++;
				if(this.needs[i].value > value) {
					value = this.needs[idx].value;
					idx = i;
				}
			}
			need = this.needs[idx];
			break;
		case "true_random":
			var array = this.needs;
			need = array[Std.random(array.length)];
			break;
		case "weighted_random":
			need = this.needs[0];
			break;
		default:
			need = null;
		}
		if(need != null) {
			var actions = this.world.queryContextForActions(need);
			if(this.onActionSelected != null) {
				this.onActionSelected(actions[Std.random(actions.length)]);
			}
		}
	}
	,getGreatestNeed: function() {
		var idx = 0;
		var value = 0;
		var _g = 0;
		var _g1 = this.needs.length;
		while(_g < _g1) {
			var i = _g++;
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
		var array = this.needs;
		return array[Std.random(array.length)];
	}
	,findActions: function(need) {
		return this.world.queryContextForActions(need);
	}
};
var Need = function(id,initialValue,growthRate,growthModifier,growthCurve,tag) {
	if(tag == null) {
		tag = "Unnamed Motive";
	}
	if(growthModifier == null) {
		growthModifier = 1.0;
	}
	if(growthRate == null) {
		growthRate = 0.01;
	}
	this.id = id;
	this.set_value(initialValue);
	this.growthRate = growthRate;
	this.growthModifier = growthModifier;
	this.tag = tag;
	if(growthCurve != null) {
		this.growthCurve = growthCurve;
	} else {
		this.growthCurve = $bind(this,this.linear);
	}
};
Need.__name__ = true;
Need.prototype = {
	update: function(dt) {
		this.set_value(this.value + this.growthCurve(dt * this.growthRate * this.growthModifier));
	}
	,set_value: function(v) {
		return this.value = v < 0 ? 0 : v > 1 ? 1 : v;
	}
	,linear: function(v) {
		return v;
	}
};
var Reflect = function() { };
Reflect.__name__ = true;
Reflect.isFunction = function(f) {
	if(typeof(f) == "function") {
		return !(f.__name__ || f.__ename__);
	} else {
		return false;
	}
};
Reflect.compareMethods = function(f1,f2) {
	if(f1 == f2) {
		return true;
	}
	if(!Reflect.isFunction(f1) || !Reflect.isFunction(f2)) {
		return false;
	}
	if(f1.scope == f2.scope && f1.method == f2.method) {
		return f1.method != null;
	} else {
		return false;
	}
};
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js_Boot.__string_rec(s,"");
};
Std.random = function(x) {
	if(x <= 0) {
		return 0;
	} else {
		return Math.floor(Math.random() * x);
	}
};
var StringTools = function() { };
StringTools.__name__ = true;
StringTools.replace = function(s,sub,by) {
	return s.split(sub).join(by);
};
var TriggerAction = function(id,trigger,duration,effects) {
	Needs.call(this,id,duration,effects);
	this.trigger = trigger;
};
TriggerAction.__name__ = true;
TriggerAction.__super__ = Needs;
TriggerAction.prototype = $extend(Needs.prototype,{
});
var World = function() {
	this.clock = new FlipClock.Factory(window.document.getElementById("time"));
	this.clock.stop();
	this.set_minutes(0);
	this.gameover = false;
	this.context = new haxe_ds_GenericStack();
	var _this = this.context;
	_this.head = new haxe_ds_GenericCell(new Desk(this),_this.head);
	var _this = this.context;
	_this.head = new haxe_ds_GenericCell(new Bed(this),_this.head);
	var _this = this.context;
	_this.head = new haxe_ds_GenericCell(new Fridge(this),_this.head);
	var _this = this.context;
	_this.head = new haxe_ds_GenericCell(new Shower(this),_this.head);
	var _this = this.context;
	_this.head = new haxe_ds_GenericCell(new Toilet(this),_this.head);
	var needs = [];
	needs.push(new Need(0,0.20,0.10,1.0,null,"Boredom"));
	needs.push(new Need(1,0.07,0.04,1.0,null,"Tiredness"));
	needs.push(new Need(2,0.25,0.10,1.0,null,"Hunger"));
	needs.push(new Need(3,0.10,0.02,1.0,null,"Hygiene"));
	needs.push(new Need(4,0.30,0.02,1.0,null,"Bladder"));
	this.agent = new Agent(new Brain(this,needs));
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
			if(need.value >= 1.0) {
				this.gameover = true;
			}
		}
	}
	,queryContextForActions: function(need) {
		var actions = [];
		var location = this.context.iterator();
		while(location.hasNext()) {
			var location1 = location.next();
			var _g = 0;
			var _g1 = location1.actions;
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
	,set_minutes: function(min) {
		if(this.clock != null) {
			this.clock.setTime(min * 60);
		}
		return this.minutes = min;
	}
};
var haxe_ds_GenericCell = function(elt,next) {
	this.elt = elt;
	this.next = next;
};
haxe_ds_GenericCell.__name__ = true;
var haxe_ds_GenericStack = function() {
};
haxe_ds_GenericStack.__name__ = true;
haxe_ds_GenericStack.prototype = {
	iterator: function() {
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
haxe_ds_IntMap.prototype = {
	keys: function() {
		var a = [];
		for( var key in this.h ) if(this.h.hasOwnProperty(key)) a.push(+key);
		return new haxe_iterators_ArrayIterator(a);
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
var haxe_iterators_ArrayIterator = function(array) {
	this.current = 0;
	this.array = array;
};
haxe_iterators_ArrayIterator.__name__ = true;
haxe_iterators_ArrayIterator.prototype = {
	hasNext: function() {
		return this.current < this.array.length;
	}
	,next: function() {
		return this.array[this.current++];
	}
};
var js_Boot = function() { };
js_Boot.__name__ = true;
js_Boot.__string_rec = function(o,s) {
	if(o == null) {
		return "null";
	}
	if(s.length >= 5) {
		return "<...>";
	}
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) {
		t = "object";
	}
	switch(t) {
	case "function":
		return "<function>";
	case "object":
		if(o.__enum__) {
			var e = $hxEnums[o.__enum__];
			var con = e.__constructs__[o._hx_index];
			var n = con._hx_name;
			if(con.__params__) {
				s = s + "\t";
				return n + "(" + ((function($this) {
					var $r;
					var _g = [];
					{
						var _g1 = 0;
						var _g2 = con.__params__;
						while(true) {
							if(!(_g1 < _g2.length)) {
								break;
							}
							var p = _g2[_g1];
							_g1 = _g1 + 1;
							_g.push(js_Boot.__string_rec(o[p],s));
						}
					}
					$r = _g;
					return $r;
				}(this))).join(",") + ")";
			} else {
				return n;
			}
		}
		if(((o) instanceof Array)) {
			var str = "[";
			s += "\t";
			var _g = 0;
			var _g1 = o.length;
			while(_g < _g1) {
				var i = _g++;
				str += (i > 0 ? "," : "") + js_Boot.__string_rec(o[i],s);
			}
			str += "]";
			return str;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( _g ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
			var s2 = o.toString();
			if(s2 != "[object Object]") {
				return s2;
			}
		}
		var str = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		var k = null;
		for( k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str.length != 2) {
			str += ", \n";
		}
		str += s + k + " : " + js_Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str += "\n" + s + "}";
		return str;
	case "string":
		return o;
	default:
		return String(o);
	}
};
var js_d3__$D3_InitPriority = function() { };
js_d3__$D3_InitPriority.__name__ = true;
var msignal_Signal = function(valueClasses) {
	if(valueClasses == null) {
		valueClasses = [];
	}
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
		if(priority == null) {
			priority = 0;
		}
		return this.registerListener(listener,false,priority);
	}
	,addOnceWithPriority: function(listener,priority) {
		if(priority == null) {
			priority = 0;
		}
		return this.registerListener(listener,true,priority);
	}
	,remove: function(listener) {
		var slot = this.slots.find(listener);
		if(slot == null) {
			return null;
		}
		this.slots = this.slots.filterNot(listener);
		return slot;
	}
	,removeAll: function() {
		this.slots = msignal_SlotList.NIL;
	}
	,registerListener: function(listener,once,priority) {
		if(priority == null) {
			priority = 0;
		}
		if(once == null) {
			once = false;
		}
		if(this.registrationPossible(listener,once)) {
			var newSlot = this.createSlot(listener,once,priority);
			if(!this.priorityBased && priority != 0) {
				this.priorityBased = true;
			}
			if(!this.priorityBased && priority == 0) {
				this.slots = this.slots.prepend(newSlot);
			} else {
				this.slots = this.slots.insertWithPriority(newSlot);
			}
			return newSlot;
		}
		return this.slots.find(listener);
	}
	,registrationPossible: function(listener,once) {
		if(!this.slots.nonEmpty) {
			return true;
		}
		var existingSlot = this.slots.find(listener);
		if(existingSlot == null) {
			return true;
		}
		return false;
	}
	,createSlot: function(listener,once,priority) {
		if(priority == null) {
			priority = 0;
		}
		if(once == null) {
			once = false;
		}
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
		if(priority == null) {
			priority = 0;
		}
		if(once == null) {
			once = false;
		}
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
		if(priority == null) {
			priority = 0;
		}
		if(once == null) {
			once = false;
		}
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
		if(priority == null) {
			priority = 0;
		}
		if(once == null) {
			once = false;
		}
		return new msignal_Slot2(this,listener,once,priority);
	}
});
var msignal_Slot = function(signal,listener,once,priority) {
	if(priority == null) {
		priority = 0;
	}
	if(once == null) {
		once = false;
	}
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
		return this.listener = value;
	}
};
var msignal_Slot0 = function(signal,listener,once,priority) {
	if(priority == null) {
		priority = 0;
	}
	if(once == null) {
		once = false;
	}
	msignal_Slot.call(this,signal,listener,once,priority);
};
msignal_Slot0.__name__ = true;
msignal_Slot0.__super__ = msignal_Slot;
msignal_Slot0.prototype = $extend(msignal_Slot.prototype,{
	execute: function() {
		if(!this.enabled) {
			return;
		}
		if(this.once) {
			this.remove();
		}
		this.listener();
	}
});
var msignal_Slot1 = function(signal,listener,once,priority) {
	if(priority == null) {
		priority = 0;
	}
	if(once == null) {
		once = false;
	}
	msignal_Slot.call(this,signal,listener,once,priority);
};
msignal_Slot1.__name__ = true;
msignal_Slot1.__super__ = msignal_Slot;
msignal_Slot1.prototype = $extend(msignal_Slot.prototype,{
	execute: function(value1) {
		if(!this.enabled) {
			return;
		}
		if(this.once) {
			this.remove();
		}
		if(this.param != null) {
			value1 = this.param;
		}
		this.listener(value1);
	}
});
var msignal_Slot2 = function(signal,listener,once,priority) {
	if(priority == null) {
		priority = 0;
	}
	if(once == null) {
		once = false;
	}
	msignal_Slot.call(this,signal,listener,once,priority);
};
msignal_Slot2.__name__ = true;
msignal_Slot2.__super__ = msignal_Slot;
msignal_Slot2.prototype = $extend(msignal_Slot.prototype,{
	execute: function(value1,value2) {
		if(!this.enabled) {
			return;
		}
		if(this.once) {
			this.remove();
		}
		if(this.param1 != null) {
			value1 = this.param1;
		}
		if(this.param2 != null) {
			value2 = this.param2;
		}
		this.listener(value1,value2);
	}
});
var msignal_SlotList = function(head,tail) {
	this.nonEmpty = false;
	if(head == null && tail == null) {
		this.nonEmpty = false;
	} else if(head != null) {
		this.head = head;
		this.tail = tail == null ? msignal_SlotList.NIL : tail;
		this.nonEmpty = true;
	}
};
msignal_SlotList.__name__ = true;
msignal_SlotList.prototype = {
	get_length: function() {
		if(!this.nonEmpty) {
			return 0;
		}
		if(this.tail == msignal_SlotList.NIL) {
			return 1;
		}
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
		if(slot == null) {
			return this;
		}
		if(!this.nonEmpty) {
			return new msignal_SlotList(slot);
		}
		if(this.tail == msignal_SlotList.NIL) {
			return new msignal_SlotList(slot).prepend(this.head);
		}
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
		if(!this.nonEmpty) {
			return new msignal_SlotList(slot);
		}
		var priority = slot.priority;
		if(priority >= this.head.priority) {
			return this.prepend(slot);
		}
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
		if(!this.nonEmpty || listener == null) {
			return this;
		}
		if(Reflect.compareMethods(this.head.listener,listener)) {
			return this.tail;
		}
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
		if(!this.nonEmpty) {
			return false;
		}
		var p = this;
		while(p.nonEmpty) {
			if(Reflect.compareMethods(p.head.listener,listener)) {
				return true;
			}
			p = p.tail;
		}
		return false;
	}
	,find: function(listener) {
		if(!this.nonEmpty) {
			return null;
		}
		var p = this;
		while(p.nonEmpty) {
			if(Reflect.compareMethods(p.head.listener,listener)) {
				return p.head;
			}
			p = p.tail;
		}
		return null;
	}
};
var $_;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $global.$haxeUID++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = m.bind(o); o.hx__closures__[m.__id__] = f; } return f; }
$global.$haxeUID |= 0;
String.__name__ = true;
Array.__name__ = true;
js_Boot.__toStr = ({ }).toString;
msignal_SlotList.NIL = new msignal_SlotList(null,null);
Strings.walkingAdjective = ["shuffle","waddle","dodder","shamble","lurch","stumble","reel","stagger"];
Strings.eatingDescription = ["wolf it down","gobble it greedily","feast on it","voraciously scarf it down","gag on it as it goes down","burp in satisfaction","choke it down","swallow it whole"];
Strings.showeringDescription = ["You scrub up and delouse in the shower.","You do your ablutions. The mouldy shower curtain catches you on your way out.","You take a long soak in the shower and groom your nose hair."];
Strings.unrecognizedCommand = ["You flail uselessly."];
js_d3__$D3_InitPriority.important = "important";
Main.main();
})(typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);
