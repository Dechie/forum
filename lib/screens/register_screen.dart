import 'package:flutter/material.dart';
import 'package:forumapp/home.dart';
import 'package:forumapp/providers/auth/auth_provider.dart';
import 'package:forumapp/widgets/input_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

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
    var regProvider = Provider.of<AuthProvider>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Register',
              style: GoogleFonts.poppins(
                fontSize: size.width * 0.08,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: size.height * .45,
              width: size.width * .75,
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    InputWidget(
                      hintText: 'Name',
                      validator: (value) {
                        if (value == null || value.isEmpty || value == '') {
                          return 'The Name field is required';
                        }
                        return null;
                      },
                      onchanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    InputWidget(
                      hintText: 'Username',
                      validator: (value) {
                        if (value == null || value.isEmpty || value == '') {
                          return 'The Username field is required';
                        }
                        return null;
                      },
                      onchanged: (value) {
                        setState(() {
                          username = value;
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    InputWidget(
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Email',
                      validator: (value) {
                        if (value == null || value.isEmpty || value == '') {
                          return 'The Email field is required';
                        }
                        return null;
                      },
                      onchanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    InputWidget(
                      hintText: 'Password',
                      validator: (value) {
                        if (value == null || value.isEmpty || value == '') {
                          return 'The Password field is required';
                        }
                        return null;
                      },
                      obscure: true,
                      onchanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    regProvider.isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.black,
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 15,
                              ),
                            ),
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                regProvider.setLoading(true);
                                registerUser(context, regProvider);
                              }
                            },
                            child: Text(
                              'Register',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: size.width * 0.04,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: Text(
                'Login',
                style: GoogleFonts.poppins(
                    fontSize: size.width * 0.04, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void registerUser(BuildContext context, AuthProvider provider) async {
    int statusCode = await provider.register(
      name: name,
      username: username,
      email: email,
      password: password,
      context: context,
    );

    if (statusCode == 201) {
      var user = provider.user;
      print('${user!.name}, ${user.email}');
      // showDialog(
      //   context: context,
      //   builder: (context) => SizedBox(
      //     height: 150,
      //     child: Column(
      //       children: [
      //         Text(user!.name),
      //         Text(user.username),
      //         Text(user.email),
      //         Text(user.token),
      //       ],
      //     ),
      //   ),
      // );
      provider.setLoading(false);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => HomePage(user: user!),
        ),
      );
    }
  }
}
