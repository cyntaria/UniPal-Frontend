import 'package:flutter/material.dart';

// Widgets
import '../widgets/home_app_bar.dart';
import '../../posts/posts_tab_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _tabs = <IconData>[
      Icons.panorama_photosphere,
      Icons.group,
      Icons.festival_rounded,
      Icons.person_search_rounded,
      Icons.edit_calendar_rounded,
    ];
    return Scaffold(
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
                sliver: HomeAppBar(
                  tabs: _tabs.map((icon) => Tab(icon: Icon(icon))).toList(),
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: [
              PostsTabView(),
              PostsTabView(),
              PostsTabView(),
              PostsTabView(),
              PostsTabView(),
            ],
          ),
        ),
      ),
    );
  }
}
