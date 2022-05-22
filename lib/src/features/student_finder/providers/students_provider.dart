import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/typedefs.dart';

// Models
import '../../profile/models/student_model.codegen.dart';

// Repositories
import '../../profile/repositories/students_repository.dart';

final studentsProvider = Provider<StudentsProvider>((ref) {
  final _studentsRepository = ref.watch(studentsRepositoryProvider);
  return StudentsProvider(
    studentsRepository: _studentsRepository,
  );
});

final othersProfileFutureProvider = FutureProvider.family.autoDispose<StudentModel, String>(
  (ref, erp) async => ref.watch(studentsProvider).getStudent(erp),
);

class StudentsProvider {
  final StudentsRepository _studentsRepository;

  StudentsProvider({
    required StudentsRepository studentsRepository,
  }) : _studentsRepository = studentsRepository;

  Future<List<StudentModel>> getAllStudents(JSON? queryParams) async {
    return _studentsRepository.fetchAll(queryParameters: queryParams);
  }

  Future<StudentModel> getStudent(String erp) async {
    return _studentsRepository.fetchOne(erp: erp);
  }
}
