WORK IN PROGRESS

Need-based artificial intelligence written in Haxe. Need-based AI is useful for games where semi-autonomous agents have to satisfy several competing needs, such as in games like The Sims. 

Try it out [in the browser](http://www.samcodes.co.uk/project/needs-ai/).

## Usage ##
* Control a guy and try to survive for 24 hours by managing their needs.
* Let the AI do the work for you.

## Screenshots ##
Here is the AI in action:

![Screenshot](https://github.com/Tw1ddle/needs-ai/blob/master/screenshots/screenshot1.png?raw=true "Need-based AI screenshot 2")

## How It Works ##
The need-based AI is modelled as a set of needs, a set of actions, and a strategy that executes actions to meet the needs. As time passes, the urgency of needs change.

There are four strategies: 
* Always satisfy the most urgent need.
* Random selection weighted towards the urgent needs.
* Totally random selection.
* Nothing - manual control.

Threshold values are used to make the agent repeat actions to satisfy a need, when a single action might not be sufficient. Modifiers are used to change the effectiveness of needs or actions, to model traits or personality differences.

## Notes ##
* This was inspired by text adventures like [Liberal Crime Squad](http://www.bay12games.com/lcs/) and [Oubliette](http://www.mobygames.com/game/dos/oubliette), but went on a tangent.
* If you have any suggestions, requests or comments then [contact me](http://samcodes.co.uk/contact/).