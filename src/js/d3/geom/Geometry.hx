package js.d3.geom;

/**
 * limited api docs here....
 * @author Mike Almond - https://github.com/mikedotalmond
 */

@:native("d3.geom")
extern class Geometry {

	@:overload(function():Array<Polygon>{})
	public function voronoi(vertices:Array<Dynamic>):Array<Polygon>;
	
	@:overload(function():Array<Dynamic>{})
	public function delaunay(vertices:Array<Dynamic>):Array<Dynamic>;
	
	public function polygon():Polygon;
	
	public function quadtree():Quadtree;
	
	public function hull():Dynamic;
	public function contour():Dynamic;
	

}

extern class Polygon {
	public function area():Dynamic;
	public function centroid():Dynamic;
	public function clip():Dynamic;
}

extern class Quadtree {
	public function visit():Dynamic;
}