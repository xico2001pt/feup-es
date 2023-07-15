import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';
import 'steps/tap_button_n_times_step.dart';
import 'steps/fill_password_input_step.dart';
import 'steps/fill_usercode_input_step.dart';
import 'steps/activity_subsection_is_open_step.dart';
import 'authentication_data.dart';
import 'steps/uncheck_all_activity_filters_step.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [Glob(r"test_driver/features/**.feature")]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './test_report.json')
    ]
    ..stepDefinitions = [
      TapButtonNTimesStep(),
      FillPasswordStep(password),
      FillUsercodeStep(usercode),
      ActivitySubsectionIsOpenStep(),
      UncheckAllActivityFiltersStep()
    ]
    ..customStepParameterDefinitions = []
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test_driver/app.dart";
  return GherkinRunner().execute(config);
}
