package ai;

using util.FloatExtensions;

// Needs are measures of the strength of the motive to react to problems
// Like Sims "commodities", they express a class of need e.g. to be in the gym, to not go hungry
class Need {
	public var id:Int;
	public var value(default, set):Float;
	public var growthRate:Float;
	public var modifier:Float;
	public var tag:String;
	public var growthCurve:Float->Float;
	
	public function new(id:Int, initialValue:Float, growthRate:Float = 0.01, drainModifier:Float = 1.0, growthCurve:Float->Float = null, tag:String = "Unnamed Motive") {
		this.id = id;
		this.value = initialValue;
		this.growthRate = growthRate;
		this.modifier = drainModifier;
		this.tag = tag;
		
		if(growthCurve != null) {
			this.growthCurve = growthCurve;
		} else {
			this.growthCurve = function(v:Float):Float {
				return v;
			}
		}
	}
	
	public function update(dt:Float):Void {
		value += growthCurve(dt * growthRate * modifier);
	}
	
	private function set_value(v:Float):Float {
		return this.value = v.clamp(0, 1);
	}
}