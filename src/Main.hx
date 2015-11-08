package;

import haxe.ds.GenericStack;
import haxe.ds.IntMap;
import js.Browser;
import js.d3.D3;
import js.d3.scale.Scale.Linear;
import js.d3.selection.Selection;
import js.d3.svg.SVG.Axis;
import js.d3.svg.SVG.Line;
import js.flipclock.FlipClock;
import js.jquery.terminal.Terminal;
import Locations;

using StringTools;
using markov.util.StringExtensions;
using markov.util.FloatExtensions;
using markov.util.ArrayExtensions;

class NullActions {
	public static var unrecognizedCommand:Array<String> = [ 
	"You flail uselessly."
	];
}

// Like Sims "commodities", express a class of need e.g. to be in the gym, to not go hungry
@:enum abstract Problem(Int) from Int to Int {
	var LULZ = 0;
	var TIREDNESS = 1;
	var HUNGER = 2;
	var HYGIENE = 3;
	var BLADDER = 4;
}

// Motives are measures of the need to react to problems
class Motive {
	public var id:Int;
	public var value(default, set):Float;
	public var drainRate:Float;
	public var modifier:Float;
	public var tag:String;
	public var drainCurve:Float->Float;
	
	public function new(id:Problem, initialValue:Float, drainRate:Float = 0.01, drainModifier:Float = 1.0, tag:String = "Unnamed Motive", drainCurve:Float->Float = null) {
		this.id = id;
		this.value = initialValue;
		this.drainRate = drainRate;
		this.modifier = drainModifier;
		this.tag = tag;
		
		if(drainCurve != null) {
			this.drainCurve = drainCurve;
		} else {
			this.drainCurve = function(v:Float):Float {
				return v;
			}
		}
	}
	
	public function update(dt:Float):Void {
		value += drainCurve(dt * drainRate * modifier);
	}
	
	private function set_value(v:Float):Float {
		return this.value = v.clamp(0, 1);
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
	
	public var autonomous:Bool; // Whether to use the AI
	
	public inline function new(world:World) {
		this.world = world;
		motives = new Array<Motive>();
		traits = new IntMap<Float->Float>();
		experiences = new Array<Action>();
		
		autonomous = true;
		
		motives.push(new Motive(Problem.LULZ, 0.50, 0.03, 1.0, "Boredom"));
		motives.push(new Motive(Problem.TIREDNESS, 0.07, 0.01, 1.0, "Tiredness"));
		motives.push(new Motive(Problem.HUNGER, 0.5, 0.04, 1.0, "Hunger"));
		motives.push(new Motive(Problem.HYGIENE, 0.3, 0.06, 1.0, "Hygiene"));
		motives.push(new Motive(Problem.BLADDER, 0.5, 0.07, 1.0, "Bladder"));
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
	
	public function step(dt:Float):Void {
		for (motive in motives) {
			motive.update(dt);
		}
		
		// TODO if autonomous then do something
		// TODO create probability distribution, or always choose best option, or maybe use min/max triggers
	}
}

class World {
	public var context:GenericStack<Location>;
	
	public var actor:Actor;
	
	public var clock:FlipClock;
	
	public var livesRuined:Int;
	public var feelingsHurt:Int;
	
	public var minutes(default, set):Float;
	public var lastUpdateMinutes:Float;
	
	public var actions:Array<Action>;
	
	public inline function new() {
		livesRuined = 0;
		feelingsHurt = 0;
		minutes = 0;
		lastUpdateMinutes = 0;
		
		actor = new Actor(this);
		
		actions = new Array<Action>();
		
		context = new GenericStack<Location>();
	}
	
	public function update(dt:Float):Void {
		actor.step(dt);
	}
	
	public function set_minutes(min:Float):Float {
		if(clock != null) {
			clock.setTime(min * 60);
		}
		return this.minutes = min;
	}
}

class Main {
	public var world:World;
	public var graphs:IntMap<NeedGraph>;
	public var gameOver:Bool;
	
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
		
		for (effect in action.effects) {
			var graph = graphs.get(effect.problem);
			graph.addData( { time: world.minutes, value: world.actor.motives[effect.problem].value }, world.minutes );
		}
	}
	
	private inline function flail():Void {
		Terminal.echo(NullActions.unrecognizedCommand.randomElement(), {});
	}
	
	private inline function onWindowLoaded():Void {
		gameOver = false;

		world = new World();
		world.clock = new FlipClock(Browser.document.getElementById("time"), { } );
		world.clock.stop();
		world.context.add(new Desk(world));
		world.context.add(new Bed(world));
		world.context.add(new Fridge(world));
		world.context.add(new Shower(world));
		world.context.add(new Toilet(world));
		
		generateActionButtons();
		generateSettingsButtons();
		
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
		Terminal.echo("You have 24 hours...", {});
		
		graphs = new IntMap<NeedGraph>();
		for (motive in world.actor.motives) {
			var graph:NeedGraph = new NeedGraph(motive, [ { time: 0, value: motive.value } ], "#graphs", 200, 100);
			graphs.set(motive.id, graph);
		}
		
		var f = Browser.window.setInterval(function() {
			world.minutes += 1;
			world.update(1);
			
			for (graph in graphs) {				
				for (motive in world.actor.motives) {
					var graph:NeedGraph = graphs.get(motive.id);
					graph.addData( { time: world.minutes, value: motive.value }, world.minutes );
				}
			}
			
			if (world.minutes >= 60 * 24) {
				gameOver = true;
				world.clock.stop();
				Terminal.echo("Time's up. Better start looking for a job...", {});
			}
		}, 1000);
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
	
	private function generateSettingsButtons():Void {
		var settings = Browser.document.getElementById("settings");
		var btn = Browser.document.createElement("button");
		var t = Browser.document.createTextNode("toggle AI");
		btn.appendChild(t);
		settings.appendChild(btn);
		btn.onclick = function():Void {
			world.actor.autonomous = !world.actor.autonomous;
		};
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
	public var maxY:Int = 1;
	
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
		y.domain([minY, maxY]);
		
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
	
	public function updateData(minutes:Float):Void {
		x.domain([0, minutes]);
		
		line = D3.svg.line().x(function(d:TimeData) { return untyped x(d.time); } ).y(function(d:TimeData) { return untyped y(d.value); } );
		
		var sel = D3.select("." + graphId).transition();
		
		sel.select(".line").attr("d", line);
		sel.select(".xaxis").call(xAxis);
		sel.select(".yaxis").call(yAxis);
	}
	
	public function addData(d:TimeData, worldMinutes:Float):Void {
		data.push(d);
		updateData(worldMinutes);
	}
}