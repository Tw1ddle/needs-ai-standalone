package;

import js.d3.D3;
import js.d3.scale.Scale.Linear;
import js.d3.selection.Selection;
import js.d3.svg.SVG.Axis;
import js.d3.svg.SVG.Line;

import Needs.Need;

using StringTools;

typedef TimeData = {
	var time:Float;
	var value:Float;
}

// A d3.js graph of a need changing over time
class NeedGraph {
	private var data:Array<TimeData>; // The data being graphed
	private var title:String; // Graph title
	private var width:Int; // Width not counting margins
	private var height:Int; // Height not counting margins
	private var minY:Int = 0; // Minimum value on y-axis
	private var maxY:Int = 1; // Maximum value on y-axis
	private var x:Linear;
	private var y:Linear;
	private var xAxis:Axis;
	private var yAxis:Axis;
	private var elementId:String; // Id of the HTML element that the graph will be appended to
	private var svg:Selection;
	private var line:Line;
	private var graphId:String; // Id of the graph SVG element itself
	
	public function new(need:Need, data:Array<TimeData>, elementId:String, width:Int, height:Int) {
		this.data = data;
		this.title = need.tag;
		this.elementId = elementId;
		this.graphId = elementId.replace("#", "") + "_" + Std.string(need.id);
		
		var margin = { top: 20, right: 20, bottom: 30, left: 50 };
		this.width = width - margin.left - margin.right;
		this.height = height - margin.top - margin.bottom;
		
		// Ranges
		x = D3.scale.linear().range([0, width]);
		y = D3.scale.linear().range([height, 0]);
		
		x.domain(D3.extent(data, function(d:TimeData):Float { return d.time; }));
		y.domain([minY, maxY]);
		
		// Axes
		xAxis = D3.svg.axis().scale(x).orient("bottom").ticks(4);
		yAxis = D3.svg.axis().scale(y).orient("left").ticks(4);
		
		// The line
		line = D3.svg.line().x(function(d:TimeData) { return untyped x(d.time); } ).y(function(d:TimeData) { return untyped y(d.value); } );
		
		// The canvas
		svg = D3.select(elementId).append("svg").attr("class", graphId).attr("width", width + margin.left + margin.right).attr("height", height + margin.top + margin.bottom).append("g").attr("transform", "translate(" + margin.left + "," + margin.top + ")");
		
		svg.append("g").attr("class", "xaxis").attr("transform", "translate(0," + height + ")").call(xAxis);
		svg.append("g").attr("class", "yaxis").call(yAxis);
		//svg.append("g").attr("class", "axis").append("text").attr("class", "axis-label").attr("transform", "rotate(-90)").attr("y", -margin.left + 10).attr("x", -height / 2 - margin.top).text(need.tag);
		svg.append("g").attr("class", "title").append("text").attr("x", width / 2).attr("y", -margin.top / 2).attr("text-anchor", "middle").text(need.tag);
		svg.append("path").datum(data).attr("class", "line").attr("d", line);
	}
	
	public function updateData(minutes:Float):Void {
		x.domain([0, minutes]);
		
		line = D3.svg.line().x(function(d:TimeData) { return untyped x(d.time); } ).y(function(d:TimeData) { return untyped y(d.value); } );
		
		var sel = D3.select("." + graphId).transition();
		
		sel.select(".line").attr("d", line);
		sel.select(".xaxis").call(xAxis);
		sel.select(".yaxis").call(yAxis);
	}
	
	public function addData(d:TimeData, worldMinutes:Float):Void {
		data.push(d);
		updateData(worldMinutes);
	}
}