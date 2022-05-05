import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/scheduler_class_model.dart';

// Providers
import '../providers/scheduler_provider.dart';

// Helpers
import '../../../helpers/constants/app_styles.dart';

// Widgets
import '../../shared/widgets/custom_dropdown_field.dart';
import '../../shared/widgets/custom_dropdown_sheet.dart';
import '../../shared/widgets/labeled_widget.dart';
import 'dropdown_sheet_item.dart';

final _selectedClassProvider =
    Provider.family.autoDispose<SchedulerClassModel, int>(
  (ref, index) {
    return ref.watch(schedulerProvider)[index];
  },
);

class SchedulerClassItem extends ConsumerWidget {
  final int index;

  const SchedulerClassItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cls = ref.watch(_selectedClassProvider(index));
    return Container(
      width: double.infinity,
      height: 260,
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        borderRadius: Corners.rounded15,
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Subject Dropdown
          LabeledWidget(
            label: 'Subject',
            labelDirection: Axis.horizontal,
            useDarkerLabel: true,
            child: CustomDropdownField<String>.sheet(
              selectedItemText: (item) => item,
              itemsSheet: CustomDropdownSheet(
                showSearch: true,
                bottomSheetTitle: 'Subjects',
                items: const [
                  'Data Mining',
                  'Data Warehousing',
                  'Business Intelligence',
                  'Introduction to Economics',
                  'Discrete Mathematics',
                  'Financial Accounting',
                  'Organizational Behaviour',
                  'History Of Ideas',
                  'Academic Writing',
                ],
                onItemSelect: (subject) {
                  ref
                      .read(schedulerProvider.notifier)
                      .updateClass(index, cls.copyWith(subject: subject));
                },
                itemBuilder: (_, item) => DropdownSheetItem(label: item),
              ),
            ),
          ),

          // Teacher Dropdown
          LabeledWidget(
            label: 'Teacher',
            labelDirection: Axis.horizontal,
            useDarkerLabel: true,
            child: CustomDropdownField<String>.sheet(
              selectedItemText: (item) => item,
              itemsSheet: CustomDropdownSheet(
                bottomSheetTitle: 'Teachers',
                items: const [
                  'Shakeel Khoja',
                  'Maria Rahim',
                  'Sami Ul Ahbab',
                ],
                onItemSelect: (teacher) {
                  ref
                      .read(schedulerProvider.notifier)
                      .updateClass(index, cls.copyWith(teacher: teacher));
                },
                itemBuilder: (_, item) => DropdownSheetItem(label: item),
              ),
            ),
          ),

          // Timeslot Dropdown
          LabeledWidget(
            label: 'Timeslot',
            labelDirection: Axis.horizontal,
            useDarkerLabel: true,
            child: CustomDropdownField<String>.sheet(
              selectedItemText: (item) => item,
              itemsSheet: CustomDropdownSheet(
                bottomSheetTitle: 'Timeslots',
                items: const [
                  '08:30',
                  '10:00',
                  '11:30',
                  '01:00',
                  '02:30',
                  '04:00',
                  '05:30',
                ],
                onItemSelect: (timeslot) {
                  ref
                      .read(schedulerProvider.notifier)
                      .updateClass(index, cls.copyWith(timeslot: timeslot));
                },
                itemBuilder: (_, item) => DropdownSheetItem(label: item),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
