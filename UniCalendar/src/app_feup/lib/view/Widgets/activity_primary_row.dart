import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:uni/model/entities/activity.dart';
import 'package:flutter/material.dart';
import 'package:uni/view/Widgets/date_rectangle.dart';
import 'package:uni/view/Widgets/generic_row.dart';

class PrimaryActivityRow extends StatelessWidget {
  final Activity _activity;

  PrimaryActivityRow({Key key, @required Activity activity})
      : this._activity = activity,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      DateRectangle(date: this._activity.getWeekDayMonth()),
      GenericRow(
          topBottomPaddingDelta: 10,
          left: 
          Container(
              margin: EdgeInsets.only(top: 4.0, bottom: 12.0),
              child: Stack(children: [
                IconButton(
                  padding: EdgeInsets.only(top: 5.0, bottom: 12.0),
                  alignment: Alignment.topLeft,
                  icon: Icon(MdiIcons.calendarPlus, size: 30),
                  onPressed: () {
                    Add2Calendar.addEvent2Cal(this.createActivityEvent());
                  },
                ),
                Container(
                    margin: EdgeInsets.only(top: 60.0, bottom: 45.0),
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                          this._activity.getHourMinute(),
                          style: Theme.of(context).textTheme.headline4)
                        ])
                ),
              ])
          ),
          center: Column(children: [
            Text(this._activity.getCourseUnit(),
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .apply(fontSizeDelta: 10)
            ),
            Text(this._activity.getDescription(),
                style: Theme.of(context).textTheme.headline4)
          ])
        )
    ]);
  }

  createActivityEvent() {
    return Event(
      title: _activity.getCourseUnit() + ' - ' + _activity.getDescription(),
      startDate: _activity.getStart().toLocal(),
      endDate: _activity.getEnd().toLocal(),
    );
  }
}
