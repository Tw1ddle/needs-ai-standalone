package;

import haxe.ds.StringMap;
import js.Browser;
import js.webStorage.LocalStorage;
import markov.namegen.Generator;
import markov.util.FileReader;

using StringTools;
using markov.util.StringExtensions;
using markov.util.FloatExtensions;

class World {
	public var actor:Actor;
	
	public var livesRuined:Int;
	public var feelingsHurt:Int;
	
	private var date:Date;
	public var minutes:Float;
	// Grid
	// Bounds
	
	private var actions:Array<Action>;
	
	public function new() {
		livesRuined = 0;
		feelingsHurt = 0;
		minutes = 0;
		
		date = Date.now();
		
		actor = new Actor();
		
		actions = new Array<Action>();
	}
	
	public function update(dt:Float):Void {
		// Step the date from the start time to the current time passed
		date = DateTools.delta(date, minutes);
		
		// Step the AI
		for (action in actions) {
			actor.act(action);
		}
		actions = new Array<Action>();
		actor.think(dt);
		actor.decide();
	}
}

// Like Sims "commodities", express a class of need e.g. to be in the gym, to not go hungry
@:enum abstract Problem(Int) from Int to Int {
	var LULZ = 0;
	var SELFESTEEM = 1;
	var TIREDNESS = 2;
	var HUNGER = 3;
	var HYGIENE = 4;
}

// Motives influence the need to react to problems
class Motive {
	public function new(id:Problem, initial:Float, rate:Float = 1.0, multiplier:Float = 1.0) {
		this.id = id;
		this.value = initial;
		this.rate = rate;
		this.multiplier = multiplier;
	}
	
	public function update(dt:Float):Void {
		value += decayCurve(value) * dt * rate * multiplier;
		value = value.clamp(0, 100);
	}
	
	public var id:Int;
	public var value:Float;
	public var rate:Float;
	public var multiplier:Float;
	public var decayCurve:Float->Float;
}

// Solutions to problems
typedef ActionEffect = { var problem:Problem; var effect:Motive->World->Void; }
class Action {
	public function new(duration:Float, effects:Array<ActionEffect>) {
		this.duration = duration;
		this.effects = effects;
	}
	
	public var duration:Float;
	public var effects:Array<ActionEffect>;
}

// TODO need floating bits at the top for relevant info

// Player AI
class Actor {
	private var motives:Array<Motive>; // Reasons for doing stuff
	private var traits:Array<Float->Float>; // Traits that effect the way some motives change over time e.g. slobs get hungrier faster
	private var experiences:Array<Int>; // Things the actor experienced since the last time it thought
	
	public function new() {
		motives = new Array<Motive>();
		traits = new Array<Float->Float>();
		experiences = new Array<Int>();
		
		motives.push(new Motive(Problem.LULZ, 50, -1.0));
		motives.push(new Motive(Problem.SELFESTEEM, 20, -1));
		motives.push(new Motive(Problem.TIREDNESS, 20, 3));
		motives.push(new Motive(Problem.HUNGER, 50, 2));
		motives.push(new Motive(Problem.HYGIENE, 30, 5));
	}
	
	public function think(dt:Float):Void {
		//for (e in experiences) {
		//	
		//}
		// experiences = new Array<Int>();
		
		// Generate a probability distribution for the motives
	}
	
	public function decide():Void {
		
	}
	
	public function act(action:Action):Void {
		for (motive in motives) {
			motive.update(action.duration);
		}
	}
	
	//public function forceAction(action:Action):Void {
	//	
	//}
	
	// Location
	// Coordinate
}

class Main {
	private var world:World;
	
	private var trainingData:StringMap<Array<String>>;
	
    private static function main():Void {
		new Main();
	}
	
	// TODO make markov chains saveable so we can reuse them
	
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
		
		var g = new Generator();
		g.init(trainingData.get("us_forenames"), 6, 0.01);
		//trace(g.serialize());
		
		world = new World();
		
		Browser.document.addEventListener("console_log", function(e:Dynamic) {
			trace(e.detail.data);
		});
	}
	
	// Get a line of text
	private function talk(type:Int, topic:Int = 0, context:Dynamic = null):String {
		return "I'm talking";
	}
	
	private function generateTweet(type:Int, topic:Int = 0, context:Dynamic = null):String {
		return "I'm an enemy Tweet";
	}
}