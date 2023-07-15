import 'package:flutter/material.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/activity.dart';
import 'package:uni/view/Widgets/activities_page_title_filter.dart';
import 'package:uni/view/Widgets/request_dependent_widget_builder.dart';
import 'package:uni/view/Widgets/activity_primary_row.dart';
import 'package:uni/view/Widgets/activity_secondary_row.dart';

/// Manages the 'activities' sections of the app
class ActivitiesPageView extends StatelessWidget {
  ActivitiesPageView(
      {Key key,
      @required this.tabController,
      @required this.activitiesGroups,
      @required this.activitiesStatus,
      @required this.aggActivities,
      this.scrollViewController});

  final List<String> activitiesGroups;
  final RequestStatus activitiesStatus;
  final List<List<Activity>> aggActivities;
  final TabController tabController;
  final ScrollController scrollViewController;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);

    return Column(children: <Widget>[
      ActivitiesPageTitleFilter(
        name: 'Atividades',
      ),
      TabBar(
        controller: tabController,
        isScrollable: true,
        tabs: createTabs(queryData, context),
      ),     
      Expanded(
        child: 
          TabBarView(
            controller: tabController,
            children: createActivitiesSubsections(context)
          )
        )],
    );
  }

  /// Returns a list of widgets empty with tabs for each option.
  List<Widget> createTabs(queryData, BuildContext context) {
    final List<Widget> tabs = <Widget>[];
    for (var i = 0; i < activitiesGroups.length; i++) {
      tabs.add(Container(
        color: Theme.of(context).backgroundColor,
        width: queryData.size.width / activitiesGroups.length,
        child: Tab(key: Key('activities-page-tab-$i'), text: activitiesGroups[i]),
      ));
    }
    return tabs;
  }

  // Create both activities subsections (Ongoing and future)
  List<Widget> createActivitiesSubsections(queryData){
    final List<Widget> subSections = <Widget>[];
    for(int i = 0; i < aggActivities.length; ++i){
      subSections.add(createActivitySubsection(queryData, i));
    }
    return subSections;
  }

  // Returns an subsection widget with all the corresponding (ongoing/future) activities widgets inside
  Widget createActivitySubsection(BuildContext context, int groupId) {
    return RequestDependentWidgetBuilder(
      context: context,
      status: activitiesStatus,
      contentGenerator: activityGroupColumnBuilder(groupId),
      content: aggActivities[groupId],
      contentChecker: aggActivities[groupId].isNotEmpty,
      key: Key('activities-page-subsection-$groupId'),
      onNullContent:
          Center(child: Text('Não possui atividades.')),
      index: groupId,
    );
  }

  Widget Function(dynamic groupContent, BuildContext context) activityGroupColumnBuilder(
      int groupId) {
    Widget createGroupColumn(groupContent, BuildContext context) {
      return Container(
          key: Key('activities-page-group-column-$groupId'),
          child: ListView(
            padding: EdgeInsets.all(8),
            children: this.createActivitiesRows(groupContent, context),
                ),
        );
    }
    return createGroupColumn;
  }

  List<Widget> createActivitiesRows(activities, BuildContext context){
    final List<Widget> activitiesContent = <Widget>[];
    for(int i = 0; i < activities.length; i++){
      activitiesContent.add(
        Container(
          margin: EdgeInsets.fromLTRB(12, 8, 12, 0),
          child: PrimaryActivityRow(activity: activities[i]),
        )
      );
    }
    return activitiesContent;
  }
}
