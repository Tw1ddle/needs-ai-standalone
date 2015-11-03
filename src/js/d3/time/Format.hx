package js.d3.time;

/**
 * ...
 * @author Mike Almond - https://github.com/mikedotalmond
 */

 @:native("d3.time.format")
extern class Format {
	
	public function format(?specifier:String):Format;
	
	@:overload(function(date:Date):Format{})
	public function utc(template:String):Format;
	
	@:overload(function(date:Date):Dynamic{})
	public function iso(template:String):Format;
	
	public function parse(data:String):Date;	
}