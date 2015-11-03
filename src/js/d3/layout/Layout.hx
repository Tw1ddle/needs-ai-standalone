package js.d3.layout;

/**
 * ...
 * @author Mike Almond - https://github.com/mikedotalmond
 */

@:native("d3.layout")
extern class Layout {
	/*https://github.com/mbostock/d3/wiki/Layouts*/
	
	@:overload(function(links:Array<Dynamic>):Dynamic{})
	public function bundle():Dynamic;

	public function chord():Chord;
	public function cluster():Cluster;
	public function force():Force;
	public function hierarchy():Hierarchy;
	
	@:overload(function():Array<Dynamic>->Int->Histogram{})
	@:overload(function():Array<Dynamic>->Histogram{})
	@:overload(function():Histogram{})
	public function histogram():Dynamic;
	
	public function pack():Pack;
	public function partition():Partition;
	
	@:overload(function():Array<Dynamic>->Int->Array<Dynamic>{})
	@:overload(function():Array<Dynamic>->Array<Dynamic>{})
	public function pie():Pie;
	
	@:overload(function():Array<Dynamic>->Int->Stack{})
	@:overload(function():Array<Dynamic>->Stack{})
	public function stack():Stack;
	
	public function tree():Tree;
	public function treemap():Treemap;
}


@:native("d3.layout.chord")
extern class Chord implements ArrayAccess<Dynamic>{
	/*https://github.com/mbostock/d3/wiki/Chord-Layout*/
	@:overload(function():Array<Int>{})
	public function matrix(matrix:Array<Int>):Chord;
	
	@:overload(function():Float{})
	public function padding(value:Float):Chord;
	
	@:overload(function():Dynamic{})
	public function sortGroups(comparator:Dynamic->Dynamic->Int):Chord;	
	
	@:overload(function():Dynamic{})
	public function sortSubgroups(comparator:Dynamic->Dynamic->Int):Chord;
	
	@:overload(function():Dynamic{})
	public function sortChords(comparator:Dynamic->Dynamic->Int):Chord;
	
	public function chords():Dynamic;
	public function groups():Dynamic;
}

@:native("d3.layout.force")
extern class Force implements ArrayAccess<Dynamic> {
	/*https://github.com/mbostock/d3/wiki/Force-Layout*/
	
	@:overload(function():Array<Int>{})
	public function size(size:Array<Int>):Force;	
	
	@:overload(function():Float{})	
	@:overload(function(distance:Dynamic->Float):Force{})
	@:overload(function(distance:Void->Float):Force{})
	public function linkDistance(distance:Float):Force;	
	
	@:overload(function():Float{})
	@:overload(function(strength:Dynamic->Float):Force{})
	@:overload(function(strength:Void->Float):Force{})
	public function linkStrength(strength:Float):Force;	
	
	@:overload(function():Float{})	
	public function friction(friction:Float):Force;	
	
	@:overload(function():Float{})	
	public function charge(charge:Float):Force;	
	
	@:overload(function():Float{})	
	public function theta(theta:Float):Force;
	
	@:overload(function():Float{})	
	public function gravity(gravity:Float):Force;
	
	@:overload(function():Array<Dynamic>{})	
	public function nodes(nodes:Array<Dynamic>):Force;
	
	@:overload(function():Array<Dynamic>{})	
	public function links(nodes:Array<Dynamic>):Force;
	
	@:overload(function():Float{})	
	public function alpha(value:Float):Force;
	
	public function on(type:String, listener:Dynamic):Force;
	
	public function drag():Void;
	public function start():Void;
	public function stop():Void;
	public function resume():Void;
	public function tick():Void;
}

@:native("d3.layout.pie")
extern class Pie implements ArrayAccess<Dynamic> {
	
	/*https://github.com/mbostock/d3/wiki/Pie-Layout*/
	@:overload(function():Dynamic{})	
	public function value(value:Dynamic):Pie;
	
	@:overload(function():Dynamic{})
	public function sort(comparator:Dynamic->Dynamic->Int):Pie;
	
	@:overload(function():Float{})	
	@:overload(function():Dynamic->Int->Float{})	
	@:overload(function(value:Dynamic->Int->Float):Pie{})	
	public function startAngle(value:Float):Pie;
	
	@:overload(function():Float{})	
	@:overload(function():Dynamic->Int->Float{})	
	@:overload(function(value:Dynamic->Int->Float):Pie{})	
	public function endAngle(value:Float):Pie;
	
}

@:native("d3.layout.stack")
extern class Stack implements ArrayAccess<Dynamic> {
	/*https://github.com/mbostock/d3/wiki/Stack-Layout*/
	
	@:overload(function():Dynamic{})
	public function values(accessor:Dynamic):Stack;
	
	@:overload(function():Dynamic{})
	@:overload(function(offset:Dynamic):Stack{})
	public function offset(offset:String):Stack;
	
	@:overload(function():Dynamic{})
	@:overload(function(order:Dynamic):Stack{})
	public function order(order:String):Stack;
	
	@:overload(function():Dynamic{})
	public function x(accessor:Dynamic->Int->Float):Stack;
	
	@:overload(function():Dynamic{})
	public function y(accessor:Dynamic->Int->Float):Stack;
	
	@:overload(function():Dynamic->Float->Float->Void{})
	public function out(setter:Dynamic->Float->Float->Void):Stack;	
}

@:native("d3.layout.histogram")
extern class Histogram implements ArrayAccess<Dynamic>{
	/*https://github.com/mbostock/d3/wiki/Histogram-Layout*/
	
	@:overload(function():Dynamic{})
	public function value(accessor:Dynamic):Histogram;
	
	@:overload(function():Void->Array<Float>{})
	@:overload(function(range:Void->Array<Float>):Histogram{})
	public function range(range:Dynamic):Histogram;
	
	@:overload(function():Dynamic{})
	@:overload(function(bins:Dynamic):Histogram{})
	@:overload(function(bins:Array<Float>):Histogram{})
	public function bins(bins:Float):Histogram;
	
	@:overload(function():Bool{})
	public function frequency(frequency:Bool):Histogram;
	
}

@:native("d3.layout.hierarchy")
extern class Hierarchy implements ArrayAccess<Dynamic> {
	/*https://github.com/mbostock/d3/wiki/Hierarchy-Layout*/
	
	@:overload(function():Dynamic{})
	public function sort(comparator:Dynamic->Dynamic->Int):Hierarchy;
	
	@:overload(function():Array<Int>{})
	public function size(size:Array<Int>):Hierarchy;	
	
	@:overload(function():Dynamic{})
	public function children(accessor:Dynamic):Hierarchy;	
	
	public function nodes(root:Dynamic):Hierarchy;
	
	public function links(nodes:Array<Dynamic>):Hierarchy;
	
	@:overload(function():Dynamic{})	
	public function value(value:Dynamic):Hierarchy;
	
	public function revalue(root:Dynamic):Hierarchy;
}

@:native("d3.layout.cluster")
extern class Cluster extends Hierarchy {
	/*https://github.com/mbostock/d3/wiki/Cluster-Layout*/
	@:overload(function():Dynamic->Dynamic->Float{})
	public function separation(separation:Dynamic->Dynamic->Float):Cluster;	
}

@:native("d3.layout.pack")
extern class Pack extends Hierarchy {
	/*https://github.com/mbostock/d3/wiki/Pack-Layout*/
}

@:native("d3.layout.partition")
extern class Partition extends Hierarchy {
	/*https://github.com/mbostock/d3/wiki/Partition-Layout*/
}

@:native("d3.layout.tree")
extern class Tree extends Hierarchy {
	@:overload(function():Dynamic->Dynamic->Float{})
	public function separation(separation:Dynamic->Dynamic->Float):Tree;
}

@:native("d3.layout.treemap")
extern class Treemap extends Hierarchy {
	/*https://github.com/mbostock/d3/wiki/Treemap-Layout*/
	
	@:overload(function():Dynamic{})
	@:overload(function(padding:Dynamic):Treemap{})
	@:overload(function(padding:Array<Float>):Treemap{})
	public function padding(padding:Float):Treemap;
	
	@:overload(function():Bool{})
	public function round(round:Bool):Treemap;
	
	@:overload(function():Bool{})
	public function sticky(sticky:Bool):Treemap;
}