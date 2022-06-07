import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/class_model.codegen.dart';

// Helpers
import '../../../helpers/typedefs.dart';

// Repositories
import '../repositories/classes_repository.dart';

final classesProvider = Provider((ref) {
  return ClassesProvider(ref.watch(classesRepositoryProvider));
});

class ClassesProvider {
  final ClassesRepository _classesRepository;

  ClassesProvider(this._classesRepository);

  Future<List<ClassModel>> getAllClasses([JSON? queryParams]) async {
    return _classesRepository.fetchAllClasses(
      queryParameters: queryParams,
    );
  }

  Future<ClassModel> getSingleClass({
    required String classErp,
    required int termId,
  }) async {
    return _classesRepository.fetchOne(erp: classErp, termId: termId);
  }
}
