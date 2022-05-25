import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/post_model.codegen.dart';

// Providers
import '../providers/posts_provider.dart';

// Widgets
import '../../shared/widgets/async_value_widget.dart';
import '../../shared/widgets/custom_circular_loader.dart';
import '../../shared/widgets/empty_state_widget.dart';
import '../../shared/widgets/error_response_handler.dart';
import '../../shared/widgets/custom_refresh_indicator.dart';
import 'post_list_item.dart';

class PostsList extends ConsumerWidget {
  const PostsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomRefreshIndicator(
      onRefresh: () async => ref.refresh(postsFeedFutureProvider),
      displacement: 5,
      child: AsyncValueWidget<List<PostModel>>(
        value: ref.watch(postsFeedFutureProvider),
        loading: () => const Padding(
          padding: EdgeInsets.only(top: 60),
          child: CustomCircularLoader(),
        ),
        error: (error, st) => ErrorResponseHandler(
          error: error,
          retryCallback: () => ref.refresh(postsFeedFutureProvider),
          stackTrace: st,
        ),
        emptyOrNull: () => const EmptyStateWidget(
          height: 395,
          width: double.infinity,
          margin: EdgeInsets.only(top: 20),
          title: 'No posts found',
        ),
        data: (posts) => ListView.builder(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: EdgeInsets.zero,
          itemCount: posts.length,
          itemBuilder: (_, i) => PostListItem(
            post: posts[i],
          ),
        ),
      ),
    );
  }
}
