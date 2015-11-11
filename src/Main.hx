package;

import ai.Action;
import haxe.ds.IntMap;
import js.Browser;
import js.jquery.terminal.Terminal;
import Locations;
import World;
import js.nouislider.NoUiSlider;
import js.wNumb.WNumb;
import js.html.Element;
import js.html.SelectElement;

using util.ArrayExtensions;
using util.StringExtensions;

class Main {
	private var world:World;
	private var graphs:IntMap<NeedGraph>;
	
	private var updateHandle:Null<Int>;
	private var updateInterval(never, set):Int;
	
	private var updateRateElement:Element;
	private var strategyElement:SelectElement;
	
    private static function main():Void {
		new Main();
	}
	
	private inline function new() {
		Browser.window.onload = onWindowLoaded;
	}
	
	private inline function onWindowLoaded():Void {	
		world = new World();
		createTerminal();
		generateActionButtons();
		generateSliders();
		generateGraphs();
		
		updateHandle = null;
		updateInterval = 1000;
	}
	
	/*
	 * Update loop
	 */
	private inline function update():Void {
		world.minutes += 1;
		world.update(1);
		
		for (graph in graphs) {				
			for (motive in world.agent.brain.needs) {
				var graph:NeedGraph = graphs.get(motive.id);
				graph.addData( { time: world.minutes, value: motive.value }, world.minutes );
			}
		}
		
		if (world.minutes >= 60 * 24) {
			world.gameover = true;
			world.clock.stop();
			Terminal.echo("Time's up. Better start looking for a job...");
		}
	}
	
	/*
	 * Helper method for execution a resolved player action
	 */
	private inline function handleAction(action:TriggerAction):Void {
		world.agent.act(action);
		world.minutes += action.duration;
		
		for (effect in action.effects) {
			var graph = graphs.get(effect.id);
			graph.addData( { time: world.minutes, value: world.agent.brain.needs[effect.id].value }, world.minutes );
		}
	}
	
	/*
	 * Creates the terminal
	 */
	private inline function createTerminal():Void {
		Terminal.push(function(command:String, terminal:Dynamic) {
			var recognizedCommand:Bool = false;
			for (location in world.context) {
				for (action in location.actions) {
					var containsParts:Bool = true;
					for (part in action.trigger) {
						if (!command.contains(part)) {
							containsParts = false;
							break;
						}
					}
					if (action.trigger.length != 0 && containsParts) {
						recognizedCommand = true;
						handleAction(action);
					}
				}
			}
			
			if (!recognizedCommand && command.length != 0) {
				Terminal.echo(Strings.unrecognizedCommand.randomElement());
			}			
		}, {
			greetings: false,
			name: '>'
		} );
		Terminal.echo("You have 24 hours...");
	}
	
	/*
	 * Generates a button for each available action that the player has within the current context (i.e. location)
	 */
	private inline function generateActionButtons():Void {
		var actions = Browser.document.getElementById("actions");
		while (actions.hasChildNodes()) {
			actions.removeChild(actions.lastChild);
		}
		
		for (location in world.context) {
			for (action in location.actions) {
				var triggers:String = action.trigger.toString();
				var btn = Browser.document.createElement("button");
				var t = Browser.document.createTextNode(triggers);
				btn.appendChild(t);
				actions.appendChild(btn);
				btn.onclick = function():Void {
					handleAction(action);
				};
			}
		}
	}
	
	/*
	 * Helper method to create settings sliders
	 */
	private inline function generateSliders():Void {
		updateRateElement = cast Browser.document.getElementById("clockspeed");
		
		NoUiSlider.create(updateRateElement, {
			connect: 'lower',
			start: 1,
			range: {
				'min': [0, 0.1],
				'max': 10
			},
			format: new WNumb({
				decimals: 1
			}),
			pips: {
				mode: 'range',
				density: 10,
			}
		});
		createTooltips(updateRateElement);
		untyped updateRateElement.noUiSlider.on(UiSliderEvent.CHANGE, function(values:Array<Float>, handle:Int, rawValues:Array<Float>):Void {
			set_updateInterval(Std.int(1000 / (values[handle])));
		});
		untyped updateRateElement.noUiSlider.on(UiSliderEvent.UPDATE, function(values:Array<Float>, handle:Int, rawValues:Array<Float>):Void {
			updateTooltips(updateRateElement, handle, values[handle]);
		});
	}
	
	/*
	 * Sets the currently selected AI strategy
	 */
	private inline function connectStrategySelection():Void {
		strategyElement = cast Browser.document.getElementById("strategy");
		
		strategyElement.addEventListener("change", function() {
			if (strategyElement.value != null) {
				world.agent.aiMode = strategyElement.value;
			}
		}, false);
	}
	
	/*
	 * Helper method to create tooltips on the sliders
	 */
	private function createTooltips(slider:Element):Void {
		var tipHandles = slider.getElementsByClassName("noUi-handle");
		for (i in 0...tipHandles.length) {
			var div = js.Browser.document.createElement('div');
			div.className += "tooltip";
			tipHandles[i].appendChild(div);
			updateTooltips(slider, i, 0);
		}
	}
	
	/*
	 * Helper method to update the tooltips on the sliders
	 */
	private inline function updateTooltips(slider:Element, handleIdx:Int, value:Float):Void {
		var tipHandles = slider.getElementsByClassName("noUi-handle");
		tipHandles[handleIdx].innerHTML = "<span class='tooltip'>" + Std.string(value) + "</span>";
	}
	
	/*
	 * Helper method to create the graphs that track the values of needs over time
	 */
	private inline function generateGraphs():Void {
		graphs = new IntMap<NeedGraph>();
		for (motive in world.agent.brain.needs) {
			var graph:NeedGraph = new NeedGraph(motive, [ { time: 0, value: motive.value } ], "#graphs", 150, 100);
			graphs.set(motive.id, graph);
		}
	}
	
	/*
	 * Changes the game update rate when the update interval is changed
	 */
	private function set_updateInterval(time:Int):Int {
		if (updateHandle != null) {
			Browser.window.clearInterval(updateHandle);
		}
		updateHandle = Browser.window.setInterval(update, time);
		return time;
	}
}

// Extended action class that takes a set of trigger words that the game uses to decide whether a player command triggers an action
class TriggerAction extends Action {
	public var trigger(default, null):Array<String>;
	
	public function new(id:Int, trigger:Array<String>, duration:Float, effects:Array<Effect>) {
		super(id, duration, effects);
		this.trigger = trigger;
	}
}