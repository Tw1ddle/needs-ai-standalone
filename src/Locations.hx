package;

import Main;
import js.jquery.terminal.Terminal;

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