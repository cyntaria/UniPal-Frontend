import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Networking
import '../../../core/networking/api_endpoint.dart';
import '../../../core/networking/api_service.dart';

// Models
import '../models/interest_model.codegen.dart';

// Providers
import '../../all_providers.dart';

// Helpers
import '../../../helpers/typedefs.dart';

final interestsRepositoryProvider = Provider<InterestsRepository>((ref) {
  final _apiService = ref.watch(apiServiceProvider);
  return InterestsRepository(apiService: _apiService);
});

class InterestsRepository {
  final ApiService _apiService;

  InterestsRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<List<InterestModel>> fetchAll({JSON? queryParameters}) async {
    return _apiService.getCollectionData<InterestModel>(
      endpoint: ApiEndpoint.interests(InterestEndpoint.BASE),
      queryParams: queryParameters,
      cachePolicy: CachePolicy.forceCache,
      converter: InterestModel.fromJson,
    );
  }
}
