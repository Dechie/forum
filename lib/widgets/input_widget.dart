import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputWidget extends StatelessWidget {
  InputWidget({
    super.key,
    required this.onchanged,
    this.keyboardType,
    required this.hintText,
    required this.validator,
    this.obscure,
  });

  final Function(String) onchanged;
  final FormFieldValidator validator;
  TextInputType? keyboardType;
  final String hintText;
  bool? obscure;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          onChanged: onchanged,
          keyboardType: keyboardType ?? TextInputType.name,
          validator: validator,
          obscureText: obscure ?? false,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(),
          ),
        ),
      ),
    );
  }
}
