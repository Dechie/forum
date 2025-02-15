import 'package:flutter/material.dart';
import 'package:forumapp/providers/auth/auth_provider.dart';
import 'package:forumapp/providers/post_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'features/auth/models/user.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('users');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => PostProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _usersBox = Hive.box('users');
    return MaterialApp(
      title: 'my app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: _usersBox.getAt(0)['token'] != null
          ? HomePage(user: User.fromHive(_usersBox.getAt(0)))
          : RegisterScreen(),
    );
  }
}
