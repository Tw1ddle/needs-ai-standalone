package;

import ai.Action;
import ai.Brain;
import ai.Need;
import haxe.ds.GenericStack;
import js.Browser;
import js.flipclock.FlipClock;
import Locations;
import Ids;

@:enum abstract Strategy(String) from String to String {
	var HIGHEST_NEEDS = "highest_needs";
	var TRUE_RANDOM = "true_random";
	var WEIGHTED_RANDOM = "weighted_random";
	var DISABLED = "disabled";
}

// Models an agent, a brain and a means of performing actions
class Agent {
	public var brain(default, null):Brain;
	public var aiMode:Strategy;
	
	public function new(brain:Brain) {
		this.brain = brain;
		this.aiMode = Strategy.HIGHEST_NEEDS;
	}
	
	public function act(action:Action):Void {
		brain.act(action);
	}
	
	public function update(dt:Float):Void {
		brain.update(dt);
	}
}

// The game world
class World {
	public var clock:FlipClock; // The onscreen clock that delivers the time
	public var minutes(default, set):Float; // Game minutes passed
	public var gameover:Bool;
	
	public var context:GenericStack<Location>; // The locations the agent is in
	public var agent:Agent; // The player agent
	
	public inline function new() {
		clock = new FlipClock(Browser.document.getElementById("time"));
		clock.stop();
		minutes = 0;
		gameover = false;
		
		context = new GenericStack<Location>();
		context.add(new Desk(this));
		context.add(new Bed(this));
		context.add(new Fridge(this));
		context.add(new Shower(this));
		context.add(new Toilet(this));
		
		var needs = new Array<Need>();
		needs.push(new Need(NeedId.LULZ, 0.20, 0.03, 1.0, "Boredom"));
		needs.push(new Need(NeedId.TIREDNESS, 0.07, 0.01, 1.0, "Tiredness"));
		needs.push(new Need(NeedId.HUNGER, 0.25, 0.04, 1.0, "Hunger"));
		needs.push(new Need(NeedId.HYGIENE, 0.10, 0.02, 1.0, "Hygiene"));
		needs.push(new Need(NeedId.BLADDER, 0.30, 0.03, 1.0, "Bladder"));
		agent = new Agent(new Brain(this, needs));
	}
	
	public function update(dt:Float):Void {
		agent.update(dt);
		
		for (need in agent.brain.needs) {
			if (need.value >= 1.0) {
				gameover = true;
			}
		}
	}
	
	/*
	 * Sets the onscreen clock to reflect the number of game minutes passed
	 */
	public function set_minutes(min:Float):Float {
		if(clock != null) {
			clock.setTime(min * 60);
		}
		return this.minutes = min;
	}
	
	/*
	 * Gets an array of all the actions available to an agent within its current context
	 */
	public function queryContextForActions(need:Need):Array<Action> {
		var actions = new Array<Action>();
		for (location in context) {
			for (action in location.actions) {
				var addedAction:Bool = false;
				for (effect in action.effects) {
					if (need.id == effect.id) {
						actions.push(action);
						break;
					}
				}
			}
		}
		return actions;
	}
}