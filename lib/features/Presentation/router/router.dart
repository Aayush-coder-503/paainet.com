import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:paainet/features/Presentation/main_screen/main_screen.dart';
import 'package:paainet/features/Presentation/pages/credentials/login/login.dart';
import 'package:paainet/features/Presentation/pages/credentials/signup/signup.dart';
import 'package:paainet/features/Presentation/pages/landingPage/aion.dart';
import 'package:paainet/features/Presentation/pages/landingPage/landing_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/about',
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      pageBuilder: (context, state) => _buildSlidePage(state, const Login()),
    ),
    GoRoute(
      path: '/signup',
      name: 'signup',
      pageBuilder: (context, state) => _buildSlidePage(state, const Signup()),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      pageBuilder: (context, state) =>
          _buildSlidePage(state, const MainScreen()),
    ),
    GoRoute(
      path: '/aion',
      name: 'aion',
      pageBuilder: (context, state) => _buildSlidePage(
        state,
        const Aion(),
      ),
    ),
    GoRoute(
      path: '/about',
      name: 'about',
      pageBuilder: (context, state) => _buildSlidePage(
        state,
        const LandingPage(),
      ),
    ),
  ],
  errorPageBuilder: (context, state) =>
      _buildSlidePage(state, const NotFoundPage()),
);

//Slides and Error below
CustomTransitionPage _buildSlidePage(GoRouterState state, Widget child) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: animation.drive(
          Tween(begin: const Offset(1, 0), end: Offset.zero)
              .chain(CurveTween(curve: Curves.easeInOut)),
        ),
        child: child,
      );
    },
  );
}

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 100),
            const SizedBox(height: 20),
            const Text(
              '404\nPage Not Found',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/login'),
              child: const Text('Go to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
