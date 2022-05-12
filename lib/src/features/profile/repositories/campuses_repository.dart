import 'package:hooks_riverpod/hooks_riverpod.dart';

// Networking
import '../../../core/networking/api_endpoint.dart';
import '../../../core/networking/api_service.dart';

// Models
import '../models/campus_model.codegen.dart';

// Providers
import '../../all_providers.dart';

// Helpers
import '../../../helpers/typedefs.dart';

final campusesRepositoryProvider = Provider<CampusesRepository>((ref) {
  final _apiService = ref.watch(apiServiceProvider);
  return CampusesRepository(apiService: _apiService);
});

class CampusesRepository {
  final ApiService _apiService;

  CampusesRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<List<CampusModel>> fetchAll({JSON? queryParameters}) async {
    return _apiService.getCollectionData<CampusModel>(
      endpoint: ApiEndpoint.campuses(CampusEndpoint.BASE),
      queryParams: queryParameters,
      converter: CampusModel.fromJson,
    );
  }
}
