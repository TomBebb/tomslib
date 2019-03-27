package tom.util;

class ArrayUtil {
    public static inline function clear<T>(arr: Array<T>): Void
        arr.splice(0, arr.length);
}