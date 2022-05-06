import 'package:flutter/material.dart';

// Widgets
import '../widgets/schedule_generator/scheduler.dart';

class SchedulerTabView extends StatelessWidget {
  const SchedulerTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: CustomScrollView(
        key: const PageStorageKey<String>('Scheduler'),
        slivers: <Widget>[
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),

          // TODO(arafaysaleem): View my timetables link
          // const ViewMyTimetablesButton(),

          // Classes Selector
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverFillRemaining(
              child: Scheduler(),
            ),
          ),
        ],
      ),
    );
  }
}
