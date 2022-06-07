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

final selectorClassesProvider =
    StateProvider.autoDispose.family<List<ClassModel>, int>(
  (_, __) => [],
);

class ClassesSelectorItem extends ConsumerStatefulWidget {
  final int index;

  const ClassesSelectorItem({
    super.key,
    required this.index,
  });

  @override
  ConsumerState<ClassesSelectorItem> createState() =>
      _ClassesSelectorItemState();
}

class _ClassesSelectorItemState extends ConsumerState<ClassesSelectorItem> {
  late final List<SubjectModel> subjects;
  SubjectModel? _selectedSubject;
  TeacherModel? _selectedTeacher;
  TimeslotModel? _selectedTimeslot;
  List<ClassModel> subjectClasses = [];
  List<ClassModel> teacherClasses = [];

  @override
  void initState() {
    super.initState();
    subjects = ref.watch(schedulerProvider).getScheduleSubjects();
  }

  void _selectTimeslot(TimeslotModel? timeslot) {
    setState(() => _selectedTimeslot = timeslot);
    final timeslotClasses = teacherClasses.where((e) {
      return e.timeslot1 == timeslot;
    }).toList();
    ref
        .read(selectorClassesProvider(widget.index).notifier)
        .update((_) => timeslotClasses);
  }

  void _selectTeacher(TeacherModel? teacher) {
    _selectedTeacher = teacher;
    _selectedTimeslot = null;
    teacherClasses = subjectClasses.where((e) {
      return e.teacher == teacher;
    }).toList();
    setState(() {});
    ref
        .read(selectorClassesProvider(widget.index).notifier)
        .update((_) => teacherClasses);
  }

  void _selectSubject(SubjectModel? subject) {
    _selectedSubject = subject;
    _selectedTeacher = null;
    _selectedTimeslot = null;
    subjectClasses = ref
        .watch(schedulerProvider)
        .getClassesBySubject(subject?.subjectCode ?? '');
    setState(() {});
    ref
        .read(selectorClassesProvider(widget.index).notifier)
        .update((_) => subjectClasses);
  }

  void _updateSelectorCount() {
    ref.read(selectorsCountProvider.notifier).update((state) {
      return state - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final teachers = subjectClasses.map((e) => e.teacher).toList();
    final timeslots = teacherClasses.map((e) => e.timeslot1).toList();
    return Column(
      children: [
        // Remove Button
        if (widget.index != 0)
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: _updateSelectorCount,
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
                child: CustomDropdownField<SubjectModel?>.sheet(
                  initialValue: _selectedSubject,
                  selectedItemText: (item) => item?.subject ?? '',
                  itemsSheet: CustomDropdownSheet(
                    showSearch: true,
                    bottomSheetTitle: 'Subjects',
                    items: subjects,
                    onItemSelect: _selectSubject,
                    searchFilterCondition: (searchTerm, item) {
                      return item!.subject.toLowerCase().contains(searchTerm);
                    },
                    itemBuilder: (_, item) => DropdownSheetItem(
                      label: item?.subject ?? '',
                    ),
                  ),
                ),
              ),

              // Teacher Dropdown
              LabeledWidget(
                label: 'Teacher',
                labelDirection: Axis.horizontal,
                useDarkerLabel: true,
                expand: true,
                child: CustomDropdownField<TeacherModel?>.sheet(
                  initialValue: _selectedTeacher,
                  selectedItemText: (item) => item?.fullName ?? '',
                  itemsSheet: CustomDropdownSheet(
                    bottomSheetTitle: 'Teachers',
                    items: teachers,
                    onItemSelect: _selectTeacher,
                    itemBuilder: (_, item) => DropdownSheetItem(
                      label: item?.fullName ?? '',
                    ),
                  ),
                ),
              ),

              // Timeslot Dropdown
              LabeledWidget(
                label: 'Timeslot',
                labelDirection: Axis.horizontal,
                useDarkerLabel: true,
                expand: true,
                child: CustomDropdownField<TimeslotModel?>.sheet(
                  initialValue: _selectedTimeslot,
                  selectedItemText: (item) => item?.toString() ?? '',
                  itemsSheet: CustomDropdownSheet(
                    bottomSheetTitle: 'Timeslots',
                    items: timeslots,
                    onItemSelect: _selectTimeslot,
                    itemBuilder: (_, item) => DropdownSheetItem(
                      label: item?.toString() ?? '',
                    ),
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
