package;

import haxe.ds.GenericStack;
import haxe.ds.IntMap;
import js.Browser;
import js.d3.D3;
import js.d3.scale.Scale.Linear;
import js.d3.selection.Selection;
import js.d3.svg.SVG;
import js.d3.svg.SVG.Line;
import js.flipclock.FlipClock;
import js.jquery.terminal.Terminal;
import js.webStorage.LocalStorage;
import Locations;

using StringTools;
using markov.util.StringExtensions;
using markov.util.FloatExtensions;
using markov.util.ArrayExtensions;

class NullActions {
	public static var unrecognizedCommand:Array<String> = [ 
	"You flail uselessly.",
	];
}

// Like Sims "commodities", express a class of need e.g. to be in the gym, to not go hungry
@:enum abstract Problem(Int) from Int to Int {
	var LULZ = 0;
	var SELFESTEEM = 1;
	var TIREDNESS = 2;
	var HUNGER = 3;
	var HYGIENE = 4;
	var FUNDS = 5;
}

// Motives are measures of the need to react to problems
class Motive {
	public var id:Int;
	public var value:Float;
	public var rate:Float;
	public var multiplier:Float;
	public var tag:String;
	public var decayCurve:Float->Float;
	
	public function new(id:Problem, initial:Float, rate:Float = 1.0, multiplier:Float = 1.0, tag:String = "Unnamed Motive", decayCurve:Float->Float = null) {
		this.id = id;
		this.value = initial;
		this.rate = rate;
		this.multiplier = multiplier;
		this.tag = tag;
		
		if(decayCurve != null) {
			this.decayCurve = decayCurve;
		} else {
			this.decayCurve = function(v:Float):Float {
				return v;
			}
		}
	}
	
	public function update(dt:Float):Void {
		value += decayCurve(value) * dt * rate * multiplier;
		value = value.clamp(0, 100);
	}
}

// Solutions to problems
typedef ActionEffect = { var problem:Problem; var effect:World->Void; }
class Action {	
	public function new(trigger:Array<String>, duration:Float, effects:Array<ActionEffect>) {
		this.trigger = trigger;
		this.duration = duration;
		this.effects = effects;
	}
	
	public var trigger:Array<String>;
	public var duration:Float;
	public var effects:Array<ActionEffect>;
}

// Player AI
class Actor {
	public var world:World;
	public var motives:Array<Motive>; // Reasons for doing stuff
	public var traits:IntMap<Float->Float>; // Traits that effect the way some motives change over time e.g. slobs get hungrier faster
	public var experiences:Array<Action>; // Things the actor experienced since the last time it thought
	
	public inline function new(world:World) {
		this.world = world;
		motives = new Array<Motive>();
		traits = new IntMap<Float->Float>();
		experiences = new Array<Action>();
		
		motives.push(new Motive(Problem.LULZ, 50, -1.0, 1.0, "Entertainment"));
		motives.push(new Motive(Problem.SELFESTEEM, 20, -1.0, 1.0, "Self Esteem"));
		motives.push(new Motive(Problem.TIREDNESS, 20, 3.0, 1.0, "Tiredness"));
		motives.push(new Motive(Problem.HUNGER, 50, 2.0, 1.0, "Hunger"));
		motives.push(new Motive(Problem.HYGIENE, 30, 5.0, 1.0, "Hygiene"));
		motives.push(new Motive(Problem.FUNDS, 5, -1.0, 1.0, "Funds"));
	}
	
	public function act():Void {
		for (action in experiences) {
			for (effect in action.effects) {
				effect.effect(world);
				motives[effect.problem].update(action.duration);
			}
		}
		experiences = new Array<Action>();
	}
}

class World {
	public var context:GenericStack<Location>;
	
	public var actor:Actor;
	
	public var livesRuined:Int;
	public var feelingsHurt:Int;
	
	public var date:Date;
	public var minutes:Float;
	
	public var actions:Array<Action>;
	
	public inline function new() {
		livesRuined = 0;
		feelingsHurt = 0;
		date = Date.now();
		minutes = 0;
		
		actor = new Actor(this);
		
		actions = new Array<Action>();
		
		context = new GenericStack<Location>();
	}
	
	public function update(dt:Float):Void {		
		// Step the date from the start time to the current time passed
		date = DateTools.delta(date, minutes);
	}
}

class Main {
	public var world:World;
	public var clock:FlipClock;
	public var graphs:IntMap<NeedGraph>;
	
    private static function main():Void {
		new Main();
	}
	
	private inline function new() {
		// Wait for the window to load before creating the sliders, listening for input etc
		Browser.window.onload = onWindowLoaded;
	}
	
	private inline function handleAction(action:Action):Void {
		world.actor.experiences.push(action);
		world.actor.act();
		world.minutes += action.duration;
		clock.setTime(clock.getTime() + action.duration);
		
		for (effect in action.effects) {
			var graph = graphs.get(effect.problem);
			graph.addData( { time: world.minutes, value: world.actor.motives[effect.problem].value } );
		}
	}
	
	private inline function flail():Void {
		Terminal.insert(NullActions.unrecognizedCommand.randomElement());
	}
	
	private inline function onWindowLoaded():Void {
		// Get save data, create a list of saves which will either be a time, or else a "new game" option
		var len:Int = LocalStorage.length;
		for (i in 0...len) {
			var saveName:String = LocalStorage.key(i);
		}
		
		//var g = new Generator();
		//g.init(trainingData.get("us_forenames"), 6, 0.01);
		//trace(g.serialize());
		
		// TODO initialize time and locations using saved data
		clock = new FlipClock(Browser.document.getElementById("time"), {});
		world = new World();
		world.context.add(Locations.desk);
		world.context.add(Locations.bed);
		world.context.add(Locations.fridge);
		world.context.add(Locations.shower);
		
		generateActionButtons();
		
		Terminal.push(function(command:String, terminal:Dynamic) {
			var recognizedCommand:Bool = false;
			for (location in world.context) {
				for (action in location.actions) {
					var containsParts:Bool = true;
					for (part in action.trigger) {
						if (!command.contains(part)) {
							containsParts = false;
							break;
						}
					}
					if (action.trigger.length != 0 && containsParts) {
						recognizedCommand = true;
						
						handleAction(action);
					}
				}
			}
			
			if (!recognizedCommand && command.length != 0) {
				flail();
			}
			
			generateActionButtons();
		}, {
			greetings: false,
			name: '>'
		} );
		Terminal.insert("You have 24 hours...");
		
		graphs = new IntMap<NeedGraph>();
		for (motive in world.actor.motives) {
			var graph:NeedGraph = new NeedGraph(motive, [ { time: 0, value: motive.value }, { time: 1, value: motive.value } ], "#graphs", 200, 100);
			graphs.set(motive.id, graph);
		}
	}
	
	private function generateActionButtons():Void {
		var actions = Browser.document.getElementById("actions");
		while (actions.hasChildNodes()) {
			actions.removeChild(actions.lastChild);
		}
		
		for (location in world.context) {
			for (action in location.actions) {
				var triggers:String = action.trigger.toString();
				var btn = Browser.document.createElement("button");
				var t = Browser.document.createTextNode(triggers);
				btn.appendChild(t);
				actions.appendChild(btn);
				btn.onclick = function():Void {
					handleAction(action);
				};
			}
		}
	}
}

typedef TimeData = {
	var time:Float;
	var value:Float;
}

class NeedGraph {
	public var data:Array<TimeData>;
	public var title:String;
	public var width:Int;
	public var height:Int;
	
	public var minY:Int = 0;
	public var maxY:Int = 100;
	
	public var x:Linear;
	public var y:Linear;
	public var xAxis:Axis;
	public var yAxis:Axis;
	
	public var elementId:String;
	
	public var svg:Selection;
	
	public var line:Line;
	
	public var graphId:String;
	
	public function new(need:Motive, data:Array<TimeData>, elementId:String, width:Int, height:Int) {
		this.data = data;
		this.title = need.tag;
		this.elementId = elementId;
		this.graphId = elementId.replace("#", "") + "_" + Std.string(need.id);
		
		var margin = { top: 20, right: 20, bottom: 30, left: 50 };
		this.width = width - margin.left - margin.right;
		this.height = height - margin.top - margin.bottom;
		
		// Ranges
		x = D3.scale.linear().range([0, width]);
		y = D3.scale.linear().range([height, 0]);
		
		x.domain(D3.extent(data, function(d:TimeData):Float { return d.time; }));
		y.domain(D3.extent(data, function(d:TimeData):Float { return d.value; }));
		
		// Axes
		xAxis = D3.svg.axis().scale(x).orient("bottom").ticks(4);
		yAxis = D3.svg.axis().scale(y).orient("left").ticks(4);
		
		// The line
		line = D3.svg.line().x(function(d:TimeData) { return untyped x(d.time); } ).y(function(d:TimeData) { return untyped y(d.value); } );
		
		// The canvas
		svg = D3.select(elementId).append("svg").attr("class", graphId).attr("width", width + margin.left + margin.right).attr("height", height + margin.top + margin.bottom).append("g").attr("transform", "translate(" + margin.left + "," + margin.top + ")");
		
		svg.append("g").attr("class", "xaxis").attr("transform", "translate(0," + height + ")").call(xAxis);
		svg.append("g").attr("class", "yaxis").call(yAxis);
		//svg.append("g").attr("class", "axis").append("text").attr("class", "axis-label").attr("transform", "rotate(-90)").attr("y", -margin.left + 10).attr("x", -height / 2 - margin.top).text(need.tag);
		svg.append("g").attr("class", "title").append("text").attr("x", width / 2).attr("y", -margin.top / 2).attr("text-anchor", "middle").text(need.tag);
		svg.append("path").datum(data).attr("class", "line").attr("d", line);
	}
	
	public function updateData():Void {
		x.domain(D3.extent(data, function(d:TimeData):Float { return d.time; }));
		y.domain(D3.extent(data, function(d:TimeData):Float { return d.value; } ));
		
		line = D3.svg.line().x(function(d:TimeData) { return untyped x(d.time); } ).y(function(d:TimeData) { return untyped y(d.value); } );
		
		var sel = D3.select("." + graphId).transition();
		
		sel.select(".line").attr("d", line);
		sel.select(".xaxis").call(xAxis);
		sel.select(".yaxis").call(yAxis);
	}
	
	public function addData(d:TimeData):Void {
		data.push(d);
		updateData();
	}
}