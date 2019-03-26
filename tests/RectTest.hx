import tom.geom.Rect;
import utest.Assert;
import utest.Test;

class RectTest extends Test {
    public function testRectContains(): Void {
        var rect = Rect.get(0, 0, 50, 50);
        var rect2 = Rect.get(5, 5, 30, 30);
        Assert.isTrue(rect.contains(rect2));
        Assert.isFalse(rect2.contains(rect));
    }
}