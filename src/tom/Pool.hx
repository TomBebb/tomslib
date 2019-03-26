package tom;

import haxe.ds.Vector;

@:generic
class Pool<T: IPoolable> {
    var makeObj: Void -> T;
    var pooled: Array<T>;
    
    public final capacity: Int;
    
    public inline function new(makeObj: Void -> T, capacity: Int = 16) {
        this.capacity = capacity;
        pooled = new Array<T>();
        this.makeObj = makeObj;
    }

    public inline function get(): T
        return pooled.length == 0 ? makeObj() : pooled.pop();

    public function put(value: T): Void {
        value.reset();
        if(pooled.length < capacity)
            pooled.push(value);
    }
}

interface IPoolable {
    function reset(): Void;
}