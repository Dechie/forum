import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forumapp/features/posts/models/post.dart';
import 'package:forumapp/features/posts/repository/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc({required this.postRepository}) : super(PostInitial()) {
    on<FetchPostsEvent>(_onFetchPosts);
    on<CreatePostEvent>(_onCreatePost);
    on<LikePostEvent>(_onLikePost);
    on<CommentOnPostEvent>(_onCommentOnPost);
  }

  Future<void> _onCommentOnPost(
      CommentOnPostEvent event, Emitter<PostState> emit) async {
    try {
      await postRepository.commentOnPost(event.postId, event.comment);
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }

  Future<void> _onCreatePost(
      CreatePostEvent event, Emitter<PostState> emit) async {
    try {
      await postRepository.createPost(event.content);
      add(FetchPostsEvent()); // Refresh posts after creating one
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }

  Future<void> _onFetchPosts(
      FetchPostsEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final posts = await postRepository.fetchPosts();
      emit(PostLoaded(posts: posts));
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }

  Future<void> _onLikePost(LikePostEvent event, Emitter<PostState> emit) async {
    try {
      await postRepository.likePost(event.postId);
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }
}
