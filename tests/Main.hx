import utest.Runner;
import utest.ui.Report;
import tom.ds.Tree;

class Main {
  static function main() {
    utest.UTest.run([new RectTest(), new TreeTest()]);
  }
}