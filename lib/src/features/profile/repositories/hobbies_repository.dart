import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Networking
import '../../../core/networking/api_endpoint.dart';
import '../../../core/networking/api_service.dart';

// Models
import '../models/hobby_model.codegen.dart';

// Providers
import '../../all_providers.dart';

// Helpers
import '../../../helpers/typedefs.dart';

final hobbiesRepositoryProvider = Provider<HobbiesRepository>((ref) {
  final _apiService = ref.watch(apiServiceProvider);
  return HobbiesRepository(apiService: _apiService);
});

class HobbiesRepository {
  final ApiService _apiService;

  HobbiesRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<List<HobbyModel>> fetchAll({JSON? queryParameters}) async {
    return _apiService.getCollectionData<HobbyModel>(
      endpoint: ApiEndpoint.hobbies(HobbyEndpoint.BASE),
      queryParams: queryParameters,
      cachePolicy: CachePolicy.forceCache,
      converter: HobbyModel.fromJson,
    );
  }
}
