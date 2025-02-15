import 'package:forumapp/features/posts/datasource/post_data_source.dart';

class PostRepository {
  final PostDataSource dataSource;
  PostRepository({required this.dataSource});

  commentOnPost(int postId, String comment) {}

  createPost(String content) {}

  fetchPosts() {}

  likePost(int postId) {}


}
