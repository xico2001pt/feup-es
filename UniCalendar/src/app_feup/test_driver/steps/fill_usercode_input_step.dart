import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric FillUsercodeStep(String usercode) {
  return when1<String, FlutterWorld>(
    'I fill the {string} field with my usercode',
    (key, context) async {
      final locator = find.byValueKey(key);
      await FlutterDriverUtils.enterText(
          context.world.driver, locator, usercode);
    },
  );
}
