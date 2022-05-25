import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Networking
import '../../../core/networking/api_endpoint.dart';
import '../../../core/networking/api_service.dart';

// Models
import '../models/term_model.codegen.dart';

// Providers
import '../../all_providers.dart';

// Helpers
import '../../../helpers/typedefs.dart';

final termsRepositoryProvider = Provider<TermsRepository>((ref) {
  final _apiService = ref.watch(apiServiceProvider);
  return TermsRepository(apiService: _apiService);
});

class TermsRepository {
  final ApiService _apiService;

  TermsRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<List<TermModel>> fetchAll({JSON? queryParameters}) async {
    return _apiService.getCollectionData<TermModel>(
      endpoint: ApiEndpoint.terms(TermEndpoint.BASE),
      queryParams: queryParameters,
      cachePolicy: CachePolicy.forceCache,
      cacheAgeDays: 90,
      converter: TermModel.fromJson,
    );
  }
}
