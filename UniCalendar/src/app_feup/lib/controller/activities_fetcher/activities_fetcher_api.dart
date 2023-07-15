import 'package:uni/controller/activities_fetcher/activities_fetcher.dart';
import 'package:uni/controller/networking/network_router.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/activity.dart';
import 'package:uni/model/entities/course.dart';
import 'package:redux/redux.dart';

/// Class for fetching the user's activities using gsheet api
class ActivitiesFetcherApi extends ActivitiesFetcher {
  @override
  Future<List<Activity>> getActivities(Store<AppState> store) async {
    final List<Course> courses = store.state.content['profile'].courses;
    final Map<String, String> coursesState = store.state.content['coursesStates'];

    final List<Course> activeCourses = courses.where(
      (c) => coursesState.containsKey(c.name)).toList();

    final List<String> abbreviations = activeCourses.map(
      (c) => c.abbreviation).toList();

    return NetworkRouter.getActivities(abbreviations);
  }
}