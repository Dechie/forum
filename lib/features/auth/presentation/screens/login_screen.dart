import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forumapp/core/constants.dart';
import 'package:forumapp/core/widgets/input_widget.dart';
import 'package:forumapp/features/auth/bloc/auth_bloc.dart';
import 'package:forumapp/features/auth/presentation/screens/register_screen.dart';

import '../../../posts/presentation/screens/posts_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();
  String username = '', password = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => PostsPage(user: state.user)),
          );
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Login',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Form(
                    key: _key,
                    child: Column(
                      spacing: 12,
                      children: [
                        InputWidget(
                          hintText: 'Username',
                          validator: (value) =>
                              value!.isEmpty ? 'Username is required' : null,
                          onchanged: (value) => username = value.trim(),
                        ),
                        const SizedBox(height: 15),
                        InputWidget(
                          hintText: 'Password',
                          obscure: true,
                          validator: (value) =>
                              value!.isEmpty ? 'Password is required' : null,
                          onchanged: (value) => password = value,
                        ),
                        const SizedBox(height: 15),
                        state is AuthLoading
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () {
                                  if (_key.currentState!.validate()) {
                                    context.read<AuthBloc>().add(
                                          LoginRequested(
                                              username: username,
                                              password: password),
                                        );
                                  }
                                },
                                child: const Text('Login'),
                              ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Don't have an account?",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const TextSpan(text: '\t\t'),
                        TextSpan(
                          text: "Sign Up",
                          style: const TextStyle(
                            color: AppColors.mainRed,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
