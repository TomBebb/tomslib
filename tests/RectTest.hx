import tom.geom.Rect;
import utest.Assert;
import utest.Test;

class RectTest extends Test {
    public function testRectBounds(): Void {
        var rect = Rect.get(1, 2, 10, 30);
        Assert.floatEquals(1, rect.left);
        Assert.floatEquals(11, rect.right);
        Assert.floatEquals(2, rect.top);
        Assert.floatEquals(32, rect.bottom);
        Assert.floatEquals(300, rect.area);
    }
    public function testRectContains(): Void {
        var rect = Rect.get(0, 0, 50, 50);
        var rect2 = Rect.get(5, 5, 30, 30);
        Assert.isTrue(rect.contains(rect2));
        Assert.isFalse(rect2.contains(rect));
        Assert.isTrue(rect.intersects(rect2));
        Assert.isTrue(rect2.intersects(rect));
        var rect3 = Rect.get(-5, -5, 1, 1);
        Assert.isFalse(rect3.intersects(rect));
        Assert.isFalse(rect3.intersects(rect2));

        Assert.isTrue(Rect.get(2, 3, 4, 6).equals(Rect.get(2, 3, 4, 6)));
        Assert.isFalse(rect.equals(rect2));
    }
}