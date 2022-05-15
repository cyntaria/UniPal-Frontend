import 'package:flutter/material.dart';

// Widgets
import '../widgets/teachers/search_bar.dart';
import '../widgets/teachers/teachers_list.dart';

class TeachersTabView extends StatelessWidget {
  const TeachersTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: CustomScrollView(
        key: const PageStorageKey<String>('Review Finder'),
        slivers: <Widget>[
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),

          // Search bar
          const SliverToBoxAdapter(
            child: SearchBar(),
          ),

          // Posts List
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverFillRemaining(
              child: TeachersList(),
            ),
          ),
        ],
      ),
    );
  }
}
