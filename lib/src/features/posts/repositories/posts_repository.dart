import 'package:hooks_riverpod/hooks_riverpod.dart';

// Networking
import '../../../core/networking/api_endpoint.dart';
import '../../../core/networking/api_service.dart';

// Models
import '../models/post_model.codegen.dart';

// Providers
import '../../all_providers.dart';

// Helpers
import '../../../helpers/typedefs.dart';

final postsRepositoryProvider = Provider<PostsRepository>(
  (ref) {
    final _apiService = ref.watch(apiServiceProvider);
    return PostsRepository(apiService: _apiService);
  },
);

class PostsRepository {
  final ApiService _apiService;

  PostsRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<List<PostModel>> fetchAllPosts({
    JSON? queryParameters,
  }) async {
    return _apiService.getCollectionData<PostModel>(
      endpoint: ApiEndpoint.posts(PostEndpoint.BASE),
      queryParams: queryParameters,
      converter: PostModel.fromJson,
    );
  }

  Future<int> create({required JSON data}) async {
    return _apiService.setData<int>(
      endpoint: ApiEndpoint.posts(PostEndpoint.BASE),
      data: data,
      converter: (response) => response.body['post_id'] as int,
    );
  }

  Future<String> update({
    required int postId,
    required JSON data,
  }) async {
    return _apiService.updateData<String>(
      endpoint: ApiEndpoint.posts(
        PostEndpoint.BY_ID,
        id: postId,
      ),
      data: data,
      converter: (response) => response.headers.message,
    );
  }

  Future<String> delete({
    required int postId,
    JSON? data,
  }) async {
    return _apiService.deleteData<String>(
      endpoint: ApiEndpoint.posts(
        PostEndpoint.BY_ID,
        id: postId,
      ),
      data: data,
      converter: (response) => response.headers.message,
    );
  }
}
