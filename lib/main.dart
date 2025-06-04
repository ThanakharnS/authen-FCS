import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verify_identity/Page_ui/login_page.dart';
import 'package:verify_identity/Provider/home_provider.dart';
import 'package:verify_identity/Provider/login_provider.dart';
import 'package:verify_identity/Provider/splash_creen_provider.dart';

import 'Provider/menu_profile_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  try {
    await Firebase.initializeApp();
    print("✅ Firebase connected successfully!");
  } catch (e) {
    print("❌ Firebase failed to connect: $e");
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('th')],
      path: 'assets/lang', // ระบุโฟลเดอร์เก็บไฟล์แปล
      fallbackLocale: const Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SplashScreenProvider()),
          ChangeNotifierProvider(create: (_) => LoginProvider()),
          ChangeNotifierProvider(create: (_) => HomePageProvider()),
          ChangeNotifierProvider(create: (_) => MenuProfileProvider()),

        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    print('=====> Default Language : $currentLocale');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      title: 'Verify Identity',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
      ),
      home: const LoginPage(),
    );
  }
}
