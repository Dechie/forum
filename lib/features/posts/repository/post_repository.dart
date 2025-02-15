import 'package:forumapp/features/posts/datasource/post_data_source.dart';
import 'package:forumapp/features/posts/models/post.dart';

class PostRepository {
  final PostDataSource dataSource;
  PostRepository({required this.dataSource});

  commentOnPost(int postId, String comment) {}

  createPost(String content) {}

  Future<List<Post>> fetchPosts() async {
    try {
      return await dataSource.fetchPosts();
    } catch (e) {
      rethrow;
    }
  }

  likePost(int postId) {}
}
