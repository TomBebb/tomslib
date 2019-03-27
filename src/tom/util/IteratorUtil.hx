package tom.util;

import haxe.ds.List;

@:generic
class FilterIter<T> {
    var iter: Iterator<T>;
    var pred: T -> Bool;
    var curr: T;
    public function new(iter: Iterator<T>, pred: T -> Bool) {
        this.iter = iter;
        this.pred = pred;
    }
    public function hasNext(): Bool {
        while(iter.hasNext()) {
            curr = iter.next();
            if(pred(curr))
                return true;
        }
        return false;
    }
    public inline function next(): T
        return curr;
}

class MapIter<T, V> {
    var iter: Iterator<T>;
    var map: T -> V;

    public inline function new(iter: Iterator<T>, map: T -> V) {
        this.iter = iter;
        this.map = map;
    }
    public inline function hasNext(): Bool
        return iter.hasNext();
    
    public inline function next(): V
        return map(iter.next());
}

class IteratorUtil {
    public static inline function filter<T>(iter: Iterator<T>, pred: T -> Bool): Iterator<T>
        return new FilterIter<T>(iter, pred);
    @:generic
    public static inline function map<T, V>(iter: Iterator<T>, map: T -> V): Iterator<V>
        return new MapIter<T, V>(iter, map);
    
    @:generic
    public static inline function skip<T>(iter: Iterator<T>, n: Int): Iterator<T> {
        while(--n >= 0 && iter.hasNext())
            iter.next();
        return iter;
    }

    @:generic
    public static function all<T>(iter: Iterator<T>, pred: T -> Bool): Bool {
        for(elem in iter)
            if(!pred(elem))
                return false;
        return true;
    }
    @:generic
    public static function any<T>(iter: Iterator<T>, pred: T -> Bool): Bool {
        for(elem in iter)
            if(pred(elem))
                return true;
        return false;
    }
    @:generic
    public static inline function first<T>(iter: Iterator<T>): Null<T>
        return iter.hasNext() ? iter.next() : null;

    @:generic
    public static inline function last<T>(iter: Iterator<T>): Null<T> {
        var last: Null<T> = null;
        for(elem in iter)
            last = elem;
        return last;
    }
    
    @:generic
    public static function count<T>(iter: Iterator<T>): Int {
        var count = 0;
        for(_ in iter)
            count++;
        return count;
    }
    @:generic
    public static function reduce<T>(iter: Iterator<T>, reducer: T -> T -> T, ?initial: T) {
        var acc = initial;
        for(value in iter) {
            if(acc == null)
                acc = value;
            else
                acc = reducer(acc, value);
        }
        return acc;
    }
    /**
     * Collect this iterator into an array
     */
    @:generic
    public static inline function toArray<T>(iter: Iterator<T>): Array<T>
        return [for(elem in iter) elem];

    /**
     * Collect this iterator into a linked list
     */
    @:generic
    public static function toList<T>(iter: Iterator<T>): List<T> {
        var list = new List<T>();
        for(elem in iter)
            list.add(elem);
        return list;
    }
}