using tom.util.IteratorUtil;
import tom.util.Comparator;
import utest.Assert;
import utest.Test;

class IterTest extends Test {
    public function testSort() {
        var arr = [1, -2, 32, 23, 3];
        var sorted = arr.iterator().sort(Comparator.INT);
        var i = 0;
        for(elem in sorted) {
            switch(elem) {
                case 0: Assert.equals(-2, elem); break;
                case 1: Assert.equals(1, elem); break;
                case 2: Assert.equals(3, elem); break;
                case 3: Assert.equals(23, elem); break;
                case 4: Assert.equals(32, elem); break;
            }
            i++;
        }
    }
    public function testMin() {
        var arr = [1, -2, 32, 23, 3];
        Assert.equals(-2, arr.iterator().min(Comparator.INT));
        Assert.equals(null, new Array<Int>().iterator().min(Comparator.INT));
    }
    public function testMax() {
        var arr = [1, -2, 32, 23, 3];
        Assert.equals(32, arr.iterator().max(Comparator.INT));
        Assert.equals(null, new Array<Int>().iterator().max(Comparator.INT));
    }
    public function testFirstLast() {
        Assert.isNull(new Array<Int>().iterator().first());
        Assert.isNull(new Array<Int>().iterator().last());
        Assert.equals(1, [1, -2, 3, 5].iterator().first());
        Assert.equals(5, [1, -2, 3, 5].iterator().last());
    }
    public function testSkip() {
        Assert.equals(3, [1, -2, 3, 5].iterator().skip(2).first());
        Assert.equals(5, [1, -2, 3, 5].iterator().skip(3).first());
    }
    public function testCount() {
        Assert.equals(0, new Array<Int>().iterator().count());
        Assert.equals(2, [0, 1].iterator().count());
        Assert.equals(5, [0, 1, 2, 1, -1].iterator().count());
    }
    public function testReduce() {
        var items = [for(i in 0...10) i];
        Assert.equals(45, items.iterator().reduce((a, b) -> a + b));
        Assert.equals(0, [].iterator().reduce((a, b) -> a + b, 0));
        Assert.equals(3, [1, 2].iterator().reduce((a, b) -> a + b));
    }
    public function testMap() {
        var items = [for(i in 0...10) i];
        var mappedItems = items.iterator().map(i -> i * 2);
        Assert.equals(0, mappedItems.next());
        Assert.equals(2, mappedItems.next());
        Assert.equals(4, mappedItems.next());
        Assert.equals(6, mappedItems.next());
        Assert.equals(8, mappedItems.next());
        Assert.equals(10, mappedItems.next());
    }
    public function testToArray() {
        var items = [for(i in 0...10) i];
        var items2 = items.iterator().toArray();
        Assert.equals(items.length, items2.length);
        for(i in 0...items.length)
            Assert.equals(items[i], items2[i]);
    }
}