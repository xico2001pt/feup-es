import 'package:uni/model/entities/activity.dart';
import 'package:flutter/material.dart';
import 'package:uni/view/Widgets/generic_row.dart';

class SecondaryActivityRow extends StatelessWidget {
  final Activity _activity;
  final double _marginTop;

  SecondaryActivityRow(
      {Key key, @required Activity activity, double marginTop = 0})
      : this._activity = activity,
        this._marginTop = marginTop,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: this._marginTop),
        child: GenericRow(
            left: Column(children: [
              Text(this._activity.isOccuring() ? 'Termina' : 'Inicia',
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .apply(fontSizeDelta: -4)),
              Text(this._activity.getDayMonth(),
                  style: Theme.of(context).textTheme.headline4)
            ]),
            center: Text(this._activity.getDescription(),
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .apply(fontSizeDelta: -4)),
            right: Text(this._activity.getCourseUnit(),
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .apply(fontSizeDelta: 5))));
  }
}
