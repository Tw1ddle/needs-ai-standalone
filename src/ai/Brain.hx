package ai;

import haxe.ds.IntMap;

// Represents an AI
class Brain {
	public var world:Dynamic;
	public var needs:Array<Need>; // Reasons for doing stuff
	public var needTraits:IntMap<Float->Float>; // Motive traits affect the way some motives change over time e.g. slobs get hungrier faster
	public var experienceTraits:IntMap<Float->Float>; // Experience traits affect the way some experiences are calculated e.g. override or modify effects
	public var experiences:Array<Action>; // Things the AI experienced since the last time it thought
	
	public var autonomous:Bool; // Whether to use the AI
	
	public inline function new(world:Dynamic, needs:Array<Need>) {
		this.world = world;
		this.needs = needs;
		needTraits = new IntMap<Float->Float>();
		experiences = new Array<Action>();
		
		autonomous = true;
	}
	
	public function act():Void {
		for (action in experiences) {
			for (effect in action.effects) {
				effect.effect(world);
				needs[effect.id].update(action.duration);
			}
		}
		experiences = new Array<Action>();
	}
	
	public function step(dt:Float):Void {
		for (motive in needs) {
			motive.update(dt);
		}
		
		// TODO if autonomous then do something
		// TODO create probability distribution, or always choose best option, or maybe use min/max triggers
	}
}