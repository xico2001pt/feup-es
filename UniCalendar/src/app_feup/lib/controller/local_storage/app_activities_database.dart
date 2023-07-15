import 'dart:async';
import 'package:uni/controller/local_storage/app_database.dart';
import 'package:uni/model/entities/activity.dart';
import 'package:sqflite/sqflite.dart';

/// Manages the app's Activities database.
///
/// This database stores information about the user's activities.
/// See the [Activity] class to see what data is stored in this database.
class AppActivitiesDatabase extends AppDatabase {
  AppActivitiesDatabase()
      : super('activity.db', [
          '''CREATE TABLE activities(courseUnit TEXT, description TEXT, start INT, end INT)'''
        ]);

  /// Replaces all of the data in this database with [activities].
  saveNewActivities(List<Activity> activities) async {
    await deleteActivities();
    await _insertActivities(activities);
  }

  /// Returns a list containing all of the activities stored in this database.
  Future<List<Activity>> activities() async {
    // Get a reference to the database
    final Database db = await this.getDatabase();

    // Query the table for All The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('activities');

    // Convert the List<Map<String, dynamic> into a List<Activity>.
    return List.generate(maps.length, (i) {
      return Activity(
          maps[i]['courseUnit'],
          maps[i]['description'],
          DateTime.fromMillisecondsSinceEpoch(maps[i]['start']),
          DateTime.fromMillisecondsSinceEpoch(maps[i]['end']));
    });
  }

  /// Adds all items from [activities] to this database.
  ///
  /// If a row with the same data is present, it will be replaced.
  Future<void> _insertActivities(List<Activity> activities) async {
    for (Activity activity in activities) {
      Map<String, dynamic> map = activity.toMap();
      map['start'] = map['start'].millisecondsSinceEpoch;
      map['end'] = map['end'].millisecondsSinceEpoch;
      await insertInDatabase(
        'activities',
        map,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  /// Deletes all of the data stored in this database.
  Future<void> deleteActivities() async {
    // Get a reference to the database
    final Database db = await this.getDatabase();

    await db.delete('activities');
  }
}
