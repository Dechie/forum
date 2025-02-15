part of 'post_bloc.dart';

class CommentOnPostEvent extends PostEvent {
  final int postId;
  final String comment;

  CommentOnPostEvent({required this.postId, required this.comment});

  @override
  List<Object?> get props => [postId, comment];
}

class CreatePostEvent extends PostEvent {
  final String content;

  CreatePostEvent({required this.content});

  @override
  List<Object?> get props => [content];
}

class FetchPostsEvent extends PostEvent {}

class LikePostEvent extends PostEvent {
  final int postId;

  LikePostEvent({required this.postId});

  @override
  List<Object?> get props => [postId];
}

abstract class PostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
