import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('scrolling performance test', () {
    FlutterDriver driver;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    test("Click list item in the list test", () async {
      await driver.tap(find.text("open-deepnude-h"));

      await driver.waitFor(
          find.text("Open source reverse-engineered clone of DeepNude"));
    });
  });
}
