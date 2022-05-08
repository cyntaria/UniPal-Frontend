import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

// Providers
import '../../providers/timeslots_provider.dart';

// Helpers
import '../../../../helpers/typedefs.dart';

// Widgets
import 'timeslot_title.dart';
import 'timetable_class_item.dart';
import 'weekday_title.dart';

typedef ClassModelGetter = JSON? Function(int, int);

class TimetableView extends HookConsumerWidget {
  final JSON timetable;
  final String title;
  final ClassModelGetter classModelGetter;

  const TimetableView({
    Key? key,
    required this.timetable,
    required this.title,
    required this.classModelGetter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController1 = useScrollController();
    final scrollController2 = useScrollController();
    final scrollController3 = useScrollController();
    final scrollController4 = useScrollController();
    const cellHeight = 145.0;
    const cellWidth = 213.0;
    const timeColWidth = 56.0;
    const weekdayRowHeight = 35.0;
    const breakRowHeight = 65.0;
    const breakSlot = 3;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: StickyHeadersTable(
          columnsLength: 6,
          rowsLength: timeslots.length,
          scrollControllers: ScrollControllers(
            horizontalTitleController: scrollController1,
            verticalTitleController: scrollController2,
            horizontalBodyController: scrollController3,
            verticalBodyController: scrollController4,
          ),
          cellDimensions: CellDimensions.variableRowHeight(
            contentCellWidth: cellWidth,
            rowHeights: List.generate(
              timeslots.length,
              (i) => i == breakSlot ? breakRowHeight : cellHeight,
            ),
            stickyLegendWidth: timeColWidth,
            stickyLegendHeight: weekdayRowHeight,
          ),
          legendCell: const SizedBox.shrink(),
          columnsTitleBuilder: (i) => WeekdayTitle(
            weekday: i,
            width: cellWidth,
            height: weekdayRowHeight,
          ),
          rowsTitleBuilder: (i) => TimeslotTitle(
            slotNumber: i + 1,
            height: cellHeight,
            width: timeColWidth,
          ),
          contentCellBuilder: (i, j) => TimetableClassItem(
            classModel: classModelGetter(i, j),
            isBreakSlot: j == breakSlot,
            width: cellWidth,
            height: cellHeight,
          ),
        ),
      ),
    );
  }
}
