import 'package:hooks_riverpod/hooks_riverpod.dart';

// Networking
import '../../../core/networking/api_endpoint.dart';
import '../../../core/networking/api_service.dart';

// Models
import '../models/hangout_request_model.codegen.dart';

// Providers
import '../../all_providers.dart';

// Helpers
import '../../../helpers/typedefs.dart';

final hangoutRequestsRepositoryProvider = Provider<HangoutRequestsRepository>(
  (ref) {
    final _apiService = ref.watch(apiServiceProvider);
    return HangoutRequestsRepository(apiService: _apiService);
  },
);

class HangoutRequestsRepository {
  final ApiService _apiService;

  HangoutRequestsRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<List<HangoutRequestModel>> fetchAllHangoutRequests({
    JSON? queryParameters,
  }) async {
    return _apiService.getCollectionData<HangoutRequestModel>(
      endpoint: ApiEndpoint.hangoutRequests(HangoutRequestEndpoint.BASE),
      queryParams: queryParameters,
      converter: HangoutRequestModel.fromJson,
    );
  }

  Future<int> create({required JSON data}) async {
    return _apiService.setData<int>(
      endpoint: ApiEndpoint.hangoutRequests(HangoutRequestEndpoint.BASE),
      data: data,
      converter: (response) => response.body['hangout_request_id'] as int,
    );
  }

  Future<String> update({
    required int hangoutRequestId,
    required JSON data,
  }) async {
    return _apiService.updateData<String>(
      endpoint: ApiEndpoint.hangoutRequests(
        HangoutRequestEndpoint.BY_ID,
        id: hangoutRequestId,
      ),
      data: data,
      converter: (response) => response.headers.message,
    );
  }

  Future<String> delete({
    required int hangoutRequestId,
    JSON? data,
  }) async {
    return _apiService.deleteData<String>(
      endpoint: ApiEndpoint.hangoutRequests(
        HangoutRequestEndpoint.BY_ID,
        id: hangoutRequestId,
      ),
      data: data,
      converter: (response) => response.headers.message,
    );
  }
}
