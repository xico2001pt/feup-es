import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric ActivitySubsectionIsOpenStep() {
  return then1<String, FlutterWorld>(
    'I expect the activity subsection {string} to be open',
    (string, context) async {
      int groupId;
      switch(string){
        case 'A Decorrer': groupId=0; break;
        case 'Atividades Futuras': groupId=1; break;
        default: context.expect(true, false);
      }
      
      final sectionLocator = find.byValueKey('activities-page-subsection-$groupId');
      final bool isSectionPresent = await FlutterDriverUtils.isPresent(context.world.driver, sectionLocator);
      context.expect(isSectionPresent, true);
    }
  );
} 