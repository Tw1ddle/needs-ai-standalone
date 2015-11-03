package js.d3.geo;

/**
 * ...
 * @author Mike Almond - https://github.com/mikedotalmond
 */

@:native("d3.geo") 
extern class Geography {
	/*https://github.com/mbostock/d3/wiki/Geo*/
	
	@:overload(function():Dynamic->Int->Path{})
	@:overload(function():Dynamic->Path{})
	public function path():Path;
	
	// projections...
	@:overload(function():Array<Float>->Array<Float>{})
	public function mercator():Mercator;
	
	@:overload(function():Array<Float>->Array<Float>{})
	public function albers():Albers;
	
	@:overload(function():Array<Float>->Array<Float>{})
	public function albersUsa():AlbersUsa;
	
	@:overload(function():Array<Float>->Array<Float>{})
	public function azimuthal():Azimuthal;
	
}

extern class Path {
	
	@:overload(function():Dynamic{})
	public function projection(projection:Dynamic):Path;
	
	@:overload(function():Dynamic{})
	@:overload(function (radius:Dynamic):Path{})
	public function pointRadius(radius:Float):Path;
	
	public function area(feature:Dynamic):Float;
	public function centroid(feature:Dynamic):Array<Float>;
	public function bounds(feature:Dynamic):Array<Array<Float>>;
	
	@:overload(function():Dynamic->Dynamic{})
	public function greatArc():Arc;
	
	public function greatCircle():Circle;
	public function circle():Circle;
	
}

/*https://github.com/mbostock/d3/wiki/Geo-Projections*/
extern class Mercator {
	public function invert(point:Array<Float>):Array<Float>;
	
	@:overload(function():Float{})
	public function scale(scale:Float):Mercator;
	
	@:overload(function():Array<Float>{})
	public function translate(offset:Array<Float>):Mercator;	
}

extern class Albers {
	public function invert(point:Array<Float>):Array<Float>;
	
	@:overload(function():Array<Float>{})
	public function origin(origin:Array<Float>):Albers;
	
	@:overload(function():Array<Float>{})
	public function parallels(parallels:Array<Float>):Albers;
	
	@:overload(function():Float{})
	public function scale(scale:Float):Albers;
	
	@:overload(function():Array<Float>{})
	public function translate(offset:Array<Float>):Albers;
}

extern class AlbersUsa {
	@:overload(function():Float{})
	public function scale(scale:Float):AlbersUsa;
	
	@:overload(function():Array<Float>{})
	public function translate(offset:Array<Float>):AlbersUsa;
}

extern class Azimuthal {
	
	@:overload(function():String{})
	public function mode(mode:String):Azimuthal;
	
	@:overload(function():Array<Float>{})
	public function origin(origin:Array<Float>):Azimuthal;
	
	@:overload(function():Float{})
	public function scale(scale:Float):Azimuthal;
	
	@:overload(function():Array<Float>{})
	public function translate(offset:Array<Float>):Azimuthal;
	
}