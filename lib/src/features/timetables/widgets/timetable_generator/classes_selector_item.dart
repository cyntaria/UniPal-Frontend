import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../../models/scheduler_class_model.dart';

// Providers
import '../../providers/classes_selector_provider.dart';

// Helpers
import '../../../../helpers/constants/app_styles.dart';

// Widgets
import '../../../shared/widgets/custom_dropdown_field.dart';
import '../../../shared/widgets/custom_dropdown_sheet.dart';
import '../../../shared/widgets/labeled_widget.dart';
import '../../../shared/widgets/dropdown_sheet_item.dart';

final _selectedClassProvider =
    Provider.family.autoDispose<SchedulerClassModel, int>(
  (ref, index) {
    final classes = ref.watch(classesSelectorProvider).selectedClasses;
    return classes[index];
  },
);

class ClassesSelectorItem extends ConsumerWidget {
  final int index;

  const ClassesSelectorItem({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cls = ref.watch(_selectedClassProvider(index));
    return Column(
      children: [
        // Remove Button
        if (index != 0)
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                ref.read(classesSelectorProvider.notifier).removeClass(index);
              },
              child: const Padding(
                padding: EdgeInsets.all(5),
                child: Icon(
                  Icons.close,
                  size: IconSizes.med22,
                ),
              ),
            ),
          ),

        // Class Selectors
        Container(
          width: double.infinity,
          height: 230,
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            borderRadius: Corners.rounded15,
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Subject Dropdown
              LabeledWidget(
                label: 'Subject',
                labelDirection: Axis.horizontal,
                useDarkerLabel: true,
                expand: true,
                child: CustomDropdownField<String>.sheet(
                  initialValue: cls.subject,
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
                          .read(classesSelectorProvider.notifier)
                          .updateClass(index, cls.copyWith(subject: subject));
                    },
                    searchFilterCondition: (searchTerm, item) {
                      return item.toLowerCase().contains(searchTerm);
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
                expand: true,
                child: CustomDropdownField<String>.sheet(
                  initialValue: cls.teacher,
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
                          .read(classesSelectorProvider.notifier)
                          .updateClass(index, cls.copyWith(teacher: teacher));
                    },
                    itemBuilder: (_, teacher) =>
                        DropdownSheetItem(label: teacher),
                  ),
                ),
              ),

              // Timeslot Dropdown
              LabeledWidget(
                label: 'Timeslot',
                labelDirection: Axis.horizontal,
                useDarkerLabel: true,
                expand: true,
                child: CustomDropdownField<String>.sheet(
                  initialValue: cls.timeslot,
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
                          .read(classesSelectorProvider.notifier)
                          .updateClass(index, cls.copyWith(timeslot: timeslot));
                    },
                    itemBuilder: (_, tslot) => DropdownSheetItem(label: tslot),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
