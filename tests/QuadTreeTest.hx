import tom.MathExt;
import tom.geom.Rect;
import tom.geom.QuadTree;
import utest.Assert;
import utest.Test;
using tom.util.ArrayUtil;

class WrappedRect extends Rect implements IQuadTreeMember {
    public var bounds(get, never): Rect;

    inline function get_bounds(): Rect
        return this;
}

class QuadTreeTest extends Test {
    var tree: QuadTree<WrappedRect>;
    public function setup() {
        tree = new QuadTree<WrappedRect>(Rect.get(0, 0, 100, 100));
    }
    public function testEmpty() {
        tree.clear();
        Assert.notNull(tree.bounds);
        Assert.equals(0, tree.objects.length);
        Assert.equals(0, tree.getContents().length);
    }
    public function testSingle() {
        tree.clear();
        var rect = new WrappedRect(20, 20, 60, 60);
        tree.add(rect);
        Assert.equals(1, tree.objects.length);
        Assert.equals(1, tree.getContents().length);
        
        var other = new WrappedRect(0, 0, 19, 19);
        Assert.equals(0, tree.getColliding(other).length);

        other.set(20, 20, 1, 1);
        Assert.equals(1, tree.getColliding(other).length);

        other.set(59, 59, 1, 1);
        Assert.equals(1, tree.getColliding(other).length);

        other.set(80.1, 80.1, 18, 18);
        Assert.equals(0, tree.getColliding(other).length);

        tree.remove(rect);
        Assert.equals(0, tree.objects.length);
        Assert.equals(0, tree.getContents().length);
    }
    public function testMany() {
        tree.clear();
        var total = 0;
        for(xCell in 0...50)
            for(yCell in 0...50) {
                total++;
                var x = xCell * 2, y = yCell * 2;
                var rect = new WrappedRect(x, y, 2, 2);
                tree.add(rect);
                Assert.equals(total, tree.getContents().length);
            }
        var other = new WrappedRect(20, 20, 2, 2);
        var col = tree.getColliding(other);
        Assert.equals(1, col.length);
        Assert.isTrue(col[0].equals(other));

        other.x = 100;
        col.clear();
        col = tree.getColliding(other, col);
        Assert.equals(0, col.length);

        other.set(99.9, 99.9);
        col.clear();
        col = tree.getColliding(other, col);
        Assert.equals(1, col.length);
    }
}