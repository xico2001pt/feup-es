import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric UncheckAllActivityFiltersStep() {
  return when<FlutterWorld>(
    'I uncheck all the activity filters',
    (context) async { 
      context.configuration.timeout = Duration(seconds: 20);
      int i = 0;
      final driver = context.world.driver;
      final list = find.byValueKey('ActivityFilterCheckboxList');
      var locator = find.byValueKey('ActivityCheck$i');
      var exists = await isPresent(locator, driver);
      while(exists){
        await FlutterDriverUtils.tap(driver, locator);
        await FlutterDriverUtils.waitForFlutter(driver, timeout: Duration(milliseconds: 50));
        await driver.scroll(list, 0, -80, Duration(milliseconds: 50));
        i += 1;
        locator = find.byValueKey('ActivityCheck$i');
        exists = await isPresent(locator, driver);
      }
    }
  );
} 

Future<bool> isPresent(SerializableFinder finder, FlutterDriver driver, {Duration timeout = const Duration(seconds: 1)}) async {
  try {
    await driver.waitFor(finder, timeout: timeout);
    return true;
  } catch (e) {
    return false;
  }
}