package js.flipclock;

import js.Browser;

@:native("FlipClock.Factory")
extern class FlipClock {
	public function new(element:Dynamic, options:Dynamic);
	
	public var autoStart:Bool;
	public var countdown:Bool;
	public var clockFace:String;
	public var defaultClockFace:String;
	public var defaultLanguage:String;
	
	public function start():Void;
	public function stop():Void;
	public function setTime(time:Float):Void;
	public function setCountdown(up:Bool):Void;
	public function getTime():Dynamic;
}