import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../providers/posts_provider.dart';

// Widgets
import '../../shared/widgets/custom_refresh_indicator.dart';
import 'post_list_item.dart';

class PostsList extends ConsumerWidget {
  const PostsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(
      postsProvider.select((value) => value.getAllPosts()),
    );
    return CustomRefreshIndicator(
      onRefresh: () => Future.delayed(const Duration(seconds: 3)),
      displacement: 5,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: EdgeInsets.zero,
        itemCount: posts.length,
        itemBuilder: (_, i) => PostListItem(
          post: posts[i],
        ),
      ),
    );
  }
}
