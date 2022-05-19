import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../providers/posts_provider.dart';

// Widgets
import 'post_list_item.dart';

class PostsList extends ConsumerWidget {
  const PostsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(
      postsProvider.select((value) => value.getAllPosts()),
    );
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, i) => PostListItem(
          post: posts[i],
        ),
        childCount: posts.length,
      ),
    );
  }
}
