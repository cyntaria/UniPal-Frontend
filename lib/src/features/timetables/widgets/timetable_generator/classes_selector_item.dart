import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../../../teacher_reviews/models/teacher_model.codegen.dart';
import '../../models/class_model.codegen.dart';
import '../../models/timeslot_model.codegen.dart';
import '../../models/subject_model.codegen.dart';

// Providers
import '../../providers/scheduler_provider.dart';

// Helpers
import '../../../../helpers/constants/app_styles.dart';

// Widgets
import '../../../shared/widgets/custom_dropdown_field.dart';
import '../../../shared/widgets/custom_dropdown_sheet.dart';
import '../../../shared/widgets/labeled_widget.dart';
import '../../../shared/widgets/dropdown_sheet_item.dart';

final _selectedSubjectProvider = StateProvider.family<SubjectModel?, int>(
  (_, index) => null,
);

final _selectedTeacherProvider = StateProvider.family<TeacherModel?, int>(
  (_, index) => null,
);

final _selectedTimeslotProvider = StateProvider.family<TimeslotModel?, int>(
  (_, index) => null,
);

final _subjectClassesProvider = Provider.family<List<ClassModel>, int>(
  (ref, index) {
    final subjectCode = ref.watch(_selectedSubjectProvider(index))?.subjectCode;
    return ref.watch(schedulerProvider).getClassesBySubject(subjectCode ?? '');
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
    return Column(
      children: [
        // Remove Button
        if (index != 0)
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                ref
                    .read(classSelectorCountProvider.notifier)
                    .update((state) => state - 1);
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
              Consumer(
                builder: (_, ref, __) {
                  final subjects =
                      ref.watch(schedulerProvider).getScheduleSubjects();
                  return LabeledWidget(
                    label: 'Subject',
                    labelDirection: Axis.horizontal,
                    useDarkerLabel: true,
                    expand: true,
                    child: CustomDropdownField<SubjectModel?>.sheet(
                      initialValue: ref.watch(_selectedSubjectProvider(index)),
                      selectedItemText: (item) => item?.subject ?? '',
                      itemsSheet: CustomDropdownSheet(
                        showSearch: true,
                        bottomSheetTitle: 'Subjects',
                        items: subjects,
                        onItemSelect: (subject) {
                          ref
                              .read(_selectedSubjectProvider(index).notifier)
                              .update((_) => subject);
                        },
                        searchFilterCondition: (searchTerm, item) {
                          return item!.subject
                              .toLowerCase()
                              .contains(searchTerm);
                        },
                        itemBuilder: (_, item) => DropdownSheetItem(
                          label: item?.subject ?? '',
                        ),
                      ),
                    ),
                  );
                },
              ),

              // Teacher Dropdown
              Consumer(
                builder: (_, ref, __) {
                  final subjectClasses =
                      ref.watch(_subjectClassesProvider(index));
                  final teachers =
                      subjectClasses.map((e) => e.teacher).toList();
                  return LabeledWidget(
                    label: 'Teacher',
                    labelDirection: Axis.horizontal,
                    useDarkerLabel: true,
                    expand: true,
                    child: CustomDropdownField<TeacherModel?>.sheet(
                      initialValue: ref.watch(_selectedTeacherProvider(index)),
                      selectedItemText: (item) => item?.fullName ?? '',
                      itemsSheet: CustomDropdownSheet(
                        bottomSheetTitle: 'Teachers',
                        items: teachers,
                        onItemSelect: (teacher) {
                          ref
                              .read(_selectedTeacherProvider(index).notifier)
                              .update((_) => teacher);
                        },
                        itemBuilder: (_, item) => DropdownSheetItem(
                          label: item?.fullName ?? '',
                        ),
                      ),
                    ),
                  );
                },
              ),

              // Timeslot Dropdown
              Consumer(
                builder: (_, ref, __) {
                  final subjectClasses =
                      ref.watch(_subjectClassesProvider(index));
                  final teacher = ref.watch(_selectedTeacherProvider(index));
                  final teacherClasses = subjectClasses
                      .where((e) => e.teacher == teacher)
                      .toList();
                  final timeslots =
                      teacherClasses.map((e) => e.timeslot1).toList();
                  return LabeledWidget(
                    label: 'Timeslot',
                    labelDirection: Axis.horizontal,
                    useDarkerLabel: true,
                    expand: true,
                    child: CustomDropdownField<TimeslotModel?>.sheet(
                      initialValue: ref.watch(_selectedTimeslotProvider(index)),
                      selectedItemText: (item) => item?.toString() ?? '',
                      itemsSheet: CustomDropdownSheet(
                        bottomSheetTitle: 'Timeslots',
                        items: timeslots,
                        onItemSelect: (timeslot) {
                          ref
                              .read(_selectedTimeslotProvider(index).notifier)
                              .update((_) => timeslot);
                        },
                        itemBuilder: (_, item) => DropdownSheetItem(
                          label: item?.toString() ?? '',
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
