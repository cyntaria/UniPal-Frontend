import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../core/networking/custom_exception.dart';
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

class StudentsProvider {
  final StudentsRepository _studentsRepository;

  StudentsProvider({
    required StudentsRepository studentsRepository,
  }) : _studentsRepository = studentsRepository;

  Future<List<StudentModel>> getAllStudents(JSON? queryParams) async {
    try { // TODO(arafaysaleem): handle empty case exceptin
      return _studentsRepository.fetchAll(queryParameters: queryParams);
    } on CustomException catch (ex) {
      if (ex.name == 'NotFoundException') return []; // TODO(arafaysaleem): add status code to CustomException
      rethrow;
    }
  }
}
