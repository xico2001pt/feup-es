import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric FillPasswordStep(String password) {
  return when1<String, FlutterWorld>(
    'I fill the {string} field with my password',
    (key, context) async {
      final locator = find.byValueKey(key);
      await FlutterDriverUtils.enterText(
          context.world.driver, locator, password);
    },
  );
}
