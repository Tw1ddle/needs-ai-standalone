package;

// Unique ids for actions that address needs
@:enum abstract ActionId(Int) from Int to Int {
	var COMPUTER = 0;
	var SLEEP = 1;
	var EAT = 2;
	var SHOWER = 3;
	var TOILET = 4;
}