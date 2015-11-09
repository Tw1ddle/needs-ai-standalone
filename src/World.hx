package;

import ai.Brain;
import ai.Need;
import haxe.ds.GenericStack;
import js.flipclock.FlipClock;
import Locations;
import js.Browser;

class World {
	public var context:GenericStack<Location>;
	public var actor:Brain;
	public var clock:FlipClock;
	public var livesRuined:Int;
	public var feelingsHurt:Int;
	public var minutes(default, set):Float;
	public var lastUpdateMinutes:Float;
	public var actions:Array<ActionId>;
	
	public inline function new() {		
		livesRuined = 0;
		feelingsHurt = 0;
		minutes = 0;
		lastUpdateMinutes = 0;
		
		var needs = new Array<Need>();
		needs.push(new Need(ProblemId.LULZ, 0.50, 0.03, 1.0, "Boredom"));
		needs.push(new Need(ProblemId.TIREDNESS, 0.07, 0.01, 1.0, "Tiredness"));
		needs.push(new Need(ProblemId.HUNGER, 0.5, 0.04, 1.0, "Hunger"));
		needs.push(new Need(ProblemId.HYGIENE, 0.3, 0.06, 1.0, "Hygiene"));
		needs.push(new Need(ProblemId.BLADDER, 0.5, 0.07, 1.0, "Bladder"));
		
		actor = new Brain(this, needs);
		actions = new Array<ActionId>();
		context = new GenericStack<Location>();		
		context.add(new Desk(this));
		context.add(new Bed(this));
		context.add(new Fridge(this));
		context.add(new Shower(this));
		context.add(new Toilet(this));
		
		clock = new FlipClock(Browser.document.getElementById("time"));
		clock.stop();
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