import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Networking
import '../../../core/networking/api_endpoint.dart';
import '../../../core/networking/api_service.dart';

// Models
import '../models/activity_type_model.codegen.dart';

// Providers
import '../../all_providers.dart';

// Helpers
import '../../../helpers/typedefs.dart';

final activityTypesRepositoryProvider = Provider<ActivityTypesRepository>((ref) {
  final _apiService = ref.watch(apiServiceProvider);
  return ActivityTypesRepository(apiService: _apiService);
});

class ActivityTypesRepository {
  final ApiService _apiService;

  ActivityTypesRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<List<ActivityTypeModel>> fetchAll({JSON? queryParameters}) async {
    return _apiService.getCollectionData<ActivityTypeModel>(
      endpoint: ApiEndpoint.activityTypes(ActivityTypeEndpoint.BASE),
      queryParams: queryParameters,
      cachePolicy: CachePolicy.forceCache,
      converter: ActivityTypeModel.fromJson,
    );
  }
}
