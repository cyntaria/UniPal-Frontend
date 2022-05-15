import 'package:hooks_riverpod/hooks_riverpod.dart';

// Networking
import '../../../core/networking/api_endpoint.dart';
import '../../../core/networking/api_service.dart';

// Models
import '../models/teacher_review_model.codegen.dart';

// Providers
import '../../all_providers.dart';

// Helpers
import '../../../helpers/typedefs.dart';

final teacherReviewsRepositoryProvider = Provider<TeacherReviewsRepository>(
  (ref) {
    final _apiService = ref.watch(apiServiceProvider);
    return TeacherReviewsRepository(apiService: _apiService);
  },
);

class TeacherReviewsRepository {
  final ApiService _apiService;

  TeacherReviewsRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<List<TeacherReviewModel>> fetchAllConnections({
    JSON? queryParameters,
  }) async {
    return _apiService.getCollectionData<TeacherReviewModel>(
      endpoint: ApiEndpoint.teacherReviews(TeacherReviewEndpoint.BASE),
      queryParams: queryParameters,
      converter: TeacherReviewModel.fromJson,
    );
  }

  Future<int> create({required JSON data}) async {
    return _apiService.setData<int>(
      endpoint: ApiEndpoint.teacherReviews(TeacherReviewEndpoint.BASE),
      data: data,
      converter: (response) => response.body['teacher_review_id'] as int,
    );
  }

  Future<String> update({
    required int teacherReviewId,
    required JSON data,
  }) async {
    return _apiService.updateData<String>(
      endpoint: ApiEndpoint.teacherReviews(
        TeacherReviewEndpoint.BY_ID,
        id: teacherReviewId,
      ),
      data: data,
      converter: (response) => response.headers.message,
    );
  }

  Future<String> delete({
    required int teacherReviewId,
    JSON? data,
  }) async {
    return _apiService.deleteData<String>(
      endpoint: ApiEndpoint.teacherReviews(
        TeacherReviewEndpoint.BY_ID,
        id: teacherReviewId,
      ),
      data: data,
      converter: (response) => response.headers.message,
    );
  }
}
