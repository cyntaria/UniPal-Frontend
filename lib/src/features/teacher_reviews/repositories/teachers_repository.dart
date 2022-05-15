import 'package:hooks_riverpod/hooks_riverpod.dart';

// Networking
import '../../../core/networking/api_endpoint.dart';
import '../../../core/networking/api_service.dart';

// Models
import '../models/teacher_model.codegen.dart';

// Providers
import '../../all_providers.dart';

// Helpers
import '../../../helpers/typedefs.dart';

final teachersRepositoryProvider = Provider<TeachersRepository>((ref) {
  final _apiService = ref.watch(apiServiceProvider);
  return TeachersRepository(apiService: _apiService);
});

class TeachersRepository {
  final ApiService _apiService;

  TeachersRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<List<TeacherModel>> fetchAll({JSON? queryParameters}) async {
    return _apiService.getCollectionData<TeacherModel>(
      endpoint: ApiEndpoint.teachers(TeacherEndpoint.BASE),
      queryParams: queryParameters,
      converter: TeacherModel.fromJson,
    );
  }
}
