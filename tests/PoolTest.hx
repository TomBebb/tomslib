import tom.util.Pool;
import tom.geom.Rect;
import utest.Assert;
import utest.Test;

class PoolTest extends Test {
    public function testRectPool(): Void {
        var pool = new Pool<Rect>(() -> new Rect());
        var rect = pool.get().set(0, 0, 0, 0);
        Assert.notNull(rect);
        Assert.notNull(rect.x);
        Assert.equals(0, rect.x);
        Assert.equals(0, rect.y);
        Assert.equals(0, rect.width);
        Assert.equals(0, rect.height);
    }
}