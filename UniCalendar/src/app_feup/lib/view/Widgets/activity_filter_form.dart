import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/redux/action_creators.dart';

class ActivityFilterForm extends StatefulWidget {
  final Map<String, bool> filteredActivities;

  ActivityFilterForm(this.filteredActivities);
  @override
  _ActivityFilterFormState createState() => _ActivityFilterFormState();
}

class _ActivityFilterFormState extends State<ActivityFilterForm> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Definições Filtro de Atividades'),
      actions: [
        TextButton(child: Text('Cancelar'), onPressed: () => Navigator.pop(context)),
        ElevatedButton(
            key: Key('ActivitiesFilterConfirmButton'),
            child: Text('Confirmar'),
            onPressed: () {
              StoreProvider.of<AppState>(context).dispatch(setFilteredActivitites(widget.filteredActivities, Completer()));
              Navigator.pop(context);
            })
      ],
      content: Container(height: 300.0, width: 200.0, child: getActivitiesCheckboxes(widget.filteredActivities, context)),
    );
  }

  Widget getActivitiesCheckboxes(Map<String, bool> filteredActivities, BuildContext context) {
    return ListView(
        key: Key('ActivityFilterCheckboxList'),
        children: List.generate(filteredActivities.length, (i) {
      final String key = filteredActivities.keys.elementAt(i);
      return CheckboxListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text(
            key,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            maxLines: 2,
          ),
          key: Key('ActivityCheck' + i.toString()),
          value: filteredActivities[key],
          onChanged: (value) {
            setState(() {
              filteredActivities[key] = value;
            });
          });
    }));
  }
}
