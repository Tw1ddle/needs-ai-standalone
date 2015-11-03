package js.d3.time;

import js.d3.time.Format;
import js.d3.time.Scale;

/**
 * ...
 * @author Mike Almond - https://github.com/mikedotalmond
 */

@:native("d3.time")
extern class Time {
	public var scale:Scale;
	public var format:Format;
}