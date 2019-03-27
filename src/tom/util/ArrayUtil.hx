package tom.util;

class ArrayUtil {
    /**
     * Remove all elements from an array
     * @param arr the array
     */
    public static inline function clear<T>(arr: Array<T>): Void
        arr.splice(0, arr.length);
}