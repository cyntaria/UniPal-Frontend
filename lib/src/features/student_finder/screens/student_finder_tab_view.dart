import 'package:flutter/material.dart';

// Widgets
import '../widgets/finder/search_and_filter_bar.dart';
import '../widgets/finder/students_grid_list.dart';

class StudentFinderTabView extends StatelessWidget {
  const StudentFinderTabView({super.key});

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
            child: SearchAndFilterBar(),
          ),

          // Posts List
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverFillRemaining(
              child: StudentsGridList(),
            ),
          ),
        ],
      ),
    );
  }
}
