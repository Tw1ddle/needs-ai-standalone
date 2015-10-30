package markov.util;

using markov.util.StringExtensions;

// Unoptimized prefix trie, see https://en.wikipedia.org/wiki/Trie
class PrefixTrie {
	public var root:PrefixNode;
	
	public function new() {
		root = new PrefixNode("", null, 0);
	}
	
	/*
	 * Inserts a word. For nodes that already exist, it increments a frequency count.
	 * Marks the end of word node with the "word" flag.
	 */
	public function insert(word:String):Void {
		var current = root;
		
		for (i in 0...word.length) {
			var child = findChild(current, word.charAt(i));
			
			if (child == null) {
				child = new PrefixNode(word.charAt(i), current, i);
				current.children.push(child);
			} else {
				child.frequency++;
			}
			
			current = child;
		}
		current.word = true;
	}
	
	/*
	 * Attempts to find a word in the trie.
	 * NOTE the "word" flag must be set on the terminal node, or it returns false.
	 */
	public function find(word:String):Bool {
		var current = root;
		
		for (i in 0...word.length) {
			current = findChild(current, word.charAt(i));
			if (current == null) {
				return false;
			}
		}
		
		if (!current.word) {
			return false;
		}
		
		return true;
	}
	
	/*
	 * Attempts to find an immediate child node with the given letter
	 * NOTE does linear lookup through unsorted children, it's simple and uses little memory but is really slow
	 */
	private static function findChild(node:PrefixNode, letter:String):PrefixNode {		
		var ret:PrefixNode = null;
		for (child in node.children) {
			if (child.letter == letter) {
				ret = child;
				break;
			}
		}
		return ret;
	}
	
	/*
	 * Gets an array of all the words that have been inserted into the trie
	 * NOTE suitable for debugging only, it does really slow BFS that has to work back up to the root every time to build a word
	 */
	public function getWords():Array<String> {
		var queue = new List<PrefixNode>();
		queue.add(root);
		var words = new Array<String>();
		
		while (!queue.isEmpty()) {
			var node = queue.pop();
			
			if (node.word) {
				var word:String = node.letter;
				var parent = node.parent;
				while (parent != null) {
					word += parent.letter;
					parent = parent.parent;
				}
				words.push(word.reverse());
			}
			
			for (child in node.children) {
				queue.add(child);
			}
		}
		
		return words;
	}
}

// Represents a node in the prefix trie
class PrefixNode {
	public var parent:PrefixNode;
	public var children:Array<PrefixNode>;
	public var letter:String;
	public var frequency:Int;
	public var word:Bool;
	
	/*
	// Just for drawing using d3.js
	public var x:Float;
	public var y:Float;
	*/
	public var depth:Int;
	
	public inline function new(letter:String, parent:PrefixNode, depth:Int) {
		//Sure.sure(letter.length == 1);
		this.parent = parent;
		children = new Array<PrefixNode>();
		this.letter = letter;
		frequency = 1;
		word = false;
		
		/*
		x = 0;
		y = 0;
		*/
		this.depth = depth;
	}
}