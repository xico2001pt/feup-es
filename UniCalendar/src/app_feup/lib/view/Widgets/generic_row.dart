import 'package:flutter/material.dart';
import 'package:uni/view/Widgets/row_container.dart';

class GenericRow extends StatelessWidget {
  final Widget _left;
  final Widget _center;
  final Widget _right;
  final double _paddingDelta;

  GenericRow(
      {Key key,
      Widget left,
      Widget center,
      Widget right,
      double topBottomPaddingDelta = 0})
      : this._left = left,
        this._center = center,
        this._right = right,
        this._paddingDelta = topBottomPaddingDelta,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RowContainer(
      color: Theme.of(context).backgroundColor,
      child: Container(
        padding: EdgeInsets.only(left: 11, right: 11, top: 11 + this._paddingDelta, bottom: 11 + this._paddingDelta),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: this._left
            ),
            Align(
              alignment: Alignment.center,
              child: this._center
            ),
            Align(
              alignment: Alignment.centerRight,
              child: this._right
            )
          ]
        )
      )
    );
  }
}
