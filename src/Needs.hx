package;

import haxe.ds.IntMap;

// Extension methods for Arrays
class ArrayExtensions {
	inline public static function randomElement<T>(array:Array<T>):Null<T> {
		return array[Std.random(array.length)];
	}
}

class Needs {
	public var id(default, null):Int;
	public var duration(default, null):Float;
	public var effects(default, null):Array<Effect>;
	
	public function new(id:Int, duration:Float, effects:Array<Effect>) {
		this.id = id;
		this.duration = duration;
		this.effects = effects;
	}
}

// Models an agent, a brain and a means of performing actions
class Agent {
	public var brain(default, null):Brain;
	public var aiMode:Strategy;
	
	public function new(brain:Brain) {
		this.brain = brain;
		this.aiMode = Strategy.HIGHEST_NEEDS;
	}
	
	public function act(action:Needs):Void {
		brain.act(action);
	}
	
	public function update(dt:Float):Void {
		brain.update(dt);
	}
}

// Represents an AI
class Brain {
	public var world(default, null):Dynamic;
	public var needs(default, null):Array<Need>; // Reasons for doing stuff
	public var needTraits(default, null):IntMap<Float->Float>; // Motive traits affect the way some motives change over time e.g. slobs get hungrier faster
	public var actionTraits(default, null):IntMap<Float->Float>; // Action traits affect the way actions are calculated e.g. override or modify effects
	
	public var onActionSelected:Needs->Void = null;
	
	public inline function new(world:Dynamic, needs:Array<Need>) {
		this.world = world;
		this.needs = needs;
		needTraits = new IntMap<Float->Float>();
		actionTraits = new IntMap<Float->Float>();
	}
	
	public function act(action:Needs):Void {
		for (effect in action.effects) {
			effect.effect(world);
		}
	}
	
	public function update(dt:Float):Void {
		for (need in needs) {
			need.update(dt);
		}
		
		var aiMode:String = world.agent.aiMode;
		var need = switch(aiMode) {
			case Strategy.HIGHEST_NEEDS:
				getGreatestNeed();
			case Strategy.TRUE_RANDOM:
				getRandomNeed();
			case Strategy.WEIGHTED_RANDOM:
				getWeightedRandomNeed();
			default:
				null;
		}
		
		if (need != null) {
			var actions = findActions(need);
			
			if(onActionSelected != null) {
				onActionSelected(ArrayExtensions.randomElement(actions));
			}
		}
	}
	
	private inline function getGreatestNeed():Need {
		var idx:Int = 0;
		var value:Float = 0;
		for (i in 0...needs.length) {
			if (needs[i].value > value) {
				value = needs[idx].value;
				idx = i;
			}
		}
		return needs[idx];
	}
	
	private inline function getWeightedRandomNeed():Need {
		return needs[0];
	}
	
	private inline function getRandomNeed():Need {
		return ArrayExtensions.randomElement(needs);
	}
	
	private inline function findActions(need:Need):Array<Needs> {
		return world.queryContextForActions(need);
	}
}

typedef Effect = {
	var id:Int;
	var effect:Dynamic->Void; // Effect accepts data that it acts on the game world
}

// Needs are measures of the strength of the motive to react to problems
// Like Sims "commodities", they express a class of need e.g. to be in the gym, to not go hungry
class Need {
	public var id(default, null):Int;
	public var value(default, set):Float;
	public var growthRate(default, null):Float;
	public var growthModifier(default, null):Float;
	public var tag(default, null):String;
	public var growthCurve(default, null):Float->Float;
	
	public function new(id:Int, initialValue:Float, growthRate:Float = 0.01, growthModifier:Float = 1.0, growthCurve:Float->Float = null, tag:String = "Unnamed Motive") {
		this.id = id;
		this.value = initialValue;
		this.growthRate = growthRate;
		this.growthModifier = growthModifier;
		this.tag = tag;
		if(growthCurve != null) {
			this.growthCurve = growthCurve;
		} else {
			this.growthCurve = linear;
		}
	}
	
	public function update(dt:Float):Void {
		value += growthCurve(dt * growthRate * growthModifier);
	}
	
	private function set_value(v:Float):Float {
		return this.value = (v < 0 ? 0 : v > 1 ? 1 : v);
	}
	
	private inline function linear(v:Float):Float {
		return v;
	}
}

// TODO the strategy is about how we pick which need to address next right?

@:enum abstract Strategy(String) from String to String {
	var HIGHEST_NEEDS = "highest_needs";
	var TRUE_RANDOM = "true_random";
	var WEIGHTED_RANDOM = "weighted_random";
	var DISABLED = "disabled";
}