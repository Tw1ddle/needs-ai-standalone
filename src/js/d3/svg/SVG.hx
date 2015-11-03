package js.d3.svg;
import js.d3.time.Format;

/**
 * ...
 * @author Mike Almond - https://github.com/mikedotalmond
 */

 
@:native("d3.svg")
extern class SVG {
	
	@:overload(function():Dynamic->?Int->Line{})
	public function line():Line;
	
	@:overload(function():Dynamic->?Int->Area{})
	public function area():Area;
	
	@:overload(function():Dynamic->?Int->Arc{})
	public function arc():Arc;
	
	@:overload(function():Dynamic->?Int->Symbol{})
	public function symbol():Symbol;
	
	@:overload(function():Dynamic->?Int->Chord{})
	public function chord():Chord;	
	
	@:overload(function():Dynamic->?Int->Diagonal{})
	public function diagonal():Diagonal;

	@:overload(function():Dynamic->?Int->Axis{})
	public function axis():Axis;
	
	@:overload(function():Dynamic->?Int->Brush{})
	public function brush():Brush;
}

extern class Line { 
	
	public function x(?x:Dynamic):Line;
	public function y(?x:Dynamic):Line;
	public function interpolate(?interpolate:Dynamic):Line;
	public function tension(?tension:Dynamic):Line;
	
	@:overload(function():Dynamic{})
	public function defined(defined:Dynamic):Line;
	
	@:overload(function():Dynamic{})
	public function radius(radius:Dynamic):Line;
	
	@:overload(function():Dynamic{})
	public function angle(angle:Dynamic):Line;
} 

extern class Area {
	
	public function x(?x:Dynamic):Area;
	public function x0(?x:Dynamic):Area;
	public function x1(?x:Dynamic):Area;
	public function y(?y:Dynamic):Area;
	public function y0(?y:Dynamic):Area;
	public function y1(?y:Dynamic):Area;
	
	public function interpolate(?interpolate:String):Area;
	public function tension(?tension:Dynamic):Area;
	
	@:overload(function():Dynamic{})
	public function defined(defined:Dynamic):Area;
	
	@:overload(function():Dynamic{})
	public function radius(radius:Dynamic):Line;
	
	@:overload(function():Dynamic{})
	public function innerRadius(radius:Dynamic):Line;
	
	@:overload(function():Dynamic{})
	public function angle(angle:Dynamic):Line;
	
	@:overload(function():Dynamic{})
	public function startAngle(angle:Dynamic):Line;
	
	@:overload(function():Dynamic{})
	public function endAngle(angle:Dynamic):Line;
}

extern class Arc {

	@:overload(function():Dynamic{})
	public function innerRadius(?radius:Dynamic):Arc;
	
	@:overload(function():Dynamic{})
	public function outerRadius(?radius:Dynamic):Arc;
	
	@:overload(function():Dynamic{})
	public function startAngle(angle:Dynamic):Arc;
	
	@:overload(function():Dynamic{})
	public function endAngle(angle:Dynamic):Arc;
	
	public function centroid(datum:Dynamic, index:Int):Dynamic;
}

extern class Symbol {
	@:overload(function():Dynamic{})
	public function type(type:String):Symbol;
	
	@:overload(function():Dynamic{})
	@:overload(function(fn:Dynamic):Symbol{})
	public function size(size:Int):Symbol;
}

extern class Chord {
	@:overload(function():Dynamic{})
	public function source(datum:Dynamic):Chord;
	
	@:overload(function():Dynamic{})
	public function target(target:Dynamic):Chord;
	
	@:overload(function():Dynamic{})
	public function radius(radius:Dynamic):Chord;
	
	@:overload(function():Dynamic{})
	public function startAngle(angle:Dynamic):Chord;
	
	@:overload(function():Dynamic{})
	public function endAngle(angle:Dynamic):Chord;
}

extern class Diagonal {
	
	@:overload(function():Dynamic{})
	public function source(datum:Dynamic):Diagonal;
	
	@:overload(function():Dynamic{})
	public function target(target:Dynamic):Diagonal;
	
	@:overload(function():Dynamic{})
	public function projection(projection:Dynamic):Diagonal;
	
} 

extern class Axis {
	@:overload(function():Dynamic{})
	public function scale(s:Dynamic):Axis;
	
	@:overload(function():Dynamic{})
	@:overload(function(ticks:Int):Axis{})
	public function ticks(fb:Dynamic, i:Int):Axis;
	
	@:overload(function():Dynamic{})
	public function tickValues(?values:Array<Int>):Axis;
	
	@:overload(function():Dynamic{})
	public function tickSubdivide(?n:Int):Axis;
	
	@:overload(function(major:Int, ?minor:Int, ?end:Int):Axis{})
	public function tickSize():Dynamic;
	
	@:overload(function(padding:Int):Axis{})
	public function tickPadding():Int;
	
	@:overload(function(format:Format):Axis{})
	public function tickFormat():Format;
	
	public function orient(value:String):Axis;
}
	
extern class Brush {

	@:overload(function():Dynamic{})
	public function x(scale:Dynamic):Brush;
	
	@:overload(function():Dynamic{})
	public function y(scale:Dynamic):Brush;
	
	@:overload(function():Dynamic{})
	public function extent(values:Array<Float>):Brush;
	
	public function clear():Brush;
	public function empty():Bool;
	
	public function on(type:String, ?cb:Dynamic):Brush;
	
}