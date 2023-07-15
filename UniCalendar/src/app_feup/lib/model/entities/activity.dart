//Stores information about an activity
import 'package:uni/utils/constants.dart' as Constants;

class Activity {
  String _courseUnit;
  String _description;
  DateTime _start;
  DateTime _end;

  Activity(String courseUnit, String description, DateTime start, DateTime end) {
    this._courseUnit = courseUnit;
    this._description = description;
    this._start = start;
    this._end = end;
  }

  String getCourseUnit() {
    return this._courseUnit;
  }

  String getDescription() {
    return this._description;
  }

  DateTime getStart() {
    return this._start;
  }

  DateTime getEnd() {
    return this._end;
  }

  bool isOccuring() {
    final DateTime now = DateTime.now();
    return !(now.isBefore(this._start) || now.isAfter(this._end));
  }

  bool isFuture() {
    return DateTime.now().isBefore(this._start);
  }

  String getHourMinute() {
    return '${this._end.hour.toString().padLeft(2, '0')}:${this._end.minute.toString().padLeft(2, '0')}';
  }

  String getDayMonth() {
    return '${this._end.day}/${Constants.months[this._end.month - 1]}';
  }

  String getWeekDayMonth() {
    return '${Constants.weekDays[this._end.weekday]}, ${this._end.day} de ${Constants.months[this._end.month - 1]}';
  }

  Map<String, dynamic> toMap() {
    return {'courseUnit': this._courseUnit, 'description': this._description, 'start': this._start, 'end': this._end};
  }
}
