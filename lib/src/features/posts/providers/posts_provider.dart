import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/post_model.codegen.dart';
import '../models/post_resource_model.codegen.dart';

// States
import '../../shared/states/future_state.codegen.dart';

// Providers
import '../../auth/providers/auth_provider.dart';

// Repositories
import '../repositories/posts_repository.dart';

// Helpers
import '../../../helpers/typedefs.dart';

// Enums
import '../enums/post_privacy_enum.dart';

final postsProvider = StateNotifierProvider<PostsProvider, FutureState<String>>(
  (ref) {
    final _postsRepository = ref.watch(
      postsRepositoryProvider,
    );
    return PostsProvider(
      ref.read,
      postsRepository: _postsRepository,
    );
  },
);

final postsFeedFutureProvider = FutureProvider((ref) async {
  return ref.watch(postsProvider.notifier).getAllPosts();
});

class PostsProvider extends StateNotifier<FutureState<String>> {
  final PostsRepository _postsRepository;
  final Reader _read;

  PostsProvider(
    this._read, {
    required PostsRepository postsRepository,
  })  : _postsRepository = postsRepository,
        super(const FutureState.idle());

  Future<List<PostModel>> getAllPosts([JSON? queryParams]) async {
    return _postsRepository.fetchAllPosts(queryParameters: queryParams);
  }

  Future<void> addPost({
    required String body,
    PostPrivacy privacy = PostPrivacy.PUBLIC,
    List<PostResourceModel>? resources,
  }) async {
    state = const FutureState.loading();

    final data = PostModel.toUpdateJson(
      body: body,
      authorErp: _read(currentStudentProvider)!.erp,
      privacy: privacy,
      postedAt: DateTime.now(),
      resources: resources ?? [],
    );

    state = await FutureState.makeGuardedRequest(
      () async {
        await _postsRepository.create(data: data);
        return 'Post created successfully!';
      },
      errorMessage: 'Failed to create post.',
    );
  }

  Future<void> updatePost({
    required int postId,
    PostPrivacy? privacy,
    String? body,
  }) async {
    state = const FutureState.loading();

    final data = PostModel.toUpdateJson(
      privacy: privacy,
      body: body,
    );

    state = await FutureState.makeGuardedRequest(
      () async {
        return _postsRepository.update(postId: postId, data: data);
      },
      errorMessage: 'Failed to edit post.',
    );
  }

  Future<void> deletePostRequest(int postId) async {
    state = const FutureState.loading();

    state = await FutureState.makeGuardedRequest(
      () async {
        return _postsRepository.delete(postId: postId);
      },
      errorMessage: 'Failed to delete post.',
    );
  }
}
