package;

import Main;
import ai.Brain;
import js.jquery.terminal.Terminal;
import Ids;

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
	public var tag(default, null):String;
	public var description(default, null):String;
	public var actions(default, null):Array<TriggerAction>;
	
	public inline function new(tag:String, description:String) {
		this.tag = tag;
		this.description = description;
		actions = new Array<TriggerAction>();
	}
}

class Desk extends Location {
	public inline function new(world:World) {
		super("Desktop", "The old rig, designed for a hacker on steroids");
		
		actions.push(new TriggerAction(ActionId.COMPUTER, [ "computer" ], 8, [ { id: ProblemId.LULZ, effect:function(world:World):Void {
			Terminal.echo("You turn to your desktop, the page is open and ready. You salivate in anticipation.");
			
			world.agent.brain.needs[ProblemId.LULZ].value -= 0.2;
		} } ]));
	}
}

typedef FoodItem = { var name:String; var descriptions:Array<String>; var effects:Brain->Void; };
class Fridge extends Location {
	private var foods:Array<FoodItem>;
	
	public inline function new(world:World) {
		super("Fridge", "The new fridge");
		
		foods = [ 
			{ name: "tin of beans", descriptions: ["It says best before June 2012"], effects: function(brain:Brain):Void { brain.needs[ProblemId.HUNGER].value -= 0.2; brain.needs[ProblemId.BLADDER].value += 0.1; brain.needs[ProblemId.HYGIENE].value -= 0.05; } },
			{ name: "tin of beans", descriptions: ["It says best before June 2012"], effects: function(brain:Brain):Void { brain.needs[ProblemId.HUNGER].value -= 0.2; brain.needs[ProblemId.BLADDER].value += 0.1; } },
			{ name: "tin of beans", descriptions: ["It says best before June 2012"], effects: function(brain:Brain):Void { brain.needs[ProblemId.HUNGER].value -= 0.2; brain.needs[ProblemId.BLADDER].value += 0.1; } },
			{ name: "tin of beans", descriptions: ["It says best before June 2012"], effects: function(brain:Brain):Void { brain.needs[ProblemId.HUNGER].value -= 0.2; brain.needs[ProblemId.BLADDER].value += 0.1; } },
			{ name: "tin of beans", descriptions: ["It says best before June 2012"], effects: function(brain:Brain):Void { brain.needs[ProblemId.HUNGER].value -= 0.2; brain.needs[ProblemId.BLADDER].value += 0.1; } }
		];
		
		actions.push(new TriggerAction(ActionId.EAT, [ "eat" ], 10, [ { id: ProblemId.HUNGER, effect:function(world:World):Void {
			Terminal.echo("You " + Strings.walkingAdjective.randomElement() + " to the fridge and grab the first thing you see... ");
			
			var item:FoodItem = foods.randomElement();
			
			Terminal.echo("It's a " + item.name + ". " + item.descriptions.randomElement() + ". You " + Strings.eatingDescription.randomElement() + ".");
			
			item.effects(world.agent.brain);
		} } ]));
	}
}

class Bed extends Location {
	public inline function new(world:World) {
		super("Bed", "The old bed");
		
		actions.push(new TriggerAction(ActionId.SLEEP, [ "sleep" ], 40, [ { id: ProblemId.TIREDNESS, effect:function(world:World):Void {
			Terminal.echo("You settle down for forty winks.");
			
			var rest = Math.random() * 0.5 + 0.3;
			world.agent.brain.needs[ProblemId.TIREDNESS].value -= rest;
		} } ]));
	}
}

class Shower extends Location {
	public inline function new(world:World) {
		super("Shower", "The shower.");
		
		actions.push(new TriggerAction(ActionId.SHOWER, [ "shower" ], 15, [ { id: ProblemId.HYGIENE, effect:function(world:World):Void {
			Terminal.echo("You wash the filth off your body.");
			
			var clean = 0.3;
			
			world.agent.brain.needs[ProblemId.HYGIENE].value -= clean;
		} } ]));
	}
}

class Toilet extends Location {
	public inline function new(world:World) {
		super("Toilet", "The toilet.");
		
		actions.push(new TriggerAction(ActionId.TOILET, [ "toilet" ], 5, [ { id: ProblemId.BLADDER, effect:function(world:World):Void {
			Terminal.echo("You relieve yourself.");
			
			world.agent.brain.needs[ProblemId.BLADDER].value -= 1.0;
		} } ]));
	}
}