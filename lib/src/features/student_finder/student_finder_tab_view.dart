import 'package:flutter/material.dart';

// Widgets
import 'search_bar.dart';
import 'students_grid_list.dart';

class StudentFinderTabView extends StatelessWidget {
  const StudentFinderTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: CustomScrollView(
        key: const PageStorageKey<String>('Student Finder'),
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
            sliver: StudentsGridList(),
          ),
        ],
      ),
    );
  }
}
