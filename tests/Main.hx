import utest.Runner;
import utest.ui.Report;

class Main {
  static function main() {
    utest.UTest.run([new RectTest(), new TreeTest()]);
  }
}