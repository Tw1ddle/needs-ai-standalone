package js.d3.math;

/**
 * ...
 * @author Mike Almond - https://github.com/mikedotalmond
 */
@:native("d3.random")
extern class Random {
	public function normal(?mean:Float, ?deviation:Float):Void->Float;
}