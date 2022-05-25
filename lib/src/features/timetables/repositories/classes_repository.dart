import 'package:hooks_riverpod/hooks_riverpod.dart';

// Networking
import '../../../core/networking/api_endpoint.dart';
import '../../../core/networking/api_service.dart';

// Models
import '../models/class_model.codegen.dart';

// Providers
import '../../all_providers.dart';

// Helpers
import '../../../helpers/typedefs.dart';

final classesRepositoryProvider = Provider<ClassesRepository>(
  (ref) {
    final _apiService = ref.watch(apiServiceProvider);
    return ClassesRepository(apiService: _apiService);
  },
);

class ClassesRepository {
  final ApiService _apiService;

  ClassesRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<List<ClassModel>> fetchAllClasses({
    JSON? queryParameters,
  }) async {
    return _apiService.getCollectionData<ClassModel>(
      endpoint: ApiEndpoint.classes(ClassEndpoint.BASE),
      queryParams: queryParameters,
      converter: ClassModel.fromJson,
    );
  }

  Future<ClassModel> fetchOne({
    required String erp,
    required int termId,
  }) async {
    return _apiService.getDocumentData<ClassModel>(
      endpoint: ApiEndpoint.classes(
        ClassEndpoint.BY_TERM_AND_ERP,
        classErp: erp,
        termId: termId,
      ),
      converter: ClassModel.fromJson,
    );
  }
}
