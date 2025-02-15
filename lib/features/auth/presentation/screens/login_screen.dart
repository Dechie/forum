import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forumapp/core/widgets/input_widget.dart';
import 'package:forumapp/features/auth/bloc/auth_bloc.dart';
import 'package:forumapp/features/auth/presentation/screens/register_screen.dart';
import 'package:forumapp/home.dart';

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
            MaterialPageRoute(builder: (context) => HomePage(user: state.user)),
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
                Form(
                  key: _key,
                  child: Column(
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
                const SizedBox(height: 30),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const RegisterScreen()),
                    );
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
