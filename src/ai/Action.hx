package ai;

// Solutions to problems
typedef ActionEffect = { 
	var id:Int; 
	var effect:Dynamic->Void; 
}

class Action {
	public var id:Int;
	public var trigger:Array<String>;
	public var duration:Float;
	public var effects:Array<ActionEffect>;
	
	public function new(id:Int, trigger:Array<String>, duration:Float, effects:Array<ActionEffect>) {
		this.id = id;
		this.trigger = trigger;
		this.duration = duration;
		this.effects = effects;
	}
}