import 'package:hooks_riverpod/hooks_riverpod.dart';

// Networking
import '../../../core/networking/api_endpoint.dart';
import '../../../core/networking/api_service.dart';

// Models
import '../models/student_connection_model.codegen.dart';

// Providers
import '../../all_providers.dart';

// Helpers
import '../../../helpers/typedefs.dart';

final studentConnectionsRepositoryProvider =
    Provider<StudentConnectionsRepository>((ref) {
  final _apiService = ref.watch(apiServiceProvider);
  return StudentConnectionsRepository(apiService: _apiService);
},);

class StudentConnectionsRepository {
  final ApiService _apiService;

  StudentConnectionsRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<List<StudentConnectionModel>> fetchAllConnections({
    JSON? queryParameters,
  }) async {
    return _apiService.getCollectionData<StudentConnectionModel>(
      endpoint: ApiEndpoint.studentConnections(StudentConnectionEndpoint.BASE),
      queryParams: queryParameters,
      converter: StudentConnectionModel.fromJson,
    );
  }

  Future<List<StudentConnectionModel>> fetchAllRequests({
    JSON? queryParameters,
  }) async {
    return _apiService.getCollectionData<StudentConnectionModel>(
      endpoint: ApiEndpoint.studentConnections(
        StudentConnectionEndpoint.REQUESTS,
      ),
      queryParams: queryParameters,
      converter: StudentConnectionModel.fromJson,
    );
  }

  Future<int> create({required JSON data}) async {
    return _apiService.setData<int>(
      endpoint: ApiEndpoint.studentConnections(StudentConnectionEndpoint.BASE),
      data: data,
      converter: (response) => response.body['student_connection_id'] as int,
    );
  }

  Future<String> update({
    required int studentConnectionId,
    required JSON data,
  }) async {
    return _apiService.updateData<String>(
      endpoint: ApiEndpoint.studentConnections(
        StudentConnectionEndpoint.BY_ID,
        id: studentConnectionId,
      ),
      data: data,
      converter: (response) => response.headers.message,
    );
  }

  Future<String> delete({
    required int studentConnectionId,
    JSON? data,
  }) async {
    return _apiService.deleteData<String>(
      endpoint: ApiEndpoint.studentConnections(
        StudentConnectionEndpoint.BY_ID,
        id: studentConnectionId,
      ),
      data: data,
      converter: (response) => response.headers.message,
    );
  }
}
