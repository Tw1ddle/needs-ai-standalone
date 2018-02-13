package;

import needs.ai.Action;
import needs.ai.Brain;
import needs.ai.Need;
import haxe.ds.GenericStack;
import js.Browser;
import js.flipclock.FlipClock;
import Locations;
import ActionId;
import NeedId;
import needs.ai.Agent;

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
		needs.push(new Need(NeedId.LULZ, 0.20, 0.10, 1.0, "Boredom"));
		needs.push(new Need(NeedId.TIREDNESS, 0.07, 0.04, 1.0, "Tiredness"));
		needs.push(new Need(NeedId.HUNGER, 0.25, 0.10, 1.0, "Hunger"));
		needs.push(new Need(NeedId.HYGIENE, 0.10, 0.02, 1.0, "Hygiene"));
		needs.push(new Need(NeedId.BLADDER, 0.30, 0.02, 1.0, "Bladder"));
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
	
	/*
	 * Sets the onscreen clock to reflect the number of game minutes passed
	 */
	public function set_minutes(min:Float):Float {
		if(clock != null) {
			clock.setTime(min * 60);
		}
		return this.minutes = min;
	}
}