package js.d3.scale;

/**
 * ...
 * @author Mike Almond - https://github.com/mikedotalmond
 */

 
@:native("d3.scale")
extern class Scale {
	public function linear():Linear;
	public function identity():Identity;
	public function sqrt():Power;
	public function power():Power;
	public function log():Log;
	public function quantize():Quantize;
	public function quantile():Quantile;
	public function ordinal():Ordinal;
	
	public function category10():Ordinal;
	public function category20():Ordinal;
	public function category20b():Ordinal;
	public function category20c():Ordinal;
}

extern class Linear {
	public function invert(y:Dynamic):Dynamic;
	public function domain(?numbers:Array<Float>):Linear;
	public function range(?values:Array<Dynamic>):Linear;
	public function rangeRound(values:Array<Dynamic>):Linear;
	public function interpolate(?factory:Array<Dynamic>):Linear;
	public function clamp(?boolean:Array<Bool>):Linear;
	public function nice():Linear;
	public function ticks(count:Int):Int;
	public function tickFormat(count:Int):Dynamic;
	public function copy():Linear;
}

extern class Identity {
	public function invert(x:Dynamic):Dynamic;
	public function domain(?numbers:Array<Float>):Identity;
	public function range(?values:Array<Dynamic>):Identity;
	public function ticks(count:Int):Int;
	public function tickFormat(count:Int):Dynamic;
	public function copy():Identity;
}

extern class Power {
	public function invert(y:Dynamic):Dynamic;
	public function domain(?numbers:Array<Float>):Power;
	public function range(?values:Array<Dynamic>):Power;
	public function rangeRound(values:Array<Dynamic>):Power;
	public function exponent(?k:Float):Float;
	public function interpolate(?interpolator:Array<Dynamic>):Dynamic;
	public function clamp(?boolean:Array<Bool>):Dynamic;
	public function nice():Power;
	public function ticks(count:Int):Int;
	public function tickFormat(count:Int):Dynamic;
	public function copy():Power;
}

extern class Log {
	public function invert(y:Dynamic):Dynamic;
	public function domain(?numbers:Array<Float>):Log;
	public function range(?values:Array<Dynamic>):Log;
	public function rangeRound(values:Array<Dynamic>):Log;
	public function interpolate(?interpolator:Array<Dynamic>):Dynamic;
	public function clamp(?boolean:Array<Bool>):Dynamic;
	public function nice():Log;
	public function ticks(count:Int):Int;
	public function tickFormat(count:Int, ?format:Dynamic):Dynamic;
	public function copy():Log;
}

extern class Quantize {
	public function domain(?numbers:Array<Float>):Quantize;
	public function range(?values:Array<Dynamic>):Quantize;
	public function copy():Quantize;
}

extern class Quantile {
	public function domain(?numbers:Array<Float>):Quantile;
	public function range(?values:Array<Dynamic>):Quantile;
	public function quantiles():Array<Dynamic>;
	public function copy():Quantile;
}

extern class Ordinal {
	
	public function domain(?numbers:Array<Float>):Ordinal;
	public function range(?values:Array<Dynamic>):Ordinal;
	
	public function rangePoints(interval:Array<Float>, ?padding:Float):Ordinal;
	public function rangeBands(interval:Array<Float>, ?padding:Float):Ordinal;
	public function rangeRoundBands(interval:Array<Float>, ?padding:Float):Ordinal;
	public function rangeBand():Float;
	public function rangeExtent():Array<Float>;
	
	public function copy():Ordinal;
}