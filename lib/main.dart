import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:go_router/go_router.dart';
import 'login_screen.dart';
import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('authBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => LoginScreen(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
      ],
      redirect: (BuildContext context, GoRouterState state) {
        final authBox = Hive.box('authBox');
        final isAuthenticated =
            authBox.get('isAuthenticated', defaultValue: false);
        final isLoggingIn = state.uri.toString() == '/login';

        if (!isAuthenticated && !isLoggingIn) {
          return '/login';
        } else if (isAuthenticated && isLoggingIn) {
          return '/home';
        }
        return null;
      },
    );

    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
