import 'package:flutter/material.dart';

// Models
import '../models/tab_item_model.dart';

// Widgets
import '../widgets/home_app_bar.dart';
import '../../profile/widgets/profile_tabs/activities_tab_view.dart';
import '../../student_finder/screens/student_finder_tab_view.dart';
import '../../timetables/scheduler_tab_view.dart';
import '../../requests/screens/requests_tab_view.dart';
import '../../posts/screens/posts_tab_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _tabs = <TabItemModel>[
      TabItemModel('Posts', Icons.forum_rounded),
      TabItemModel('Friend Requests', Icons.group),
      TabItemModel('Activities', Icons.festival_rounded),
      TabItemModel('Student Finder', Icons.person_search_rounded),
      TabItemModel('Scheduler', Icons.edit_calendar_rounded),
    ];
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      body: DefaultTabController(
        length: _tabs.length,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, _) {
            return <Widget>[
              // Page Name App Bar
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  context,
                ),
                sliver: const HomeAppBar(tabs: _tabs),
              ),
            ];
          },
          body: const TabBarView(
            children: [
              PostsTabView(),
              RequestsTabView(),
              ActivitiesTabView(),
              StudentFinderTabView(),
              SchedulerTabView(),
            ],
          ),
        ),
      ),
    );
  }
}
