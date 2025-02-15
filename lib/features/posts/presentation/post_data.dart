import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class PosttData extends StatelessWidget {
  const PosttData({
    super.key,
    //required this.user,
    required this.post,
  });

  //final User? user;
  final Post post;
  @override
  Widget build(BuildContext context) {
    //print(user!.token);
    return SizedBox(
      height: 210,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.user.name,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                post.user.email,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 8,
                  ),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                post.content,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.thumb_up),
                  ),
                  const SizedBox(width: 30),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.message),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
