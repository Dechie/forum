import 'package:flutter/material.dart';
import 'package:forumapp/widgets/input_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../home.dart';
import '../providers/auth/auth_provider.dart';
import 'register_screen.dart';

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
    var loginProvider = Provider.of<AuthProvider>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
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
                      hintText: 'username',
                      validator: (value) {
                        if (value == null || value.isEmpty || value == '') {
                          return 'The username field is required';
                        }
                        return null;
                      },
                      onchanged: (value) {
                        setState(() {
                          username = value.trim();
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    InputWidget(
                      hintText: 'Password',
                      obscure: true,
                      validator: (value) {
                        if (value == null || value.isEmpty || value == '') {
                          return 'The username field is required';
                        }
                        return null;
                      },
                      onchanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    loginProvider.isLoading
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
                                loginProvider.setLoading(true);
                                loginUser(context, loginProvider);
                              }
                            },
                            child: Text(
                              'Login',
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
                    builder: (context) => const RegisterScreen(),
                  ),
                );
              },
              child: Text(
                'Register',
                style: GoogleFonts.poppins(
                  fontSize: size.width * 0.04,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loginUser(BuildContext context, AuthProvider provider) async {
    int statusCode = await provider.login(
      username: username,
      password: password,
      context: context,
    );

    if (statusCode == 200) {
      var user = provider.user;

      provider.setLoading(false);
      if (context.mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HomePage(user: user!),
          ),
        );
      }
    }
  }
}
