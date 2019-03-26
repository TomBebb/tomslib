import tom.ds.TreeMap;
import utest.Assert;
import utest.Test;

class TreeTest extends Test {
    public function testEmptyTree(): Void {
        var tree = new TreeMap<Int, String>((a, b) -> a - b);
        Assert.isTrue(tree.isEmpty());
        Assert.equals(tree.size, 0);
        Assert.equals(null, tree.max());
        Assert.equals(null, tree.min());
    }
    public function testSingleTree(): Void {
        var tree = new TreeMap<Int, String>((a, b) -> a - b);
        tree.put(5, "Hello");
        Assert.isFalse(tree.isEmpty());
        Assert.equals(null, tree[6]);
        Assert.equals("Hello", tree[5]);
        Assert.equals(1, tree.size);
        Assert.equals(5, tree.max());
        Assert.equals(5, tree.min());
        Assert.equals(null, tree.floor(1));
        Assert.equals(5, tree.floor(6));
    }
    public function testManyTreeSizes(): Void {
        var tree = new TreeMap<Int, String>((a, b) -> a - b);
        Assert.equals(0, tree.size);
        tree.put(5, "Hello");
        Assert.equals(1, tree.size);
        tree.put(10, "World");
        Assert.equals(2, tree.size);
        tree.put(15, "Its");
        Assert.equals(3, tree.size);
        tree.put(20, "Dave");
        Assert.equals(4, tree.size);
        tree.delete(20);
        Assert.equals(3, tree.size);
    }
    public function testTreeDelete(): Void {
        var tree = new TreeMap<Int, String>((a, b) -> a - b);
        tree.put(5, "Hello");
        tree.put(7, "To");
        tree.put(10, "World");
        tree.put(15, "Its");
        tree.put(20, "Dave");
        Assert.equals(5, tree.size);
        tree.deleteRange(5, 7);
        Assert.equals(3, tree.size);
        tree.deleteRange(15, 20);
        Assert.equals(1, tree.size);
    }
    public function testManyTree(): Void {
        var tree = new TreeMap<Int, String>((a, b) -> a - b);
        Assert.isTrue(tree.isEmpty());
        tree[5] = "Hello";
        tree[10] = "World";
        tree[15] = "Its";
        tree[20] = "Dave";
        Assert.isFalse(tree.isEmpty());
        Assert.equals(20, tree.max());
        Assert.equals(5, tree.min());
        Assert.equals(null, tree.floor(1));
        Assert.equals(5, tree.floor(5));
        Assert.equals(5, tree.floor(7));
        Assert.equals(5, tree.floor(9));
        Assert.equals(10, tree.floor(10));
        Assert.equals("Hello", tree[5]);
        Assert.equals("World", tree[10]);
        Assert.equals("Its", tree[15]);
        Assert.equals("Dave", tree[20]);
        Assert.equals(5, tree.nearest(-10));
        Assert.equals(5, tree.nearest(1));
        Assert.equals(10, tree.nearest(9));
        Assert.equals(20, tree.nearest(19));

        tree[5] = "Goodbye";
        Assert.equals("Goodbye", tree[5]);

        tree.delete(5);
        Assert.equals(null, tree[5]);
    }
    public function testTreeIter(): Void {
        var tree = new TreeMap<Int, String>((a, b) -> a - b);
        tree.put(5, "Hello");
        tree.put(10, "World");
        tree.put(15, "Its");
        tree.put(20, "Dave");

        var treeKeys = tree.keys().iterator();
        Assert.equals(5, treeKeys.next());
        Assert.equals(10, treeKeys.next());
        Assert.equals(15, treeKeys.next());
        Assert.equals(20, treeKeys.next());
    }
}