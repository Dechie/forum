import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forumapp/core/constants.dart';
import 'package:forumapp/core/dio_client.dart';
import 'package:forumapp/features/auth/bloc/auth_bloc.dart';
import 'package:forumapp/features/auth/datasource/auth_data_source.dart';
import 'package:forumapp/features/auth/presentation/screens/register_screen.dart';
import 'package:forumapp/features/auth/repository/auth_repository.dart';
import 'package:forumapp/features/posts/bloc/post_bloc.dart';
import 'package:forumapp/features/posts/datasource/post_data_source.dart';
import 'package:forumapp/features/posts/presentation/screens/posts_page.dart';
import 'package:forumapp/features/posts/repository/post_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'features/auth/models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('users');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final usersBox = Hive.box('users');
    String? token;
    if (usersBox.isNotEmpty) {
      token = usersBox.getAt(0)?['token'];
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            authRepository: AuthRepository(
              authDataSource: AuthDataSource(dio: DioClient.instance),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => PostBloc(
            postRepository: PostRepository(
              dataSource: PostDataSource(dio: DioClient.instance),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'MyFeeds',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainRed),
          useMaterial3: true,
        ),
        home: token != null
            ? PostsPage(user: User.fromHive(usersBox.getAt(0)))
            : const RegisterScreen(),
      ),
    );
  }
}
