package js.d3;

import js.d3.behavior.Behaviors;
import js.d3.color.HSL;
import js.d3.color.RGB;
import js.d3.geo.Geography;
import js.d3.geom.Geometry;
import js.d3.layout.Layout;
import js.d3.math.Random;
import js.d3.math.Transform;
import js.d3.scale.Scale;
import js.d3.selection.Selection;
import js.d3.svg.SVG;
import js.d3.time.Time;
import js.d3.transition.Transition;
import js.html.Element;
import js.html.Event;


@:native("d3")
extern class D3
{
   
	/*https://github.com/mbostock/d3/wiki/Selections*/
	@:overload(function(selector:Element):Selection{})
    public static function select(selector:String):Selection;
	
    @:overload(function(selector:Array<Element>):Selection{})
    public static function selectAll(selector:String):Selection;

	/*Returns the root selection, equivalent to d3.select(document.documentElement)*/
	public static function selection():Selection;
	
	/** Stores the current event, if any. 
	 * This global is during an event listener callback registered with the on operator. 
	 * The current event is reset after the listener is notified in a finally block. 
	 * This allows the listener function to have the same form as other operator functions, being passed the current datum d and index i.
	 */
    public static var event:Event;
	
	
	/**
	 * Returns the x and y coordinates of the current d3.event, relative to the specified container. 
	 * The container may be an HTML or SVG container element, such as an svg:g or svg:svg. 
	 * The coordinates are returned as a two-element array [x, y].
	 */
    public static function mouse(container:Element):Array<Int>;
	
	
	/**
	 * Returns the x and y coordinates of each touch associated with the current d3.event, based on the touches attribute, relative to the specified container.
	 * The container may be an HTML or SVG container element, such as an svg:g or svg:svg. 
	 * The coordinates are returned as an array of two-element arrays [ [x1, y1], [x2, y2], … ].
	 */
    public static function touches(container:Element):Array<Array<Int>>;
	
	
    public static var scale		:Scale;
	public static var time		:Time;
	public static var svg		:SVG;
	public static var random	:Random;
	public static var layout	:Layout;
	public static var geo		:Geography;
	public static var geom		:Geometry;
	public static var behavior	:Behaviors;
	
	
	@:overload(function(type:String, ?a:Dynamic,?b:Dynamic,?c:Dynamic,?d:Dynamic):Float->Float{})
    public static function ease(type:String):Float->Float;
	
	
	@:overload(function(a:Dynamic, b:Dynamic):Float->Float{})
    public static function interpolate(t:Dynamic):Float->Float;
	
    public static function interpolateNumber(a:Float, b:Float):Float->Float;
    public static function interpolateRound(a:Float, b:Float):Float->Float;
    public static function interpolateString(a:String, b:String):Float->Float;
    public static function interpolateRgb(a:Dynamic, b:Dynamic):Float->Float;
    public static function interpolateHsl(a:Dynamic, b:Dynamic):Float->Float;
    public static function interpolateArray(a:Array<Dynamic>, b:Array<Dynamic>):Array<Dynamic>->Array<Dynamic>;
    public static function interpolateObject(a:Dynamic, b:Dynamic):Dynamic->Dynamic;
    public static function interpolateTransform(a:Transform, b:Transform):Transform->Transform;
   
	public static var interpolators:Array<Dynamic>;
	
	public static function transform(name:String):Transform;
	public static function transition(?selection:Selection):Transition;
	
	@:overload(function(fn:Dynamic->Bool):Void{})
    public static function timer(fn:Void->Bool):Void;
	
    /* sorting helpers */
    public static function ascending<T>(a:T, b:T):Int;
    public static function descending<T>(a:T, b:T):Int;

    /* Array/Math Extensions*/
    public static function min(arr:Array<Dynamic>,?accessor:Dynamic->Dynamic):Dynamic;
    
	@:overload(function(arr:Dynamic,?accessor:Dynamic->Dynamic):Dynamic{})
	public static function max(arr:Array<Dynamic>,?accessor:Dynamic->Dynamic):Dynamic;
   
	public static function quantile(arr:Array<Float>,p:Float):Float;
    public static function bisectLeft(arr:Array<Dynamic>,x:Dynamic, ?lo:Dynamic, ?hi:Dynamic):Int;
    public static function bisect(arr:Array<Dynamic>,x:Dynamic, ?lo:Dynamic, ?hi:Dynamic):Int;			
    public static function bisectRight(arr:Array<Dynamic>,x:Dynamic, ?lo:Dynamic, ?hi:Dynamic):Int;
    public static function first<T>(arr:Array<T>, ?comparator:T->T->Int) : T;
    public static function last<T>(arr:Array<T>, ?comparator:T->T->Int) : T;
    /* Obj Extensions */
    public static function keys(obj:Dynamic):Array<String>;
    public static function values(obj:Dynamic):Array<String>;
    public static function entries(obj:Dynamic):Array<{key:String, value:Dynamic}>;

    /* Array/Op Extensions */
    public static function split<T>(arr:Array<T>, fn:T->Bool) : Array<Array<T>>;
    public static function merge<T>(arr:Array<Array<T>>):Array<T>;
    
	@:overload(function(?start:Float, ?stop:Float, ?step:Float):Array<Float>{})
	public static function range(?start:Float, ?stop:Float, ?step:Float):Dynamic;
	
    public static function permute<T>(arr:Array<T>, indexes:Array<Int>):Array<T>;
    public static function zip(arr1:Array<Dynamic>,arr2:Array<Dynamic>, arr3:Array<Dynamic>, arr3:Array<Dynamic>, arr4:Array<Dynamic>, arr5:Array<Dynamic>, arr6:Array<Dynamic>):Array<Array<Dynamic>>;

    /* Nests... TODO: does this work? */
    public static function nest():Nest<Dynamic,Dynamic>;
	
	
	/* Loading External Resources */
	public static function json(url:String, cb:Dynamic->Void):Void;
	public static function html(url:String, cb:Dynamic->Void):Void;
	
	@:overload(function (url:String, cb:Dynamic->Void):Void{})
	public static function xml(url:String, mime:String, cb:Dynamic->Void):Void;
	
	@:overload(function (url:String, cb:Dynamic->Void):Void{})
	public static function text(url:String, mime:String, cb:Dynamic->Void):Void;
	
	@:overload(function (url:String, cb:Dynamic->Void):Void{})
	public static function xhr(url:String, mime:String, cb:Dynamic->Void):Void;
	
	public static function csv(url:String, cb:Array<Dynamic<String>>->Dynamic):Csv;
	
	
	/* String Formatting */
	@:overload(function(specifier:Dynamic):Dynamic{})
	public static function format(specifier:String):Dynamic;
	
	public static function requote(s:String):String;
	public static function round(x:Float, ?n:Int):Float;
	
	/* Colors */
	
	@:overload(function(color:String):RGB{})
	public static function rgb(r:Int, g:Int, b:Int):RGB;
	
	@:overload(function(color:String):HSL{})
	public static function hsl(h:Float, s:Float, l:Float):HSL;
	
	/* internals */
	public static function functor(value:Dynamic):Dynamic;
	public static function rebind(target:Dynamic, source:Dynamic, names:String):Dynamic;
	public static function dispatch():Dynamic;	
}


extern class Nest<A,B>{
    public function key<C>(fn:B->C):Nest<C,B>;
    public function sortKeys(fn:A->A->Int) : Nest<A,B>;
    public function sortValues(fn:B->B->Int) : Nest<A,B>;
    public function rollup<C>(fn:B->C):Nest<A,C>;
    public function map<T>(arr:Array<T>):Nest<A,T>;
    public function entries<T>(arr:Array<T>):Array<{key:A, values:Array<Dynamic>}>;
}


@fakeEnum(String) @:native("js.d3._D3.InitPriority")
extern enum Priority{ important; }

private class InitPriority{ static var important = 'important'; }