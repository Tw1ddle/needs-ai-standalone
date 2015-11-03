package js.d3.color;

/**
 * ...
 * @author Mike Almond - https://github.com/mikedotalmond
 */

@:native("d3.hsl")
extern class HSL {
	public static function brighter(?k:Float):RGB;
	public static function darker(?k:Float):RGB;
	public static function rgb():RGB;
	public static function toString():String;
}