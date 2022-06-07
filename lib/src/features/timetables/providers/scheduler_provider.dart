import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/class_model.codegen.dart';
import '../models/subject_model.codegen.dart';

// Providers
import 'classes_provider.dart';

final classSelectorCountProvider = StateProvider((ref) => 0);

final selectedClassesProvider = StateProvider((ref) {
  return <ClassModel>[];
});

final schedulerProvider = Provider<SchedulerProvider>((ref) {
  return SchedulerProvider(ref.read);
});

class SchedulerProvider {
  final _subjectClassesMap = <SubjectModel, List<ClassModel>>{};
  final Reader _read;

  SchedulerProvider(this._read);

  Future<void> loadAllClassesInMemory() async {
    final allClasses = await _read(classesProvider).getAllClasses();

    for (final e in allClasses) {
      _subjectClassesMap.update(
        e.subject,
        (subjectClasses) {
          subjectClasses.add(e);
          return subjectClasses;
        },
        ifAbsent: () => [],
      );
    }
  }

  UnmodifiableListView<ClassModel> getClassesBySubject(String subjectCode) {
    return UnmodifiableListView(_subjectClassesMap[subjectCode] ?? []);
  }

  UnmodifiableListView<SubjectModel> getScheduleSubjects() {
    return UnmodifiableListView(_subjectClassesMap.keys);
  }
}
