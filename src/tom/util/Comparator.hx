package tom.util;
import tom.MathExt;

abstract Comparator<T>(T -> T -> Int) {
    public static final INT = new Comparator<Int>((a, b) -> a - b);
    public static final FLOAT = new Comparator<Float>((a, b) -> MathExt.sign(a - b));
    /**
     * Make a new comparator based on the comparison function `cmp`
     * 
     * Comparator function `cmp` `cmp(a, b)` returns:
     * + 0 if `a == b`
     * + +1 if `a > b`
     * + -1 if `a < b`
     * 
     * @param cmp comparator function
     * @return this = cmp
     */
    public inline function new(cmp: T -> T -> Int)
        this = cmp;
    
    public inline function compare(a: T, b: T): Int
        return this(a, b);
    
    public inline function isLessThan(a: T, b: T): Bool
        return compare(a, b) < 0;
    
    public inline function isGreaterThan(a: T, b: T): Bool
        return compare(a, b) > 0;
    
    public inline function equals(a: T, b: T): Bool
        return compare(a, b) == 0;

}