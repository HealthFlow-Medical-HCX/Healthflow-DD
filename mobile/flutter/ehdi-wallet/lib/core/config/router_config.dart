import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/onboarding_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/national_id_screen.dart';
import '../../features/auth/screens/biometric_setup_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/home/screens/main_shell.dart';
import '../../features/credentials/screens/credentials_screen.dart';
import '../../features/credentials/screens/credential_detail_screen.dart';
import '../../features/credentials/screens/add_credential_screen.dart';
import '../../features/prescriptions/screens/prescriptions_screen.dart';
import '../../features/prescriptions/screens/prescription_detail_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/settings/screens/profile_screen.dart';
import '../../features/settings/screens/security_screen.dart';
import '../../features/settings/screens/language_screen.dart';

// Route names
class Routes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String nationalId = '/national-id';
  static const String biometricSetup = '/biometric-setup';
  static const String home = '/home';
  static const String credentials = '/credentials';
  static const String credentialDetail = '/credentials/:id';
  static const String addCredential = '/credentials/add';
  static const String prescriptions = '/prescriptions';
  static const String prescriptionDetail = '/prescriptions/:id';
  static const String settings = '/settings';
  static const String profile = '/settings/profile';
  static const String security = '/settings/security';
  static const String language = '/settings/language';
  static const String scanner = '/scanner';
}

// Navigation keys
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

// Router provider
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: Routes.splash,
    debugLogDiagnostics: true,
    
    routes: [
      // Splash Screen
      GoRoute(
        path: Routes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      
      // Onboarding
      GoRoute(
        path: Routes.onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      
      // Login
      GoRoute(
        path: Routes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      
      // National ID Verification
      GoRoute(
        path: Routes.nationalId,
        name: 'nationalId',
        builder: (context, state) => const NationalIdScreen(),
      ),
      
      // Biometric Setup
      GoRoute(
        path: Routes.biometricSetup,
        name: 'biometricSetup',
        builder: (context, state) => const BiometricSetupScreen(),
      ),
      
      // Main Shell with Bottom Navigation
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          // Home
          GoRoute(
            path: Routes.home,
            name: 'home',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const HomeScreen(),
            ),
          ),
          
          // Credentials
          GoRoute(
            path: Routes.credentials,
            name: 'credentials',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const CredentialsScreen(),
            ),
            routes: [
              GoRoute(
                path: 'add',
                name: 'addCredential',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const AddCredentialScreen(),
              ),
              GoRoute(
                path: ':id',
                name: 'credentialDetail',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return CredentialDetailScreen(credentialId: id);
                },
              ),
            ],
          ),
          
          // Prescriptions
          GoRoute(
            path: Routes.prescriptions,
            name: 'prescriptions',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const PrescriptionsScreen(),
            ),
            routes: [
              GoRoute(
                path: ':id',
                name: 'prescriptionDetail',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return PrescriptionDetailScreen(prescriptionId: id);
                },
              ),
            ],
          ),
          
          // Settings
          GoRoute(
            path: Routes.settings,
            name: 'settings',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const SettingsScreen(),
            ),
            routes: [
              GoRoute(
                path: 'profile',
                name: 'profile',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const ProfileScreen(),
              ),
              GoRoute(
                path: 'security',
                name: 'security',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const SecurityScreen(),
              ),
              GoRoute(
                path: 'language',
                name: 'language',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const LanguageScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
    
    // Error handling
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              state.error.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(Routes.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});
