import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/view/Widgets/activity_filter_form.dart';

// ignore: must_be_immutable
class ActivityFilterMenu extends StatefulWidget {
  @override
  _ActivityFilterMenuState createState() => _ActivityFilterMenuState();
}

class _ActivityFilterMenuState extends State<ActivityFilterMenu> {
  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StoreConnector<AppState, Map<String, bool>>(
            converter: (store) => store.state.content['filteredActivities'],
            builder: (context, filteredActivities) {
              return getAlertDialog(filteredActivities, context);
            });
      },
    );
  }

  Widget getAlertDialog(Map<String, bool> filteredActivities, 
    BuildContext context) {
    return ActivityFilterForm(Map<String, bool>.from(filteredActivities));
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: Key('ActivitiesFiltersPopup'),
      icon: Icon(Icons.settings),
      onPressed: () {
        showAlertDialog(context);
      },
    );
  }
}
