import tom.ds.Tree;
import utest.Assert;
import utest.Test;
import haxe.ds.Option;

class TreeTest extends Test {
    public function testEmptyTree(): Void {
        var tree = new Tree<Int, String>((a, b) -> a - b);
        Assert.isTrue(tree.isEmpty());
        Assert.equals(tree.size(), 0);
        Assert.equals(tree.max(), Option.None);
        Assert.equals(tree.min(), Option.None);
    }
}