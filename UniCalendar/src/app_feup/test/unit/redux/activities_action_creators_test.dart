import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tuple/tuple.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/course.dart';
import 'package:uni/model/entities/activity.dart';
import 'package:uni/model/entities/course_unit.dart';
import 'package:uni/model/entities/profile.dart';
import 'package:uni/model/entities/session.dart';
import 'package:uni/redux/action_creators.dart';
import 'package:intl/intl.dart';

import 'action_creators.dart';

void main() {
  group('Activities Action Creator', () {
    final fetcherMock = MockActivitiesFetcher();
    final Tuple2<String, String> userPersistentInfo = Tuple2('', '');
    final mockStore = MockStore();

    final profile = Profile();
    profile.courses = [Course(id: 7474)];
    final content = {
      'session': Session(authenticated: true),
      'profile': profile,
      'currUcs': [
        CourseUnit(name:'Course 1', abbreviation: 'C1'),
        CourseUnit(name:'Course 2', abbreviation: 'C2')
      ],
      'filteredActivities': <String, bool>{}
    };

    final Activity activity1 = Activity('C1', 'D1',
      DateFormat('dd/MM/yy H:m').parse('01/01/1970 08:30'),
      DateFormat('dd/MM/yy H:m').parse('02/02/1970 23:59'));

    final Activity activity2 = Activity('C2', 'D2',
      DateFormat('dd/MM/yy H:m').parse('01/01/1971 08:30'),
      DateFormat('dd/MM/yy H:m').parse('02/02/1971 23:59'));

    final Activity activity3 = Activity('C3', 'D2', // User not in UC 'C3'
      DateFormat('dd/MM/yy H:m').parse('01/01/1971 08:30'),
      DateFormat('dd/MM/yy H:m').parse('02/02/1971 23:59'));

    when(mockStore.state).thenReturn(AppState(content));
    test('When given activities', () async {
      final Completer<Null> completer = Completer();
      final actionCreator =
          getUserActivities(completer, userPersistentInfo, fetcher: fetcherMock);
      when(fetcherMock.getActivities(any))
          .thenAnswer((_) async => [activity1, activity2, activity3]);

      actionCreator(mockStore);
      await completer.future;
      final List<dynamic> actions =
          verify(mockStore.dispatch(captureAny)).captured;
      expect(actions.length, 4);
      expect(actions[0].status, RequestStatus.busy);
      expect(actions[1].filteredActivities, {'Course 1': true, 'Course 2': true});
      expect(actions[2].activities, [activity1, activity2]);
      expect(actions[3].status, RequestStatus.successful);
    });
    test('When an error occurs while trying to obtain the activities', () async {
      final Completer<Null> completer = Completer();
      final actionCreator =
          getUserActivities(completer, userPersistentInfo, fetcher: fetcherMock);
      when(fetcherMock.getActivities(any))
          .thenAnswer((_) async => throw Exception('💥'));

      actionCreator(mockStore);
      await completer.future;
      final List<dynamic> actions =
          verify(mockStore.dispatch(captureAny)).captured;
      expect(actions.length, 2);
      expect(actions[0].status, RequestStatus.busy);
      expect(actions[1].status, RequestStatus.failed);
    });
  });

  group('Filters Action Creator', () {
    final fetcherMock = MockActivitiesFetcher();
    final Tuple2<String, String> userPersistentInfo = Tuple2('', '');
    final mockStore = MockStore();

    final profile = Profile();
    profile.courses = [Course(id: 7474)];

    test('By default all filters are active', () async {
      final content = {
        'session': Session(authenticated: true),
        'profile': profile,
        'currUcs': [
          CourseUnit(name:'Course 1', abbreviation: 'C1'),
          CourseUnit(name:'Course 2', abbreviation: 'C2'),
          CourseUnit(name:'Course 3', abbreviation: 'C3'),
        ],
        'filteredActivities': <String, bool>{}
      };
      when(mockStore.state).thenReturn(AppState(content));

      final Completer<Null> completer = Completer();
      final actionCreator =
          getUserActivities(completer, userPersistentInfo, fetcher: fetcherMock);
      when(fetcherMock.getActivities(any))
          .thenAnswer((_) async => []);

      actionCreator(mockStore);
      await completer.future;
      final List<dynamic> actions =
          verify(mockStore.dispatch(captureAny)).captured;
      expect(actions.length, 4);
      expect(actions[0].status, RequestStatus.busy);
      expect(actions[1].filteredActivities, {
        'Course 1': true, 'Course 2': true, 'Course 3': true
        });
      expect(actions[2].activities, []);
      expect(actions[3].status, RequestStatus.successful);
    });

    test('If theres any filteredActivities the remaining filters are turned off', () async {
      final content = {
        'session': Session(authenticated: true),
        'profile': profile,
        'currUcs': [
          CourseUnit(name:'Course 1', abbreviation: 'C1'),
          CourseUnit(name:'Course 2', abbreviation: 'C2'),
          CourseUnit(name:'Course 3', abbreviation: 'C3'),
        ],
        'filteredActivities': <String, bool>{'Course 1': true}
      };
      when(mockStore.state).thenReturn(AppState(content));

      final Completer<Null> completer = Completer();
      final actionCreator =
          getUserActivities(completer, userPersistentInfo, fetcher: fetcherMock);
      when(fetcherMock.getActivities(any))
          .thenAnswer((_) async => []);

      actionCreator(mockStore);
      await completer.future;
      final List<dynamic> actions =
          verify(mockStore.dispatch(captureAny)).captured;
      expect(actions.length, 4);
      expect(actions[0].status, RequestStatus.busy);
      expect(actions[1].filteredActivities, {
        'Course 1': true, 'Course 2': false, 'Course 3': false
        });
      expect(actions[2].activities, []);
      expect(actions[3].status, RequestStatus.successful);
    });

  });
}
