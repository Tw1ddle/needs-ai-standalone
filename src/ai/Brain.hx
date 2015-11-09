package ai;

import haxe.ds.IntMap;

// Represents an AI
class Brain {
	public var world(default, null):Dynamic;
	public var needs(default, null):Array<Need>; // Reasons for doing stuff
	public var needTraits(default, null):IntMap<Float->Float>; // Motive traits affect the way some motives change over time e.g. slobs get hungrier faster
	public var actionTraits(default, null):IntMap<Float->Float>; // Action traits affect the way actions are calculated e.g. override or modify effects
	
	public inline function new(world:Dynamic, needs:Array<Need>) {
		this.world = world;
		this.needs = needs;
		needTraits = new IntMap<Float->Float>();
	}
	
	public function act(action:Action):Void {		
		for (effect in action.effects) {
			effect.effect(world);
			needs[effect.id].update(action.duration);
		}
	}
	
	public function update(dt:Float):Void {
		for (motive in needs) {
			motive.update(dt);
		}
		
		// TODO if autonomous then do something
		// TODO create probability distribution, or always choose best option, or maybe use min/max triggers
	}
}