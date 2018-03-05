package;

import Needs.Effect;

// Extended action class that takes a set of trigger words that the game uses to decide whether a player command triggers an action
class TriggerAction extends Needs {
	public var trigger(default, null):Array<String>;
	
	public function new(id:Int, trigger:Array<String>, duration:Float, effects:Array<Effect>) {
		super(id, duration, effects);
		this.trigger = trigger;
	}
}