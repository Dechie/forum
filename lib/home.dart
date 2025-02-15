import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forumapp/providers/post_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'features/auth/models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.user,
  });

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _postController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    final poster = Provider.of<PostProvider>(context, listen: false);
    fetchValues(poster);
  }

  
  void fetchValues(PostProvider poster) async {
    //poster.setLoading(true);
    setState(() {
      isLoading = true;
    });
    try {
      await poster.fetchPosts();
    } catch (error) {
      print("Error fetching posts: $error");
      // Handle error appropriately, e.g., show error message
    } finally {
      //poster.setLoading(false);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final poster = Provider.of<PostProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Forum App'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostField(
                controller: _postController,
                hintText: 'What do you want to ask?',
              ),
              //const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 10,
                  ),
                ),
                onPressed: () async {
                  await poster.createPost(content: _postController.text.trim());
                  _postController.clear();
                  //poster.setLoading(true);
                  setState(() {
                    isLoading = true;
                  });
                  await poster.fetchPosts();
                  setState(() {
                    isLoading = false;
                  });
                  //poster.setLoading(false);
                },
                child: Text(
                  'post',
                  style: GoogleFonts.poppins(),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.7,
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      )
                    :
                    
                    ListView.separated(
                        itemBuilder: (context, index) => PosttData(
                          post: poster.posts[index],
                        ),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 15),
                        itemCount: poster.posts.length,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
