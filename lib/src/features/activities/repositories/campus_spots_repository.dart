import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Networking
import '../../../core/networking/api_endpoint.dart';
import '../../../core/networking/api_service.dart';

// Models
import '../models/campus_spot_model.codegen.dart';

// Providers
import '../../all_providers.dart';

// Helpers
import '../../../helpers/typedefs.dart';

final campusSpotsRepositoryProvider = Provider<CampusSpotsRepository>((ref) {
  final _apiService = ref.watch(apiServiceProvider);
  return CampusSpotsRepository(apiService: _apiService);
});

class CampusSpotsRepository {
  final ApiService _apiService;

  CampusSpotsRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<List<CampusSpotModel>> fetchAll({JSON? queryParameters}) async {
    return _apiService.getCollectionData<CampusSpotModel>(
      endpoint: ApiEndpoint.campusSpots(CampusSpotEndpoint.BASE),
      queryParams: queryParameters,
      cachePolicy: CachePolicy.forceCache,
      cacheAgeDays: 180,
      converter: CampusSpotModel.fromJson,
    );
  }
}
