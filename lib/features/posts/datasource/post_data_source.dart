import 'package:dio/dio.dart';
import 'package:forumapp/features/posts/models/post.dart';

class PostDataSource {
  final Dio dio;

  PostDataSource({required this.dio});

  Future<void> commentOnPost(int postId, String comment, String token) async {
    try {
      await dio.post('/feed/$postId/comment',
          data: {'comment': comment},
          options: Options(headers: {'Authorization': 'Bearer $token'}));
    } catch (e) {
      throw Exception('Failed to comment on post: ${e.toString()}');
    }
  }

  Future<void> createPost(String content, String token) async {
    try {
      await dio.post('/feed/store',
          data: {'content': content},
          options: Options(headers: {'Authorization': 'Bearer $token'}));
    } catch (e) {
      throw Exception('Failed to create post: ${e.toString()}');
    }
  }

  Future<List<Post>> fetchPosts() async {
    List<Post> posts = [];
    try {
      final response = await dio.get('/feeds');
      //options: Options(headers: {'Authorization': 'Bearer $token'}));
      var responseData = List<Map<String, dynamic>>.from(response.data);
      for (var data in responseData) {
        posts.add(Post.fromJson(data));
      }
    } catch (e) {
      throw Exception('Failed to fetch posts: ${e.toString()}');
    }
    return posts;
  }

  Future<void> likePost(int postId, String token) async {
    try {
      await dio.post('/feed/$postId/like',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
    } catch (e) {
      throw Exception('Failed to like post: ${e.toString()}');
    }
  }
}
