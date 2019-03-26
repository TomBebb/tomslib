import tom.MathExt;
import utest.Assert;
import utest.Test;

class MathTest extends Test {
    public function testClamp(): Void {
        Assert.floatEquals(5, MathExt.clamp(4, 5, 6));
        Assert.floatEquals(5.5, MathExt.clamp(5.5, 5, 6));
        Assert.floatEquals(6, MathExt.clamp(7, 5, 6));
    }

    public function testClampMag(): Void {
        Assert.floatEquals(5, MathExt.clampMag(6, 5));
        Assert.floatEquals(4, MathExt.clampMag(4, 5));
        Assert.floatEquals(-5, MathExt.clampMag(-6, 5));
    }
}