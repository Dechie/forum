import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forumapp/core/widgets/input_widget.dart';
import 'package:forumapp/features/auth/bloc/auth_bloc.dart';
import 'package:forumapp/features/auth/presentation/screens/login_screen.dart';
import 'package:forumapp/home.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _key = GlobalKey<FormState>();
  String name = '', username = '', email = '', password = '';

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
                const Text('Register',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Form(
                  key: _key,
                  child: Column(
                    children: [
                      InputWidget(
                        hintText: 'Name',
                        validator: (value) =>
                            value!.isEmpty ? 'Name is required' : null,
                        onchanged: (value) => name = value,
                      ),
                      InputWidget(
                        hintText: 'Username',
                        validator: (value) =>
                            value!.isEmpty ? 'Username is required' : null,
                        onchanged: (value) => username = value,
                      ),
                      InputWidget(
                        hintText: 'Email',
                        validator: (value) =>
                            value!.isEmpty ? 'Email is required' : null,
                        onchanged: (value) => email = value,
                      ),
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
                                        RegisterRequested(
                                            name: name,
                                            username: username,
                                            email: email,
                                            password: password),
                                      );
                                }
                              },
                              child: const Text('Register'),
                            ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
