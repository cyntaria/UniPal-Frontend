import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Networking
import '../../../core/networking/api_endpoint.dart';
import '../../../core/networking/api_service.dart';

// Models
import '../models/timeslot_model.codegen.dart';

// Providers
import '../../all_providers.dart';

// Helpers
import '../../../helpers/typedefs.dart';

final timeslotsRepositoryProvider = Provider<TimeslotsRepository>((ref) {
  final _apiService = ref.watch(apiServiceProvider);
  return TimeslotsRepository(apiService: _apiService);
});

class TimeslotsRepository {
  final ApiService _apiService;

  TimeslotsRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<List<TimeslotModel>> fetchAll({JSON? queryParameters}) async {
    return _apiService.getCollectionData<TimeslotModel>(
      endpoint: ApiEndpoint.timeslots(TimeslotEndpoint.BASE),
      queryParams: queryParameters,
      cachePolicy: CachePolicy.forceCache,
      cacheAgeDays: 180,
      converter: TimeslotModel.fromJson,
    );
  }
}
