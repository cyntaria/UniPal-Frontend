import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../providers/timetables_provider.dart';

// Helpers
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/typedefs.dart';

// Routing
import '../../../config/routes/app_router.dart';

// Widgets
import '../widgets/timetable_viewer/timetable_view.dart';
import '../widgets/timetables_list/timetable_list_item.dart';

class GeneratedTimetablesScreen extends ConsumerWidget {
  const GeneratedTimetablesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final generatedTimetables = ref.watch(
      timetablesProvider.select((value) => value.generatedTimetables),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generated Timetables'),
      ),
      body: ListView.separated(
        itemCount: generatedTimetables.length,
        separatorBuilder: (_, __) => Insets.gapH15,
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
        itemBuilder: (_, i) {
          final timetable = generatedTimetables[i];
          final title = 'Timetable Number $i';
          return TimetableListItem(
            title: title,
            timetable: timetable,
            onTap: () {
              AppRouter.push(
                TimetableView(
                  timetable: timetable,
                  title: title,
                  classModelGetter: (weekDayIndex, timeslotIndex) {
                    final weekDay = ref.watch(weekDaysProvider(weekDayIndex));
                    if (timetable.containsKey(weekDay)) {
                      final weekDayMap = timetable[weekDay]! as JSON;
                      final timeslot = '${timeslotIndex + 1}';
                      if (weekDayMap.containsKey(timeslot)) {
                        return weekDayMap[timeslot]! as JSON;
                      }
                    }
                    return null;
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
