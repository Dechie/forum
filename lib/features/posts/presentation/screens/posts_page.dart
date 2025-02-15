import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forumapp/features/auth/models/user.dart';
import 'package:forumapp/features/posts/bloc/post_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/post_data.dart';
import '../widgets/post_field.dart';

class PostsPage extends StatefulWidget {
  final User user;
  const PostsPage({
    super.key,
    required this.user,
  });

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final TextEditingController _postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTh = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Forum App'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostField(
              controller: _postController,
              hintText: 'What do you want to ask?',
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                elevation: 0,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              ),
              onPressed: () {
                final content = _postController.text.trim();
                if (content.isNotEmpty) {
                  context
                      .read<PostBloc>()
                      .add(CreatePostEvent(content: content));
                  _postController.clear();
                }
              },
              child: Text(
                'Post',
                style: GoogleFonts.poppins(),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  if (state is PostLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    );
                  } else if (state is PostLoaded) {
                    return state.posts.isEmpty
                        ? Center(
                            child: SizedBox(
                              height: 60,
                              child: Column(
                                spacing: 12,
                                children: [
                                  Text(
                                    "No Feeds For Now",
                                    style: textTh.bodyLarge,
                                  ),
                                  Text(
                                    "You can create your own",
                                    style: textTh.bodySmall,
                                  )
                                ],
                              ),
                            ),
                          )
                        : ListView.separated(
                            itemBuilder: (context, index) =>
                                PosttData(post: state.posts[index]),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 15),
                            itemCount: state.posts.length,
                          );
                  } else if (state is PostError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: Text('No posts available.'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(FetchPostsEvent());
  }
}
