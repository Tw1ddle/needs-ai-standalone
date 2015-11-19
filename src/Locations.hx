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
	"voraciously scarf it down",
	"gag on it as it goes down",
	"burp in satisfaction",
	"choke it down",
	"swallow it whole"
	];
	
	public static var showeringDescription = [
	"You scrub up and delouse in the shower.",
	"You do your ablutions. The mouldy shower curtain catches you on your way out.",
	"You take a long soak in the shower and groom your nose hair."
	];
	
	public static var unrecognizedCommand:Array<String> = [ 
	"You flail uselessly."
	];
}

// Models a location and available actions within the game world
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

typedef ComputerTask = { var descriptions:Array<String>; var effects:Brain->Void; };
class Desk extends Location {
	private var tasks:Array<ComputerTask>;
	
	public inline function new(world:World) {
		super("Desktop", "The old rig, designed for a hacker on steroids");
		
		tasks = [
			{ descriptions: ["You clear out your emails. George Schulz has sent you 44 new messsages about penis enlargement solutions."], effects: function(brain:Brain):Void { brain.needs[NeedId.LULZ].value -= 0.3; } },
			{ descriptions: ["You check your Facebook profile. Two new notifications."], effects: function(brain:Brain):Void { brain.needs[NeedId.LULZ].value -= 0.4; } },
			{ descriptions: ["You watch an amusing video of an acrobatic cat."], effects: function(brain:Brain):Void { brain.needs[NeedId.LULZ].value -= 0.3; } },
			{ descriptions: ["You post an angry rant about the state of student politics today."], effects: function(brain:Brain):Void { brain.needs[NeedId.LULZ].value -= 0.3; } },
			{ descriptions: ["You offend someone who disagrees with you on Twitter."], effects: function(brain:Brain):Void { brain.needs[NeedId.LULZ].value -= 0.4; } },
			{ descriptions: ["You browse a gallery of awkward family photos."], effects: function(brain:Brain):Void { brain.needs[NeedId.LULZ].value -= 0.3; } },
			{ descriptions: ["You watch a video starring an anthropomorphic talking dog."], effects: function(brain:Brain):Void { brain.needs[NeedId.LULZ].value -= 0.4; } },
			{ descriptions: ["You read the daily Dilbert comic."], effects: function(brain:Brain):Void { brain.needs[NeedId.LULZ].value -= 0.5; } },
			{ descriptions: ["You click on some clickbait ads."], effects: function(brain:Brain):Void { brain.needs[NeedId.LULZ].value -= 0.2; } },
		];
		
		actions.push(new TriggerAction(ActionId.COMPUTER, [ "computer" ], 8, [ { id: NeedId.LULZ, effect:function(world:World):Void {
			var item = tasks.randomElement();
			
			Terminal.echo(item.descriptions.randomElement());
			
			item.effects(world.agent.brain);
		} } ]));
	}
}

typedef FoodItem = { var name:String; var descriptions:Array<String>; var effects:Brain->Void; };
class Fridge extends Location {
	private var foods:Array<FoodItem>;
	
	public inline function new(world:World) {
		super("Fridge", "The new fridge");
		
		foods = [ 
			{ name: "tin of beans", descriptions: ["It says best before June 2012"], effects: function(brain:Brain):Void { brain.needs[NeedId.HUNGER].value -= 0.2; brain.needs[NeedId.BLADDER].value += 0.1; brain.needs[NeedId.HYGIENE].value -= 0.05; } },
			{ name: "pack of stale biscuits", descriptions: ["They look like they've been open for months"], effects: function(brain:Brain):Void { brain.needs[NeedId.HUNGER].value -= 0.1; brain.needs[NeedId.BLADDER].value += 0.03; } },
			{ name: "baked potato with green fur", descriptions: ["A rancid smell emanates from it"], effects: function(brain:Brain):Void { brain.needs[NeedId.HUNGER].value -= 0.3; brain.needs[NeedId.BLADDER].value += 0.1; } },
			{ name: "bag of disintegrating salad", descriptions: ["It gives off a noxious, sour odour"], effects: function(brain:Brain):Void { brain.needs[NeedId.HUNGER].value -= 0.4; brain.needs[NeedId.BLADDER].value += 0.1; } },
			{ name: "mouldy cheese", descriptions: ["It's hard and tasteless"], effects: function(brain:Brain):Void { brain.needs[NeedId.HUNGER].value -= 0.3; brain.needs[NeedId.BLADDER].value += 0.1; } },
			{ name: "shrivelled apple", descriptions: ["It smells worse than a septic tank"], effects: function(brain:Brain):Void { brain.needs[NeedId.HUNGER].value -= 0.5; brain.needs[NeedId.BLADDER].value += 0.1; } },
			{ name: "suspicious fish", descriptions: ["Stinks of... fish"], effects: function(brain:Brain):Void { brain.needs[NeedId.HUNGER].value -= 0.7; brain.needs[NeedId.BLADDER].value += 0.1; } },
			{ name: "milk-spattered lettuce", descriptions: ["Looks and smells toxic"], effects: function(brain:Brain):Void { brain.needs[NeedId.HUNGER].value -= 0.4; brain.needs[NeedId.BLADDER].value += 0.1; } },
			{ name: "raw chicken", descriptions: ["It has a slightly green tinge"], effects: function(brain:Brain):Void { brain.needs[NeedId.HUNGER].value -= 0.2; brain.needs[NeedId.BLADDER].value += 0.1; } },
			{ name: "bowl of steamed rice", descriptions: ["It was left in the rice cooker for a few weeks"], effects: function(brain:Brain):Void { brain.needs[NeedId.HUNGER].value -= 0.5; brain.needs[NeedId.BLADDER].value += 0.1; } },
			{ name: "pound of ground beef", descriptions: ["Looks as if a small animal has been gnawing on it"], effects: function(brain:Brain):Void { brain.needs[NeedId.HUNGER].value -= 0.2; brain.needs[NeedId.BLADDER].value += 0.1; } },
			{ name: "broccoli casserole", descriptions: ["Several weeks old"], effects: function(brain:Brain):Void { brain.needs[NeedId.HUNGER].value -= 0.4; brain.needs[NeedId.BLADDER].value += 0.1; } },
			{ name: "dish of burnt refried beans", descriptions: ["They have a smoky carbonized aroma"], effects: function(brain:Brain):Void { brain.needs[NeedId.HUNGER].value -= 0.3; brain.needs[NeedId.BLADDER].value += 0.1; } },
			{ name: "pint-glass of rancid milk", descriptions: ["There's something swimming in it"], effects: function(brain:Brain):Void { brain.needs[NeedId.HUNGER].value -= 0.3; brain.needs[NeedId.BLADDER].value += 0.1; } }
		];
		
		actions.push(new TriggerAction(ActionId.EAT, [ "eat" ], 10, [ { id: NeedId.HUNGER, effect:function(world:World):Void {
			var item:FoodItem = foods.randomElement();
			
			Terminal.echo("You " + Strings.walkingAdjective.randomElement() + " to the fridge and grab the first thing you see... It's a " + item.name + ". " + item.descriptions.randomElement() + ". You " + Strings.eatingDescription.randomElement() + ".");
			
			item.effects(world.agent.brain);
		} } ]));
	}
}

class Bed extends Location {
	public inline function new(world:World) {
		super("Bed", "The old bed");
		
		actions.push(new TriggerAction(ActionId.SLEEP, [ "sleep" ], 40, [ { id: NeedId.TIREDNESS, effect:function(world:World):Void {
			Terminal.echo("You settle down for forty winks.");
			
			var rest = Math.random() * 0.5 + 0.3;
			world.agent.brain.needs[NeedId.TIREDNESS].value -= rest;
		} } ]));
	}
}

class Shower extends Location {
	public inline function new(world:World) {
		super("Shower", "The shower.");
		
		actions.push(new TriggerAction(ActionId.SHOWER, [ "shower" ], 15, [ { id: NeedId.HYGIENE, effect:function(world:World):Void {
			Terminal.echo(Strings.showeringDescription.randomElement());
			
			var clean = 0.4 + Math.random() * 0.5;
			
			world.agent.brain.needs[NeedId.HYGIENE].value -= clean;
		} } ]));
	}
}

class Toilet extends Location {
	public inline function new(world:World) {
		super("Toilet", "The toilet.");
		
		actions.push(new TriggerAction(ActionId.TOILET, [ "toilet" ], 5, [ { id: NeedId.BLADDER, effect:function(world:World):Void {
			Terminal.echo("You relieve yourself.");
			
			world.agent.brain.needs[NeedId.BLADDER].value -= 1.0;
		} } ]));
	}
}