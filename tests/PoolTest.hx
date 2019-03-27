import tom.util.Pool;
import tom.geom.Rect;
import utest.Assert;
import utest.Test;

class PoolTest extends Test {
    public function testRectPool(): Void {
        var pool = new Pool<Rect>(() -> new Rect());
        Assert.equals(0, pool.objectsInPool);
        var rect = pool.get().set(0, 0, 0, 0);
        Assert.notNull(rect);
        Assert.notNull(rect.x);
        Assert.equals(0, rect.x);
        Assert.equals(0, rect.y);
        Assert.equals(0, rect.width);
        Assert.equals(0, rect.height);
        pool.put(rect);
        Assert.equals(1, pool.objectsInPool);
        Assert.equals(16, pool.capacity);
        var poppedRect = pool.get();
        Assert.equals(rect, poppedRect);
        Assert.equals(0, pool.objectsInPool);
        for(i in 0...pool.capacity) {
            Assert.equals(i, pool.objectsInPool);
            var rect = new Rect(0, 0, 4, 4);
            pool.put(rect);
        }
        Assert.equals(pool.capacity, pool.objectsInPool);
        rect = new Rect(12, 12, 3, 4);
        pool.put(rect);
        Assert.equals(pool.capacity, pool.objectsInPool);
    }
}