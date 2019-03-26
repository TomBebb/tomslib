package tom.ds;

import haxe.ds.List;

/**
 * A first-in first-out structure
 */
abstract Queue<T>(List<T>) {
    public inline function new()
        this = new List<T>();
    
    public inline function clear()
        this.clear();
    
    public inline function iterator(): Iterator<T>
        return this.iterator();
    
    public inline function push(item: T)
        this.add(item);
    
    public inline function peek(): T
        return this.first();
    
    public inline function pop(): Null<T>
        return this.pop();
    
    public inline function toString(): String
        return this.toString();
}