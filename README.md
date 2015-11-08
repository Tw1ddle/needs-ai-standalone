![Project logo](https://github.com/Tw1ddle/MarkovNameGenerator/blob/master/screenshots/markovnamegen_logo.png?raw=true "Project logo")

Need-based artificial intelligence written in Haxe. Need-based AI is useful for games where semi-autonomous agents have to satisfy several competing goals, such as in titles like The Sims. 

Play the demo project [in the browser](http://www.samcodes.co.uk/project/markov-namegen/) and try to survive for 24 hours

## Features ##
* Need-based artifical intelligence.

## Usage ##

Try it [in your browser](http://www.samcodes.co.uk/project/markov-namegen/).

## Screenshots ##
Here is the game in action:

![Screenshot](https://github.com/Tw1ddle/MarkovNameGenerator/blob/master/screenshots/screenshot1.png?raw=true "Screenshot 1")

## How It Works ##

The game uses a need-based AI to control a virtual Internet troll.

The generator can use several orders of models, each with memory n. Starting with the highest order models (models with bigger memories), it tries to get a new character, falling back to lower order models if necessary - this approach is known as [Katz's back-off model](https://en.wikipedia.org/wiki/Katz%27s_back-off_model).

A [Dirichlet prior](https://en.wikipedia.org/wiki/Dirichlet_distribution#Special_cases) is also used, which adds a constant probability that any letter may be picked as the next letter, which acts as an additive smoothing factor and adds a bit more "randomness" to the generated output.

Loads of words are generated, and are filtered and sorted according to several tweakable criteria like length, start and end characters, [similarity to a target word](https://en.wikipedia.org/wiki/Levenshtein_distance), and so on.

## Notes ##
* Many of the concepts used for the generator were suggested by [this article](http://www.roguebasin.com/index.php?title=Names_from_a_high_order_Markov_Process_and_a_simplified_Katz_back-off_scheme) by [Jeffrey Lund](https://github.com/jlund3).
* The haxelib supports every Haxe target, but it has not been thoroughly tested or optimized for performance yet, especially on native platforms.
* If you have any suggestions or questions then get in touch.