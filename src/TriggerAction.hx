package;

import needs.ai.Action;
import needs.ai.Effect;

// Extended action class that takes a set of trigger words that the game uses to decide whether a player command triggers an action
class TriggerAction extends Action {
	public var trigger(default, null):Array<String>;
	
	public function new(id:Int, trigger:Array<String>, duration:Float, effects:Array<Effect>) {
		super(id, duration, effects);
		this.trigger = trigger;
	}
}