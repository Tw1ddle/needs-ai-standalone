package;

// Unique ids for needs
@:enum abstract NeedId(Int) from Int to Int {
	var LULZ = 0;
	var TIREDNESS = 1;
	var HUNGER = 2;
	var HYGIENE = 3;
	var BLADDER = 4;
}

// Unique ids for actions that address needs
@:enum abstract ActionId(Int) from Int to Int {
	var COMPUTER = 0;
	var SLEEP = 1;
	var EAT = 2;
	var SHOWER = 3;
	var TOILET = 4;
}