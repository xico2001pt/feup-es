import 'package:flutter_test/flutter_test.dart';
import 'package:uni/model/activities_page_model.dart';
import 'package:uni/model/entities/activity.dart';

void main() {
  group('Activites Page Model', () {
    final List<Activity> activities = [
      Activity('ES', 'Kahoot #3', DateTime(2022, 4, 1),DateTime(2022, 5, 10, 10, 50)),
      Activity('TCOMP', 'Checkpoint 54', DateTime(2022, 4, 2, 10, 10, 50), DateTime(2025, 5, 3, 10, 10, 50)),
      Activity('COMP', 'Checkpoint 51', DateTime(2024, 4, 2, 10, 10, 50), DateTime(2025, 5, 3, 10, 10, 50)),
      Activity('IA', 'Checkpoint 52', DateTime(2024, 4, 2, 10, 10, 50), DateTime(2025, 5, 12, 10, 10, 50)),
      Activity('CPD', 'Checkpoint 53', DateTime(2022, 4, 2, 10, 10, 50), DateTime(2025, 5, 15, 10, 10, 50))
    ];

    test('Non overlapping occuring and future activities', () async {
      ActivitiesPage page = ActivitiesPage();
      final state = page.createState();
      final List<List<Activity>> aggActivities = state.groupActivitiesByStatus(activities);
      final Set set0 = aggActivities[0].toSet();
      final Set set1 = aggActivities[1].toSet();
      expect(set0.intersection(set1).length, 0);
    });

    test('Activities in appropriate category', () async {
      ActivitiesPage page = ActivitiesPage();
      final state = page.createState();
      final List<List<Activity>> aggActivities = state.groupActivitiesByStatus(activities);
      for(var act in aggActivities[0]){
        expect(act.isOccuring(), true);
        expect(act.isFuture(), false);
      }
      for(var act in aggActivities[1]){
        expect(act.isFuture(), true);
        expect(act.isOccuring(), false);
      }
    });
  });
}
