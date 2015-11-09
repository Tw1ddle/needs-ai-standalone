package;

import Main;
import js.jquery.terminal.Terminal;
import ai.Action;
import ai.Brain;
import ai.Need;

using util.ArrayExtensions;

class Strings {
	public static var walkingAdjective = [
	"shuffle",
	"waddle",
	"dodder",
	"shamble",
	"lurch",
	"stumble",
	"reel",
	"stagger"
	];
	
	public static var eatingDescription = [
	"wolf it down",
	"gobble it greedily",
	"feast on it",
	"voraciously scarf it down"
	];
	
	public static var unrecognizedCommand:Array<String> = [ 
	"You flail uselessly."
	];
}

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

@:enum abstract ProblemId(Int) from Int to Int {
	var LULZ = 0;
	var TIREDNESS = 1;
	var HUNGER = 2;
	var HYGIENE = 3;
	var BLADDER = 4;
}

@:enum abstract ActionId(Int) from Int to Int {
	var COMPUTER = 0;
	var SLEEP = 1;
	var EAT = 2;
	var SHOWER = 3;
	var TOILET = 4;
}

class Desk extends Location {
	public inline function new(world:World) {
		super("Desktop", "The old rig, designed for a hacker on steroids");
		
		actions.push(new Action(ActionId.COMPUTER, [ "computer" ], 8, [ { id: ProblemId.LULZ, effect:function(world:World):Void {
			Terminal.echo("You turn to your desktop, the page is open and ready. You salivate in anticipation.");
		} } ]));
	}
}

typedef FoodItem = { var name:String; var descriptions:Array<String>; var effects:Brain->Void; };
class Fridge extends Location {
	private var foods:Array<FoodItem>;
	
	public inline function new(world:World) {
		super("Fridge", "The new fridge");
		
		foods = [ 
			{ name: "tin of beans", descriptions: ["It says best before June 2012"], effects: function(actor:Brain):Void { actor.needs[ProblemId.HUNGER].value -= 0.2; actor.needs[ProblemId.BLADDER].value += 0.1; actor.needs[ProblemId.HYGIENE].value -= 0.05; } },
			{ name: "tin of beans", descriptions: ["It says best before June 2012"], effects: function(actor:Brain):Void { actor.needs[ProblemId.HUNGER].value -= 0.2; actor.needs[ProblemId.BLADDER].value += 0.1; } },
			{ name: "tin of beans", descriptions: ["It says best before June 2012"], effects: function(actor:Brain):Void { actor.needs[ProblemId.HUNGER].value -= 0.2; actor.needs[ProblemId.BLADDER].value += 0.1; } },
			{ name: "tin of beans", descriptions: ["It says best before June 2012"], effects: function(actor:Brain):Void { actor.needs[ProblemId.HUNGER].value -= 0.2; actor.needs[ProblemId.BLADDER].value += 0.1; } },
			{ name: "tin of beans", descriptions: ["It says best before June 2012"], effects: function(actor:Brain):Void { actor.needs[ProblemId.HUNGER].value -= 0.2; actor.needs[ProblemId.BLADDER].value += 0.1; } }
		];
		
		actions.push(new Action(ActionId.EAT, [ "eat" ], 10, [ { id: ProblemId.HUNGER, effect:function(world:World):Void {
			Terminal.echo("You " + Strings.walkingAdjective.randomElement() + " to the fridge and grab the first thing you see... ");
			
			var item = foods.randomElement();
			
			Terminal.echo("It's a " + item.name + ". " + item.descriptions.randomElement() + ". You " + Strings.eatingDescription.randomElement() + ".");
			
			item.effects(world.actor);
		} } ]));
	}
}

class Bed extends Location {
	public inline function new(world:World) {
		super("Bed", "The old bed");
		
		actions.push(new Action(ActionId.SLEEP, [ "sleep" ], 40, [ { id: ProblemId.TIREDNESS, effect:function(world:World):Void {
			Terminal.echo("You settle down for forty winks.");
		} } ]));
	}
}

class Shower extends Location {
	public inline function new(world:World) {
		super("Shower", "The shower.");
		
		actions.push(new Action(ActionId.SHOWER, [ "shower" ], 15, [ { id: ProblemId.HYGIENE, effect:function(world:World):Void {
			Terminal.echo("You wash the filth off your body.");
		} } ]));
	}
}

class Toilet extends Location {
	public inline function new(world:World) {
		super("Toilet", "The toilet.");
		
		actions.push(new Action(ActionId.TOILET, [ "toilet" ], 5, [ { id: ProblemId.BLADDER, effect:function(world:World):Void {
			Terminal.echo("You relieve yourself.");
		} } ]));
	}
}