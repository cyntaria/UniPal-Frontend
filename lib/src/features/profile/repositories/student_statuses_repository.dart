import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Networking
import '../../../core/networking/api_endpoint.dart';
import '../../../core/networking/api_service.dart';

// Models
import '../models/student_status_model.codegen.dart';

// Providers
import '../../all_providers.dart';

// Helpers
import '../../../helpers/typedefs.dart';

final studentStatusesRepositoryProvider = Provider<StudentStatusesRepository>((ref) {
  final _apiService = ref.watch(apiServiceProvider);
  return StudentStatusesRepository(apiService: _apiService);
});

class StudentStatusesRepository {
  final ApiService _apiService;

  StudentStatusesRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<List<StudentStatusModel>> fetchAll({JSON? queryParameters}) async {
    return _apiService.getCollectionData<StudentStatusModel>(
      endpoint: ApiEndpoint.studentStatuses(StudentStatusEndpoint.BASE),
      queryParams: queryParameters,
      cachePolicy: CachePolicy.request,
      cacheAgeDays: 15,
      converter: StudentStatusModel.fromJson,
    );
  }
}
