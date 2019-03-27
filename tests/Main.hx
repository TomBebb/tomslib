import utest.Runner;
import utest.ui.Report;
import tom.ds.TreeMap;

class Main {
	static function main() {
		utest.UTest.run([
            new RectTest(),
            new TreeTest(),
            new PoolTest(),
            new MathTest(),
            new QuadTreeTest(),
            new IterTest()
        ]);
	}
}
