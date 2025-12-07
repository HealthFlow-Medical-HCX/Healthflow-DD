import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/config/app_config.dart';
import 'core/theme/app_theme.dart';
import 'core/config/router_config.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive for local storage
  await Hive.initFlutter();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  
  runApp(
    const ProviderScope(
      child: EHDIWalletApp(),
    ),
  );
}

class EHDIWalletApp extends ConsumerStatefulWidget {
  const EHDIWalletApp({super.key});

  @override
  ConsumerState<EHDIWalletApp> createState() => _EHDIWalletAppState();
}

class _EHDIWalletAppState extends ConsumerState<EHDIWalletApp> {
  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeModeProvider);
    
    return MaterialApp.router(
      title: 'EHDI Wallet - محفظة الهوية الصحية',
      debugShowCheckedModeBanner: false,
      
      // Localization
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      
      // Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      
      // Router
      routerConfig: router,
    );
  }
}

// Providers for app-wide state
final localeProvider = StateProvider<Locale>((ref) => const Locale('ar'));
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);
