using tom.util.IteratorUtil;

class BaseMain {
    static function main() {
        var iter = [2, 3, 4, 5].iterator();
        for(elem in iter.map(i -> i * 4)) {
            trace(elem);
        }
    }
}