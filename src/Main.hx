package;

import ai.Action;
import haxe.ds.IntMap;
import js.Browser;
import js.jquery.terminal.Terminal;
import Locations;
import World;

using util.ArrayExtensions;
using util.StringExtensions;

class TriggerAction extends Action {
	public var trigger(default, null):Array<String>;
	
	public function new(id:Int, trigger:Array<String>, duration:Float, effects:Array<Effect>) {
		super(id, duration, effects);
		this.trigger = trigger;
	}
}

class Main {
	private var world:World;
	private var graphs:IntMap<NeedGraph>;
	private var gameover:Bool;
	
	private var updateHandle:Null<Int>;
	private var updateInterval(never, set):Int;
	
    private static function main():Void {
		new Main();
	}
	
	private inline function new() {
		Browser.window.onload = onWindowLoaded;
	}
	
	private inline function onWindowLoaded():Void {
		gameover = false;
		
		world = new World();
		generateTerminal();
		generateActionButtons();
		generateSettingsButtons();
		generateSliders();
		generateGraphs();
		
		updateHandle = null;
		updateInterval = 1000;
	}
	
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
			gameover = true;
			world.clock.stop();
			Terminal.echo("Time's up. Better start looking for a job...");
		}
	}
	
	private inline function handleAction(action:TriggerAction):Void {
		world.agent.act(action);
		world.minutes += action.duration;
		
		for (effect in action.effects) {
			var graph = graphs.get(effect.id);
			graph.addData( { time: world.minutes, value: world.agent.brain.needs[effect.id].value }, world.minutes );
		}
	}
	
	private inline function generateTerminal():Void {
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
	
	private inline function generateSettingsButtons():Void {
		var settings = Browser.document.getElementById("settings");
		var btn = Browser.document.createElement("button");
		var t = Browser.document.createTextNode("toggle AI");
		btn.appendChild(t);
		settings.appendChild(btn);
		btn.onclick = function():Void {
			world.agent.autonomous = !world.agent.autonomous;
		};
	}
	
	private inline function generateSliders():Void {
		
	}
	
	private inline function generateGraphs():Void {
		graphs = new IntMap<NeedGraph>();
		for (motive in world.agent.brain.needs) {
			var graph:NeedGraph = new NeedGraph(motive, [ { time: 0, value: motive.value } ], "#graphs", 200, 100);
			graphs.set(motive.id, graph);
		}
	}
	
	private function set_updateInterval(time:Int):Int {
		if (updateHandle != null) {
			Browser.window.clearInterval(updateHandle);
		}
		updateHandle = Browser.window.setInterval(update, time);
		return time;
	}
}