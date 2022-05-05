class SchedulerClassModel {
  final String subject;
  final String teacher;
  final String timeslot;

  const SchedulerClassModel({
    required this.subject,
    required this.teacher,
    required this.timeslot,
  });

  const SchedulerClassModel.initial()
      : subject = '',
        teacher = '',
        timeslot = '';

  SchedulerClassModel copyWith({
    String? subject,
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
