package tom.ds;

import haxe.ds.List;

/**
 * A first-in first-out structure
 */
abstract Queue<T>(List<T>) {
    public inline function new()
        this = new List<T>();
    
    /**
     * Remove all elements in this queue.
     */
    public inline function clear(): Void
        this.clear();
    
    /**
     * Insert the item given into the queue.
     * @param item the item 
     */
    public inline function push(item: T): Void
        this.add(item);
    
    /**
     * Retrieves the head of this queue, without removing it
     * @return the head
     */
    public inline function peek(): Null<T>
        return this.first();
    
    /**
     * Retreives the head of this queue, after removing it
     * @return the head
     */
    public inline function pop(): Null<T>
        return this.pop();
    
    public inline function toString(): String
        return this.toString();
    
    public inline function iterator(): Iterator<T>
        return this.iterator();

}