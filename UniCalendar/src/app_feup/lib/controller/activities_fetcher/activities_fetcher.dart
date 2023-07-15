import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/activity.dart';
import 'package:redux/redux.dart';

// Class for fetching activities
abstract class ActivitiesFetcher {
  Future<List<Activity>> getActivities(Store<AppState> store);
}