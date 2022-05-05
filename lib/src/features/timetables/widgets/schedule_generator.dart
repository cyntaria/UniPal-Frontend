import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../providers/scheduler_provider.dart';

// Helpers
import '../../../helpers/constants/app_styles.dart';

// Widgets
import 'scheduler_class_item.dart';

class ScheduleGenerator extends ConsumerWidget {
  const ScheduleGenerator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noOfSelectedClasses = ref.watch(
      schedulerProvider.select((value) => value.length),
    );
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      itemCount: noOfSelectedClasses,
      separatorBuilder: (_, i) => Insets.gapH20,
      itemBuilder: (_, i) => SchedulerClassItem(index: i),
    );
  }
}
