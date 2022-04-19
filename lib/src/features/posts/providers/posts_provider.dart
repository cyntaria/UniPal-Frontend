import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/typedefs.dart';

final postsProvider = Provider((_) => PostsProvider());

class PostsProvider {
  final _posts = [
    <String, Object?>{
      'post_id': 3,
      'body': 'Some post content body',
      'privacy': 'public',
      'author': {
        'erp': '17855',
        'profile_picture_url': 'https://yourwikis.com/wp-content/uploads/2020/01/mark-zuck-img.jpg',
        'first_name': 'Mark',
        'last_name': 'Zuckerberg',
      },
      'posted_at': '2021-09-17 17:53:40',
      'top_3_reactions': [
        {'reaction_type_id': 2, 'reaction_count': 2}
      ],
      'resources': [
        {
          'resource_id': 5,
          'resource_url': 'www.google.com/images',
          'resource_type': 'image'
        },
        {
          'resource_id': 6,
          'resource_url': 'www.youtube.com',
          'resource_type': 'video'
        }
      ]
    },
    <String, Object?>{
      'post_id': 2,
      'body':
          'my habit of going in-depth on every topic, not just to get things done but to do them in the best way possible',
      'privacy': 'public',
      'author': {
        'erp': '17855',
        'profile_picture_url': 'https://the360report.com/wp-content/uploads/2020/10/jeff.jpg',
        'first_name': 'Jeff',
        'last_name': 'Bezos',
      },
      'posted_at': '2021-09-17 16:53:40',
      'top_3_reactions': [
        {'reaction_type_id': 4, 'reaction_count': 2},
        {'reaction_type_id': 2, 'reaction_count': 1}
      ],
      'resources': null
    },
    <String, Object?>{
      'post_id': 1,
      'body': "Facebook 'lacks willpower' to tackle misinformation in Africa",
      'privacy': 'public',
      'author': {
        'erp': '17855',
        'profile_picture_url': 'https://the360report.com/wp-content/uploads/2020/10/jeff.jpg',
        'first_name': 'Abdur Rafay',
        'last_name': 'Saleem',
      },
      'posted_at': '2021-09-17 15:53:40',
      'top_3_reactions': [
        {'reaction_type_id': 2, 'reaction_count': 3}
      ],
      'resources': null
    }
  ];

  List<JSON> getAllPosts() {
    return [..._posts, ..._posts, ..._posts];
  }
}
