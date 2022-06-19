import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/generated_timetable_model.codegen.dart';

// Providers
import '../providers/timetables_provider.dart';

// Helpers
import '../../../helpers/constants/app_styles.dart';

// Routing
import '../../../config/routes/app_router.dart';

// Enums
import '../enums/day_enum.dart';

// Widgets
import '../../shared/widgets/async_value_widget.dart';
import '../../shared/widgets/custom_circular_loader.dart';
import '../../shared/widgets/empty_state_widget.dart';
import '../../shared/widgets/error_response_handler.dart';
import '../widgets/timetable_viewer/timetable_view.dart';
import '../widgets/timetables_list/timetable_list_item.dart';

class GeneratedTimetablesScreen extends ConsumerWidget {
  final GeneratedTimetableModel generatedTimetableModel;

  const GeneratedTimetablesScreen({
    super.key,
    required this.generatedTimetableModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generated Timetables'),
      ),
      body: AsyncValueWidget<List<GeneratedTimetableJSON>>(
        value: ref.watch(generatedTimetablesProvider(generatedTimetableModel)),
        loading: () => const Center(
          child: CustomCircularLoader(),
        ),
        error: (error, st) => ErrorResponseHandler(
          error: error,
          retryCallback: () => ref.refresh(
            generatedTimetablesProvider(generatedTimetableModel),
          ),
          stackTrace: st,
        ),
        showEmptyOnNotFoundError: true,
        emptyOrNull: () => const EmptyStateWidget(
          height: 395,
          width: double.infinity,
          margin: EdgeInsets.only(top: 20),
          title: 'No schedule combinations possible',
        ),
        data: (timetables) => ListView.separated(
          itemCount: timetables.length,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          separatorBuilder: (_, __) => Insets.gapH15,
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
          itemBuilder: (_, i) {
            final timetable = timetables[i];
            final title = 'Timetable Number ${i + 1}';
            return TimetableListItem(
              title: title,
              timetable: timetable,
              onTap: () {
                AppRouter.push(
                  TimetableView(
                    timetable: timetable,
                    title: title,
                    classModelGetter: (weekDayIndex, timeslotIndex) {
                      final weekDay = Day.values[weekDayIndex].toJson;
                      if (timetable.containsKey(weekDay)) {
                        final weekDayMap = timetable[weekDay]!;
                        final timeslot = '${timeslotIndex + 1}';
                        if (weekDayMap.containsKey(timeslot)) {
                          return weekDayMap[timeslot];
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
      ),
    );
  }
}
