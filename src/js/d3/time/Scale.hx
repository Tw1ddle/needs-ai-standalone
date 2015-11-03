package js.d3.time;

/**
 * ...
 * @author Mike Almond - https://github.com/mikedotalmond
 */

@:native("d3.time.scale")
extern class Scale {
	
	public function utc():Scale;
	public function invert(y:Array<Dynamic>):Date;
	public function domain(?dates:Array<Date>):Date;
	public function range(?values:Array<Dynamic>):Scale;
	public function rangeRound(?values:Array<Dynamic>):Scale;
	public function interpolate(?factory:Array<Dynamic>):Scale;
	public function clamp(?boolean:Array<Bool>):Scale;
	public function ticks(count:Int, ?step:Float):Array<Date>;
	public function tickFormat(count:Int):Format;
	public function copy():Scale;
	
}