package;

import haxe.ds.GenericStack;
import haxe.ds.IntMap;
import haxe.ds.StringMap;
import js.Browser;
import js.d3.svg.SVG.Line;
import js.flipclock.FlipClock;
import js.jquery.terminal.Terminal;
import js.webStorage.LocalStorage;
import markov.namegen.Generator;
import markov.util.FileReader;
import js.d3.D3;

using StringTools;
using markov.util.StringExtensions;
using markov.util.FloatExtensions;

class Location {
	public var tag:String;
	public var description:String;
	public var actions:Array<Action>;
	
	public inline function new(tag:String, description:String) {
		this.tag = tag;
		this.description = description;
		actions = new Array<Action>();
	}
}

class Desk extends Location {
	public inline function new() {
		super("Desktop", "The old rig, designed for a hacker on steroids");
		
		actions.push(new Action([ "computer" ], 2, [ { problem: Problem.LULZ, effect:function(world:World):Void {
			Terminal.insert("You turn to your desktop, the page is open and ready. You salivate in anticipation.");
		} } ]));
	}
}

class Fridge extends Location {
	public inline function new() {
		super("Fridge", "The new fridge");
		
		actions.push(new Action([ "eat" ], 2, [ { problem: Problem.HUNGER, effect:function(world:World):Void {
			Terminal.insert("You shuffle to the fridge and grab the first thing you see.");
		} } ]));
	}
}

class Bed extends Location {
	public inline function new() {
		super("Bed", "The old bed");
		
		actions.push(new Action([ "sleep" ], 2, [ { problem: Problem.TIREDNESS, effect:function(world:World):Void {
			Terminal.insert("You settle down for a night of rest.");
		} } ]));
	}
}

class Shower extends Location {
	public inline function new() {
		super("Shower", "The shower.");
		
		actions.push(new Action([ "shower" ], 2, [ { problem: Problem.HYGIENE, effect:function(world:World):Void {
			Terminal.insert("You wash the filth off your body.");
		} } ]));
	}
}

class Locations {
	public static var desk:Desk = new Desk();
	public static var fridge:Fridge = new Fridge();
	public static var bed:Bed = new Bed();
	public static var shower:Shower = new Shower();
}

class World {
	public var context:GenericStack<Location>;
	
	public var actor:Actor;
	
	public var livesRuined:Int;
	public var feelingsHurt:Int;
	
	private var date:Date;
	private var minutes:Float;
	
	private var actions:Array<Action>;
	
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
		// Step the AI
		for (action in actions) {
			minutes += action.duration;
			actor.act(action);
		}
		
		// Step the date from the start time to the current time passed
		date = DateTools.delta(date, minutes);
		
		actions = new Array<Action>();
		actor.think(dt);
		//actor.decide();
	}
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
	public function new(id:Problem, initial:Float, rate:Float = 1.0, multiplier:Float = 1.0, tag:String = "Unnamed Motive", decayCurve:Float->Float = null) {
		this.id = id;
		this.value = initial;
		this.rate = rate;
		this.multiplier = multiplier;
		this.tag = tag;
		
		if(decayCurve != null) {
			this.decayCurve = decayCurve;
		} else {
			// Linear
			this.decayCurve = function(v:Float):Float {
				return v;
			}
		}
	}
	
	public function update(dt:Float):Void {
		value += decayCurve(value) * dt * rate * multiplier;
		value = value.clamp(0, 100);
	}
	
	public var id:Int;
	public var value:Float;
	public var rate:Float;
	public var multiplier:Float;
	public var tag:String;
	public var decayCurve:Float->Float;
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

// TODO need floating bits at the top for relevant info
// TODO need buttons at the bottom for actions

// Player AI
class Actor {
	public var world:World;
	public var motives:Array<Motive>; // Reasons for doing stuff
	public var traits:IntMap<Float->Float>; // Traits that effect the way some motives change over time e.g. slobs get hungrier faster
	public var experiences:Array<Int>; // Things the actor experienced since the last time it thought
	
	public inline function new(world:World) {
		this.world = world;
		motives = new Array<Motive>();
		traits = new IntMap<Float->Float>();
		experiences = new Array<Int>();
		
		motives.push(new Motive(Problem.LULZ, 50, -1.0));
		motives.push(new Motive(Problem.SELFESTEEM, 20, -1));
		motives.push(new Motive(Problem.TIREDNESS, 20, 3));
		motives.push(new Motive(Problem.HUNGER, 50, 2));
		motives.push(new Motive(Problem.HYGIENE, 30, 5));
		motives.push(new Motive(Problem.FUNDS, 5, -1));
	}
	
	public function think(dt:Float):Void {
		for (e in experiences) {
			
		}
		//experiences = new Array<Int>();
		
		// Generate a probability distribution for the motives
	}
	
	public function decide():Void {
		// TODO avoid doing the same thing repeatedly, have upper limits to stuff? think smart objects...
	}
	
	public function act(action:Action):Void {
		for (motive in motives) {
			motive.update(action.duration);
		}
	}
	
	public function forceAction(action:Action):Bool {
		for (effect in action.effects) {
			effect.effect(world);
		}
		
		return true;
	}
	
	// Location
	// Coordinate
}

class Main {
	private var world:World;
	private var clock:FlipClock;
	private var graphs:IntMap<NeedGraph>;
	
	private var trainingData:StringMap<Array<String>>;
	
    private static function main():Void {
		new Main();
	}
	
	private inline function new() {
		// TODO fromBase64 decode and fromJson to create generators for all the different text
		
		// Build a lookup table for the training data
		trainingData = new StringMap<Array<String>>();
		trainingData.set("us_forenames", FileReader.readFile("embed/usforenames.txt").split("\n"));
		trainingData.set("tolkienesque_forenames", FileReader.readFile("embed/tolkienesqueforenames.txt").split("\n"));
		trainingData.set("werewolf_forenames", FileReader.readFile("embed/werewolfforenames.txt").split("\n"));
		trainingData.set("romandeity_forenames", FileReader.readFile("embed/romandeityforenames.txt").split("\n"));
		trainingData.set("norsedeity_forenames", FileReader.readFile("embed/norsedeityforenames.txt").split("\n"));
		trainingData.set("swedish_forenames", FileReader.readFile("embed/swedishforenames.txt").split("\n"));
		trainingData.set("english_towns", FileReader.readFile("embed/englishtowns.txt").split("\n"));
		trainingData.set("theological_demons", FileReader.readFile("embed/theologicaldemons.txt").split("\n"));
		trainingData.set("scottish_surnames", FileReader.readFile("embed/scottishsurnames.txt").split("\n"));
		trainingData.set("irish_forenames", FileReader.readFile("embed/irishforenames.txt").split("\n"));
		trainingData.set("icelandic_forenames", FileReader.readFile("embed/icelandicforenames.txt").split("\n"));
		trainingData.set("theological_angels", FileReader.readFile("embed/theologicalangels.txt").split("\n"));
		trainingData.set("japanese_forenames", FileReader.readFile("embed/japaneseforenames.txt").split("\n"));
		trainingData.set("french_forenames", FileReader.readFile("embed/frenchforenames.txt").split("\n"));
		trainingData.set("german_towns", FileReader.readFile("embed/germantowns.txt").split("\n"));
		trainingData.set("animals", FileReader.readFile("embed/animals.txt").split("\n"));
		trainingData.set("pokemon", FileReader.readFile("embed/pokemon.txt").split("\n"));
		trainingData.set("fish", FileReader.readFile("embed/fish.txt").split("\n"));
		trainingData.set("plantscommon", FileReader.readFile("embed/plantscommon.txt").split("\n"));
		//trainingData.set("profanity_filter", FileReader.readFile("embed/profanityfilter.txt").split("\n")); // Skipping this one for SEO and paranoia reasons	
		
		// Wait for the window to load before creating the sliders, listening for input etc
		Browser.window.onload = onWindowLoaded;
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
				
		Terminal.push(function(command:String, terminal:Dynamic) {			
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
						if (world.actor.forceAction(action)) {
							clock.setTime(clock.getTime() + 1);
						}
					}
				}
			}
		}, {
			greetings: false,
			name: '>'
		} );
		Terminal.insert("You have 24 hours...");
		
		graphs = new IntMap<NeedGraph>();
		for (motive in world.actor.motives) {
			var graph:NeedGraph = new NeedGraph(motive, "#graphs", 200, 100);
			graphs.set(motive.id, graph);
		}
	}
	
	// Get a line of text
	private function talk(type:Int, topic:Int = 0, context:Dynamic = null):String {
		return "I'm talking";
	}
	
	private function generateTweet(type:Int, topic:Int = 0, context:Dynamic = null):String {
		return "I'm an enemy Tweet";
	}
	
	private function generateActionButtons():Void {
		
	}
}

typedef TimeData = {
	var time:Float;
	var value:Float;
}

class NeedGraph {
	private var title:String;
	private var width:Int;
	private var height:Int;
	
	private var minY:Int = 0;
	private var maxY:Int = 100;
	
	public function new(need:Motive, elementId:String, width:Int, height:Int) {
		this.title = need.tag;
		
		var margin = { top: 20, right: 20, bottom: 30, left: 50 };
		this.width = width - margin.left - margin.right;
		this.height = height - margin.top - margin.bottom;
		
		var data = [ { time: 240, value: 0 }, { time: 340, value: 90 }, { time: 630, value: 10 } ];
		
		// Ranges
		var x = D3.scale.linear().range([0, width]);
		var y = D3.scale.linear().range([height, 0]);
		
		x.domain(D3.extent(data, function(d:TimeData):Float { return d.time; }));
		y.domain(D3.extent(data, function(d:TimeData):Float { return d.value; }));
		
		// Axes
		var xAxis = D3.svg.axis().scale(x).orient("bottom").ticks(4);
		var yAxis = D3.svg.axis().scale(y).orient("left").ticks(4);
		
		// The line
		var line:Line = D3.svg.line().x(function(d:TimeData) { return d.time; } ).y(function(d:TimeData) { return d.value; } );
		
		// The canvas
		var svg = D3.select(elementId).append("svg").attr("width", width + margin.left + margin.right).attr("height", height + margin.top + margin.bottom).append("g").attr("transform", "translate(" + margin.left + "," + margin.top + ")");
		
		svg.append("g").attr("class", "axis").attr("transform", "translate(0," + height + ")").call(xAxis);
		svg.append("g").attr("class", "axis").call(yAxis);
		//svg.append("g").attr("class", "axis").append("text").attr("class", "axis-label").attr("transform", "rotate(-90)").attr("y", -margin.left + 10).attr("x", -height / 2 - margin.top).text(need.tag);
		svg.append("g").attr("class", "title").append("text").attr("x", width / 2).attr("y", -margin.top / 2).attr("text-anchor", "middle").text(need.tag);
		svg.append("path").datum(data).attr("class", "line").attr("d", line);
	}
	
	public function updateData():Void {
		
	}
}