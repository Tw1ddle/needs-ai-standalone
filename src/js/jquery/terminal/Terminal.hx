package js.jquery.terminal;

@:native("terminal")
extern class Terminal {
	static function clear():Void;
	static function greetings():Void;
	static function paused():Bool;
	static function pause():Void;
	static function resume():Void;
	static function cols():Int;
	static function rows():Int;
	static function next():Void;
	static function focus(toggle:Bool, silent:Bool):Void;
	static function enable():Void;
	static function disable():Void;
	static function enabled():Bool;
	static function signature():String;
	static function version():String;
	static function cmd():Dynamic;
	static function insert(s:String):Void;
	static function set_prompt(s:String):Void;
	static function get_prompt():String;
	static function get_output(raw:Bool):Void;
	static function resize(width:Int, height:Int):Void;
	static function flush():Void;
	static function echo(s:String, ?options:Dynamic):Void;
	static function error(message:String, finalize:Bool):Void;
	static function scroll(amount:Float):Void;
	static function name():String;
	static function push(interpreter:Dynamic, ?options:Dynamic):Void;
	static function pop(?name:String):Void;
	static function level():Int;
	static function purge():Void;
	static function destroy():Void;
}