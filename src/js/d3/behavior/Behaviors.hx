package js.d3.behavior;

/**
 * ...
 * @author Mike Almond - https://github.com/mikedotalmond
 */

@:native("d3.behavior")
extern class Behaviors {
	/*https://github.com/mbostock/d3/wiki/Behaviors*/
	public function drag():Drag;
	public function zoom():Zoom;
	
}

extern class Drag {
	/*https://github.com/mbostock/d3/wiki/Drag-Behavior#wiki-drag*/
	public function on(type:String, listener:Dynamic):Drag;
}

extern class Zoom {
	/*https://github.com/mbostock/d3/wiki/Zoom-Behavior*/
	public function on(type:String, listener:Dynamic):Drag;
	public function extent():Drag;
}