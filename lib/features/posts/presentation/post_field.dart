import 'package:flutter/material.dart';

class PostField extends StatelessWidget {
  const PostField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: controller,
          enableInteractiveSelection: true,
          // Prevent keyboard from popping up when user long presses
          onTap: () {
            Future.delayed(
              Duration.zero,
              () {
                controller.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: controller.text.length,
                );
              },
            );
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
          ),
        ),
      ),
    );
  }
}
