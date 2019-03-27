package tom.util;

@:generic
class Pool<T: IPoolable> {
    var makeObj: Void -> T;
    var pooled: Array<T>;
    
    /**
     * Maximum allowed number of pooled objects.
     */
    public final capacity: Int;
    /**
     * Number of pooled objects.
     */
    public var objectsInPool(get, null): Int;
    
    public inline function new(makeObj: Void -> T, capacity: Int = 16) {
        this.capacity = capacity;
        pooled = new Array<T>();
        this.makeObj = makeObj;
    }

    public inline function get(): T
        return pooled.length == 0 ? makeObj() : pooled.pop();

    public function put(value: T): Void {
        value.reset();
        if(pooled.length + 1 <= capacity)
            pooled.push(value);
    }

    inline function get_objectsInPool(): Int
        return pooled.length;
}

interface IPoolable {
    function reset(): Void;
}