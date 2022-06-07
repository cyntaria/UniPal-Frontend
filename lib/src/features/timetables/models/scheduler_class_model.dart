import 'subject_model.codegen.dart';

class SchedulerClassModel {
  final SubjectModel? subject;
  final String? teacher;
  final String? timeslot;

  const SchedulerClassModel({
    required this.subject,
    required this.teacher,
    required this.timeslot,
  });

  const SchedulerClassModel.initial()
      : subject = null,
        teacher = null,
        timeslot = null;

  SchedulerClassModel copyWith({
    SubjectModel? subject,
    String? teacher,
    String? timeslot,
  }) {
    return SchedulerClassModel(
      subject: subject ?? this.subject,
      teacher: teacher ?? this.teacher,
      timeslot: timeslot ?? this.timeslot,
    );
  }
}
