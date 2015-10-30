package;

import haxe.ds.StringMap;
import js.Browser;
import markov.util.FileReader;

using StringTools;
using markov.util.StringExtensions;

class Main {
	private var trainingData:StringMap<Array<String>>;
	
    private static function main():Void {
		var main = new Main();
	}
	
	private inline function new() {
		// Build a lookup table for the training data
		trainingData = new StringMap<Array<String>>();
		trainingData.set("us_forenames", FileReader.readFile("embed/usforenames.txt").split("\n"));
		trainingData.set("tolkienesque_forenames", FileReader.readFile("embed/tolkienesqueforenames.txt").split("\n"));
		trainingData.set("werewolf_forenames", FileReader.readFile("embed/werewolfforenames.txt").split("\n"));
		trainingData.set("romandeity_forenames", FileReader.readFile("embed/romandeityforenames.txt").split("\n"));
		trainingData.set("norsedeity_forenames", FileReader.readFile("embed/norsedeityforenames.txt").split("\n"));
		trainingData.set("swedish_forenames", FileReader.readFile("embed/swedishforenames.txt").split("\n"));
		trainingData.set("english_towns", FileReader.readFile("embed/englishtowns.txt").split("\n"));
		trainingData.set("theological_demons", FileReader.readFile("embed/theologicaldemons.txt").split("\n"));
		trainingData.set("scottish_surnames", FileReader.readFile("embed/scottishsurnames.txt").split("\n"));
		trainingData.set("irish_forenames", FileReader.readFile("embed/irishforenames.txt").split("\n"));
		trainingData.set("icelandic_forenames", FileReader.readFile("embed/icelandicforenames.txt").split("\n"));
		trainingData.set("theological_angels", FileReader.readFile("embed/theologicalangels.txt").split("\n"));
		trainingData.set("japanese_forenames", FileReader.readFile("embed/japaneseforenames.txt").split("\n"));
		trainingData.set("french_forenames", FileReader.readFile("embed/frenchforenames.txt").split("\n"));
		trainingData.set("german_towns", FileReader.readFile("embed/germantowns.txt").split("\n"));
		trainingData.set("animals", FileReader.readFile("embed/animals.txt").split("\n"));
		trainingData.set("pokemon", FileReader.readFile("embed/pokemon.txt").split("\n"));
		trainingData.set("fish", FileReader.readFile("embed/fish.txt").split("\n"));
		trainingData.set("plantscommon", FileReader.readFile("embed/plantscommon.txt").split("\n"));
		//trainingData.set("profanity_filter", FileReader.readFile("embed/profanityfilter.txt").split("\n")); // Skipping this one for SEO and paranoia reasons
		
		// Wait for the window to load before creating the sliders, listening for input etc
		Browser.window.onload = onWindowLoaded;
	}
	
	private inline function onWindowLoaded():Void {
	}
}