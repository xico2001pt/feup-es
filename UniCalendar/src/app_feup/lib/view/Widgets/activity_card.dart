import 'package:uni/model/entities/activity.dart';
import 'package:uni/model/app_state.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/utils/constants.dart' as Constants;
import 'package:uni/view/Widgets/activity_primary_row.dart';
import 'package:uni/view/Widgets/activity_secondary_row.dart';
import 'package:uni/view/Widgets/request_dependent_widget_builder.dart';

import 'generic_card.dart';

/// Manages the activity card section inside the personal area.
class ActivityCard extends GenericCard {
  ActivityCard({Key key}) : super(key: key);

  ActivityCard.fromEditingInformation(Key key, bool editingMode, Function onDelete)
      : super.fromEditingInformation(key, editingMode, onDelete);

  @override
  String getTitle() => Constants.navActivities;

  @override
  onClick(BuildContext context) =>
      Navigator.pushNamed(context, '/' + Constants.navActivities);

  /// Returns a widget with all the activities card content.
  ///
  /// If there are no activities, a message telling the user
  /// that no activities exist is displayed.
  @override
  Widget buildCardContent(BuildContext context) {
    return StoreConnector<AppState, Tuple2<List<Activity>, RequestStatus>>(
      converter: (store) {
        final Map<String, bool> filteredActivities = store.state.content['filteredActivities'];
        final List<Activity> activities = List.from(store.state.content['activities']);
        
        final Map<String, String> ucAbbreviationToName = Map.fromIterable(
          store.state.content['currUcs'],
           key: (uc) => uc.abbreviation,
           value: (uc) => uc.name);

        activities.removeWhere((item) => 
            !filteredActivities.containsKey(ucAbbreviationToName[item.getCourseUnit()]) ||
            filteredActivities[ucAbbreviationToName[item.getCourseUnit()]] == false
          );
        
        return Tuple2(activities, store.state.content['activitiesStatus']);
      },
      builder: (context, activitiesInfo) => RequestDependentWidgetBuilder(
        key: Key('ActivityCard'),
        context: context,
        status: activitiesInfo.item2,
        contentGenerator: generateActivities,
        content: activitiesInfo.item1,
        contentChecker: activitiesInfo.item1 != null &&
                        activitiesInfo.item1.isNotEmpty,
        onNullContent: Center(
          child: Text('Não existem atividades para apresentar',
              style: Theme.of(context).textTheme.headline4),
        ),
      ),
    );
  }

  /// Returns a widget with all the activities.
  Widget generateActivities(activities, context) {
    return Column(
      children: this.getActivitiesRows(context, activities),
    );
  }

  /// Returns a list of widgets with the primary and secondary activities to
  /// be displayed in the activity card.
  List<Widget> getActivitiesRows(context, activities) {
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < 1 && i < activities.length; i++) {
      rows.add(PrimaryActivityRow(activity: activities[i]));
    }
    if (activities.length > 1) {
      rows.add(Container(
        margin: EdgeInsets.only(right: 80, left: 80, top: 15, bottom: 15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                width: 1.5, color: Theme.of(context).dividerColor
            )
          )
        ),
      ));
    }
    for (int i = 1; i < 2 && i < activities.length; i++) {
      rows.add(SecondaryActivityRow(activity: activities[i]));
    }
    for (int i = 2; i < 4 && i < activities.length; i++) {
      rows.add(SecondaryActivityRow(activity: activities[i], marginTop: 5));
    }
    return rows;
  }
}