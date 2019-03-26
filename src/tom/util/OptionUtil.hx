package tom.util;

import haxe.ds.Option;

class OptionUtil {
    public static inline function isSome<T>(v: Option<T>): Bool
        return switch(v) {
            case Some(_): true;
            default: false;
        };
    public static inline function isNone<T>(v: Option<T>): Bool
        return switch(v) {
            case None: true;
            default: false;
        };
    public static function equals<T>(a: Option<T>, b: Option<T>): Bool {
        return switch(a) {
            case Some(innerA):
                switch(b) {
                    case Some(innerB):
                        innerA == innerB;
                    default: false;
                }
            default: false;
        }
    }
    public static function innerEquals<T>(a: Option<T>, v: T): Bool
        return switch(a) {
            case Some(innerA):  innerA == v;
            default: false;
        };
    public static function toObject<T>(a: Option<T>): T
        return switch(a) {
            case Some(innerA):  innerA;
            default: null;
        };
}