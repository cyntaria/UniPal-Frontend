import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/student_status_model.codegen.dart';

// Repositories
import '../repositories/student_statuses_repository.dart';

final studentStatusByIdProvider = Provider.family<StudentStatusModel, int>(
  (ref, id) {
    return ref.watch(studentStatusesProvider).getStudentStatusById(id);
  },
);

final studentStatusesProvider = Provider<StudentStatusesProvider>((ref) {
  final _studentStatusesRepository = ref.watch(
    studentStatusesRepositoryProvider,
  );
  return StudentStatusesProvider(_studentStatusesRepository);
});

class StudentStatusesProvider {
  final StudentStatusesRepository _studentStatusesRepository;

  late final Map<int, StudentStatusModel> _studentStatusesMap;

  StudentStatusesProvider(this._studentStatusesRepository);

  Future<void> loadStudentStatusesInMemory() async {
    final studentStatuses = await _studentStatusesRepository.fetchAll();
    _studentStatusesMap = {for (var e in studentStatuses) e.studentStatusId: e};
  }

  UnmodifiableListView<StudentStatusModel> getAllStudentStatuses() {
    return UnmodifiableListView(_studentStatusesMap.values);
  }

  StudentStatusModel getStudentStatusById(int id) {
    return _studentStatusesMap[id]!;
  }
}
