import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import 'screens/home.dart';
import 'screens/login.dart';
import 'theme/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<CookieRequest>(
      create: (_) => CookieRequest(),
      child: MaterialApp(
        title: '67 Sportswear',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: Consumer<CookieRequest>(
          builder: (context, request, _) {
            if (request.loggedIn) {
              return const HomePage();
            }
            return const LoginPage();
          },
        ),
      ),
    );
  }
}
