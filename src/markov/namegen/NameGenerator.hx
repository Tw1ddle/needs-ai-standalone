package markov.namegen;

using markov.util.StringExtensions;

using StringTools;

// Helper class that builds on the basic word generating Generator class
class NameGenerator extends Generator {	
	public function new(data:Array<String>, order:Int, smoothing:Float) {
		super(data, order, smoothing);
	}
	
	/*
	 * Generates a name within the given constraints
	 * Notes that this may often fail to generate a name within the constraints and return null
	 */
	public function generateName(minLength:Int, maxLength:Int, startsWith:String, endsWith:String, includes:String, excludes:String):String {		
		var name = "";
		
		name = generate();
		name = name.replace("#", "");
		if (name.length >= minLength && name.length <= maxLength && name.startsWith(startsWith) && name.endsWith(endsWith) && (includes.length == 0 || name.contains(includes)) && (excludes.length == 0 || !name.contains(excludes))) {
			return name;
		}
		
		return null;
	}
	
	/*
	 * Helper function that attempts to generate n names with the given constraints within an alotted time
	 */
	public function generateNames(n:Int, minLength:Int, maxLength:Int, startsWith:String, endsWith:String, includes:String, excludes:String, maxTimePerName:Float = 0.02):Array<String> {
		var names = new Array<String>();
		
		var startTime = Date.now().getTime();
		var currentTime = Date.now().getTime();
		
		while (names.length < n && currentTime > startTime + (maxTimePerName * n)) {
			var name = generateName(minLength, maxLength, startsWith, endsWith, includes, excludes);
			if (name != null) {
				names.push(name);
			}
			
			currentTime = Date.now().getTime();
		}
		
		return names;
	}
}