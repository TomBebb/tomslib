package tom.ds;

import tom.ds.Queue;
import haxe.ds.Option;

import haxe.io.Int32Array.Int32ArrayData;
using tom.util.OptionUtil;

@:enum abstract TreeColor(Bool) from Bool to Bool {
    var RED = true;
    var BLACK = false;
}
@:generic
class Node<K, V> {
    public var key: K;
    public var value: V;
    public var left: Node<K, V>;
    public var right: Node<K, V>;
    public var color: TreeColor;
    public var size: Int;

    public function new(key: K, val: V, color: TreeColor, size: Int) {
        this.key = key;
        this.value = val;
        this.color = color;
        this.size = size;
    }
}

abstract Tree<K, V>(TreeData<K, V>) {
    
    /**
     * The number of key-value pairs in this table
     */
    public var size(get, never): Int;
    /**
     * Create a new tree map
     * @param keyCompare The key comparison function
     */
    public inline function new(keyCompare: K -> K -> Int) {
        this = new TreeData<K, V>(keyCompare);
    }
    /**
     * Is this table empty?
     * @return `true` when table is empty
     */
    
    public inline function isEmpty(): Bool
        return this.isEmpty();
    
    /**
     * Value associated with the given get if key is in table.
     * @param key the key
     * @return the value associated with the key
     */
    @:arrayAccess
    public inline function get(key: K): Null<V>
        return this.get(key);
    
    public inline function put(key: K, value: V): Void
        this.put(key, value);

    @:arrayAccess
    public inline function set(key: K, value: V): V
        return this.set(key, value);
    
    inline function get_size(): Int
        return this.size();
    
    public inline function delete(key: K): Void
        this.delete(key);
    
    
    /**
     * Does this table contain the key?
     * @param key the key
     * @return `true` if the table contains `key`, `false` otherwise
     */
    public inline function contains(key: K): Bool
        return this.contains(key);
    
    public inline function keys(?lo: K, ?hi: K): Iterable<K>
        return this.keys(lo, hi);
    
    public inline function keyValueIterator(): KeyValueIterator<K, V>
        return this.keyValueIterator();
    
    
    /**
     * Returns the smallest key in the table
     */
    public inline function min(): Null<K>
        return this.min();
    /**
     * Returns the largest key in the table
     */
    public inline function max(): Null<K>
        return this.max();
    /**
     * Returns the nearest key in the table
     */
    public inline function floor(value: K): Null<K>
        return this.floor(value);
    /**
     * Returns the nearest key in the table
     */
    public inline function nearest(value: K): Null<K>
        return this.nearest(value);
}

@:generic
class TreeData<K, V> {
    var root: Node<K, V>;
    var keyCompare: K -> K -> Int;
    public inline function new(keyCompare: K -> K -> Int) {
        this.keyCompare = keyCompare;
    }

    public inline function size(): Int
        return nodeSize(root);
    
    public inline function isEmpty(): Bool
        return root == null;

    public function get(key: K): Null<V> {
        var node = getNode(key);
        return node == null ? null : node.value;
    }
    public function set(key: K, value: V): V {
        var node = getNode(key);
        if(node == null)
            put(key, value);
        else
            node.value = value;
        return value;
    }

    function getNode(key: K): Node<K, V> {
        var node = root;
        while(node != null) {
            var cmp = keyCompare(key, node.key);
            if(cmp < 0) node = node.left;
            else if(cmp > 0) node = node.right;
            else break;
        }
        return node;
    }

    inline function isRed(x: Node<K, V>): Bool
        return x == null ? false : x.color == RED;

    public inline function contains(key: K): Bool
        return get(key) != null;

    public inline function put(key: K, val: V): Void {
        root = putNode(root, key, val);
        root.color = BLACK;
    }

    function putNode(h: Node<K, V>, key: K, val: V): Node<K, V> {
        if(h == null)
            return new Node(key, val, RED, 1);
        
        var cmp = keyCompare(key, h.key);
        if(cmp < 0) h.left = putNode(h.left, key, val);
        else if(cmp > 0) h.right = putNode(h.right, key, val);
        else h.value = val;

        // fix any right links

        if(isRed(h.right) && !isRed(h.left))
            h = rotateLeft(h);
        if(isRed(h.left) && isRed(h.left.left))
            h = rotateRight(h);
        if(isRed(h.left) && isRed(h.right))
            flipColors(h);
        
        h.size = nodeSize(h.left) + nodeSize(h.right) + 1;

        return h;
    }

    public function deleteMin(): Void {
        if(isEmpty())
            throw "BST underflow";
        
        if(!isRed(root.left) && !isRed(root.right))
            root.color = RED;
        
        root = deleteMinNode(root);
        if(!isEmpty()) root.color = BLACK;
    }

    function deleteMinNode(h: Node<K, V>): Node<K, V> {
        if(h.left == null)
            return null;
        
        if(!isRed(h.left) && !isRed(h.left.left))
            h = moveRedLeft(h);
        
        h.left = deleteMinNode(h.left);
        return balance(h);
    }

    public function deleteMax(): Void {
        if(isEmpty())
            throw "BST underflow";
        
        if(!isRed(root.left) && !isRed(root.right))
            root.color = RED;
        
        root = deleteMaxNode(root);
        if(!isEmpty()) root.color = BLACK;
    }
    function deleteMaxNode(h: Node<K, V>): Node<K, V> {
        if(h.right == null)
            return null;
        
        if(!isRed(h.right) && !isRed(h.right.left))
            h = moveRedRight(h);
        
        h.left = deleteMaxNode(h.left);
        return balance(h);
    }
    public function delete(key: K) {
        if(!contains(key))
            return;
        
        if(!isRed(root.left) && !isRed(root.right))
            root.color = RED;
        
        root = deleteNode(root, key);
        if(!isEmpty()) root.color = BLACK;
    }

    function deleteNode(h: Node<K, V>, key: K): Node<K, V> {
        var cmp = keyCompare(key, h.key);
        if(cmp < 0) {
            if(!isRed(h.left) && !isRed(h.left.left)) 
                h = moveRedLeft(h);
            h.left = deleteNode(h.left, key);
        } else {
            if(isRed(h.left)) {
                h = rotateRight(h);
                cmp = keyCompare(key, h.key);
            }
            if(cmp == 0 && h.right == null)
                return null;
            if(!isRed(h.right) && !isRed(h.right)) {
                h = moveRedRight(h);
                cmp = keyCompare(key, h.key);
            }
            if(cmp == 0) {
                var x = minNode(h.right);
                h.key = x.key;
                h.value = x.value;
                h.right = deleteMinNode(h.right);
            } else
                h.right = deleteNode(h.right, key);
        }
        return balance(h);
    }
    inline function nodeSize(h: Node<K, V>):Int
        return h == null ? 0 : h.size;
    
    // helper functions

    // make left-leaning link lean to right
    function rotateRight(h: Node<K, V>): Node<K, V> {
        var x = h.left;
        h.left = x.right;
        x.right = h;
        x.color = x.right.color;
        x.right.color = RED;
        x.size = h.size;
        h.size = nodeSize(h.left) + nodeSize(h.right) + 1;
        return x;
    }
    // make right-leaning link lean to left
    function rotateLeft(h: Node<K, V>): Node<K, V> {
        var x = h.right;
        h.right = x.left;
        x.left = h;
        x.color = x.left.color;
        x.left.color = RED;
        x.size = h.size;
        h.size = nodeSize(h.left) + nodeSize(h.right) + 1;
        return x;
    }
    function flipColors(h: Node<K, V>): Void {
        h.color = !h.color;
        h.left.color = !h.left.color;
        h.right.color = !h.right.color;
    }
    function moveRedLeft(h: Node<K, V>): Node<K, V> {
        flipColors(h);
        if(isRed(h.right.left)) {
            h.right = rotateRight(h.right);
            h = rotateLeft(h);
            flipColors(h);
        }
        return h;
    }
    function moveRedRight(h: Node<K, V>): Node<K, V> {
        flipColors(h);
        if(isRed(h.left.left)) {
            h = rotateRight(h);
            flipColors(h);
        }
        return h;
    }
    function balance(h: Node<K, V>): Node<K, V> {
        if(isRed(h.right)) h = rotateLeft(h);
        if(isRed(h.left) && isRed(h.left.left)) h = rotateRight(h);
        if(isRed(h.left) && isRed(h.right)) flipColors(h);
        h.size = nodeSize(h.left) + nodeSize(h.right) + 1;
        return h;
    }
    // util
    // ordered table methods

    /**
     * Returns the smallest key in the table
     */
    public inline function min(): Null<K>
        return isEmpty() ? null : minNode(root).key;
    
    // get smallest key in table
    public function minNode(x: Node<K, V>): Node<K, V>
        return x.left == null ? x : minNode(x.left);
    /**
     * Returns the largest key in the table
     */
    public inline function max(): Null<K>
        return isEmpty() ? null : maxNode(root).key;
    
    // get largest key in table
    public function maxNode(x: Node<K, V>): Node<K, V>
        return x.right == null ? x : maxNode(x.right);
    
    public inline function floor(key: K): K {
        var x = floorNode(root, key);
        return x == null ? null : x.key;
    }

    public inline function ceiling(key: K): K {
        var x = ceilingNode(root, key);
        return x == null ? null : x.key;
    }
    public function nearest(key: K): Null<K> {
        var fl = floor(key);
        var cl = ceiling(key);
        if(fl == null)
            return cl;
        if(cl == null)
            return fl;
            
        var flDiff = Math.abs(keyCompare(key, fl));
        var clDiff = Math.abs(keyCompare(key, cl));
        return flDiff < clDiff ? fl : cl;
    }
    function floorNode(x: Node<K, V>, key: K): Node<K, V> {
        if(x == null)
            return null;
        var cmp = keyCompare(key, x.key);
        return if(cmp == 0)
            x;
        else if(cmp < 0)
            floorNode(x.left, key);
        else {
            var t = floorNode(x.right, key);
            t != null ? t : x;
        };
    }
    function ceilingNode(x: Node<K, V>, key: K): Node<K, V> {
        if(x == null)
            return null;
        var cmp = keyCompare(key, x.key);
        return if(cmp == 0)
            x;
        else if(cmp > 0)
            ceilingNode(x.right, key);
        else {
            var t = ceilingNode(x.left, key);
            t != null ? t : x;
        }
    }
    public function keys(?lo: K, ?hi: K): Iterable<K> {
        if(isEmpty())
            return cast new Queue<K>();
        if(lo == null)
            lo = minNode(root).key;
        if(hi == null)
            hi = maxNode(root).key;
        var queue = new Queue<K>();
        keysNodesQueue(root, queue, lo, hi);
        return cast queue;
    }
    function keysNodesQueue(x: Node<K, V>, queue: Queue<K>, lo: K, hi: K): Void {
        if(x == null) return;
        var cmpLo = keyCompare(lo, x.key);
        var cmpHi = keyCompare(hi, x.key);

        if(cmpLo < 0) keysNodesQueue(x.left, queue, lo, hi);
        if(cmpLo <= 0  && cmpHi >= 0) queue.push(x.key);
        if(cmpHi > 0) keysNodesQueue(x.right, queue, lo, hi);
    }
    public function keyValueIterator(): KeyValueIterator<K, V> {
        var keys = keys().iterator();
        return {
            hasNext: () -> keys.hasNext(),
            next: () -> {
                var key = keys.next();
                {key: key, value: get(key)}
            }
        }
    }
}