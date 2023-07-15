import 'package:tuple/tuple.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/model/entities/course_unit.dart';
import 'package:uni/view/Pages/activities_page_view.dart';
import 'package:uni/view/Pages/secondary_page_view.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({Key key}) : super(key: key);

  @override
  _ActivitiesPageState createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends SecondaryPageViewState
    with SingleTickerProviderStateMixin {
  TabController tabController;
  ScrollController scrollViewController;

  final List<String> activitiesGroups = [
    'A Decorrer',
    'Atividades futuras'
  ];

  List<List<Activity>> groupActivitiesByStatus(List<Activity> activities) {
    final aggActivities = <List<Activity>>[];
    final ongoingActivities = <Activity>[];
    final futureActivities = <Activity>[];

    for (int i = 0; i < activities.length; ++i){
      if(activities[i].isFuture()){
        futureActivities.add(activities[i]);
      }
      else if(activities[i].isOccuring()){
        ongoingActivities.add(activities[i]);
      }
    }
    aggActivities.add(ongoingActivities);
    aggActivities.add(futureActivities);
    return aggActivities;
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: activitiesGroups.length);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget getBody(BuildContext context) {
    return StoreConnector<AppState, Tuple4<
          List<Activity>, RequestStatus, Map<String, bool>, List<CourseUnit>
        >>(
      converter: (store) => Tuple4(
          store.state.content['activities'], 
          store.state.content['activitiesStatus'],
          store.state.content['filteredActivities'],
          store.state.content['currUcs']),
      builder: (context, activitiesData) {
        final List<Activity> activities = List.from(activitiesData.item1);
        final RequestStatus status = activitiesData.item2;
        final Map<String, bool> activitiesFilter = activitiesData.item3;
        final Map<String, String> ucAbbreviationToName = Map.fromIterable(
          activitiesData.item4,
           key: (uc) => uc.abbreviation,
           value: (uc) => uc.name);

        activities.removeWhere((item) => 
            !activitiesFilter.containsKey(ucAbbreviationToName[item.getCourseUnit()]) ||
            activitiesFilter[ucAbbreviationToName[item.getCourseUnit()]] == false
          );
        return ActivitiesPageView(
            tabController: tabController,
            scrollViewController: scrollViewController,
            activitiesGroups: activitiesGroups,
            activitiesStatus: status,
            aggActivities: groupActivitiesByStatus(activities),
          );
      },
    );
  }
}
