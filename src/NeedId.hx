package;

// Unique ids for needs
@:enum abstract NeedId(Int) from Int to Int {
	var LULZ = 0;
	var TIREDNESS = 1;
	var HUNGER = 2;
	var HYGIENE = 3;
	var BLADDER = 4;
}