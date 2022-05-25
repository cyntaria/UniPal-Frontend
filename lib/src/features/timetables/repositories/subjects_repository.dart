import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Networking
import '../../../core/networking/api_endpoint.dart';
import '../../../core/networking/api_service.dart';

// Models
import '../models/subject_model.codegen.dart';

// Providers
import '../../all_providers.dart';

// Helpers
import '../../../helpers/typedefs.dart';

final subjectsRepositoryProvider = Provider<SubjectsRepository>((ref) {
  final _apiService = ref.watch(apiServiceProvider);
  return SubjectsRepository(apiService: _apiService);
});

class SubjectsRepository {
  final ApiService _apiService;

  SubjectsRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<List<SubjectModel>> fetchAll({JSON? queryParameters}) async {
    return _apiService.getCollectionData<SubjectModel>(
      endpoint: ApiEndpoint.subjects(SubjectEndpoint.BASE),
      queryParams: queryParameters,
      cachePolicy: CachePolicy.forceCache,
      cacheAgeDays: 3,
      converter: SubjectModel.fromJson,
    );
  }
}
