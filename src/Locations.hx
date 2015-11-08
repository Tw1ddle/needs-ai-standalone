package;

import Main;
import js.jquery.terminal.Terminal;

using markov.util.ArrayExtensions;

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

class Desk extends Location {
	public inline function new(world:World) {
		super("Desktop", "The old rig, designed for a hacker on steroids");
		
		actions.push(new Action([ "computer" ], 8, [ { problem: Problem.LULZ, effect:function(world:World):Void {
			Terminal.echo("You turn to your desktop, the page is open and ready. You salivate in anticipation.");
		} } ]));
	}
}

typedef FoodItem = { var name:String; var descriptions:Array<String>; var effects:Actor->Void; };
class Fridge extends Location {
	private var foods:Array<FoodItem>;
	
	public inline function new(world:World) {
		super("Fridge", "The new fridge");
		
		foods = [ 
			{ name: "tin of beans", descriptions: ["It says best before June 2012"], effects: function(actor:Actor):Void { actor.motives[Problem.HUNGER].value -= 0.2; actor.motives[Problem.BLADDER].value += 0.1; actor.motives[Problem.HYGIENE].value -= 0.05; } },
			{ name: "tin of beans", descriptions: ["It says best before June 2012"], effects: function(actor:Actor):Void { actor.motives[Problem.HUNGER].value -= 0.2; actor.motives[Problem.BLADDER].value += 0.1; } },
			{ name: "tin of beans", descriptions: ["It says best before June 2012"], effects: function(actor:Actor):Void { actor.motives[Problem.HUNGER].value -= 0.2; actor.motives[Problem.BLADDER].value += 0.1; } },
			{ name: "tin of beans", descriptions: ["It says best before June 2012"], effects: function(actor:Actor):Void { actor.motives[Problem.HUNGER].value -= 0.2; actor.motives[Problem.BLADDER].value += 0.1; } },
			{ name: "tin of beans", descriptions: ["It says best before June 2012"], effects: function(actor:Actor):Void { actor.motives[Problem.HUNGER].value -= 0.2; actor.motives[Problem.BLADDER].value += 0.1; } }
		];
		
		actions.push(new Action([ "eat" ], 10, [ { problem: Problem.HUNGER, effect:function(world:World):Void {
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
		
		actions.push(new Action([ "sleep" ], 40, [ { problem: Problem.TIREDNESS, effect:function(world:World):Void {
			Terminal.echo("You settle down for forty winks.");
		} } ]));
	}
}

class Shower extends Location {
	public inline function new(world:World) {
		super("Shower", "The shower.");
		
		actions.push(new Action([ "shower" ], 15, [ { problem: Problem.HYGIENE, effect:function(world:World):Void {
			Terminal.echo("You wash the filth off your body.");
		} } ]));
	}
}

class Toilet extends Location {
	public inline function new(world:World) {
		super("Toilet", "The toilet.");
		
		actions.push(new Action([ "toilet" ], 5, [ { problem: Problem.BLADDER, effect:function(world:World):Void {
			Terminal.echo("You relieve yourself.");
		} } ]));
	}
}