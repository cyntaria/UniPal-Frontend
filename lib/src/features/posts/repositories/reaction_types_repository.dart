import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Networking
import '../../../core/networking/api_endpoint.dart';
import '../../../core/networking/api_service.dart';

// Models
import '../models/reaction_type_model.codegen.dart';

// Providers
import '../../all_providers.dart';

// Helpers
import '../../../helpers/typedefs.dart';

final reactionTypesRepositoryProvider = Provider<ReactionTypesRepository>((ref) {
  final _apiService = ref.watch(apiServiceProvider);
  return ReactionTypesRepository(apiService: _apiService);
});

class ReactionTypesRepository {
  final ApiService _apiService;

  ReactionTypesRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<List<ReactionTypeModel>> fetchAll({JSON? queryParameters}) async {
    return _apiService.getCollectionData<ReactionTypeModel>(
      endpoint: ApiEndpoint.reactionTypes(ReactionTypeEndpoint.BASE),
      queryParams: queryParameters,
      cachePolicy: CachePolicy.forceCache,
      converter: ReactionTypeModel.fromJson,
    );
  }
}
