import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_court_app/firebase_options.dart';

import 'pages/add_page.dart';
import 'pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CourtFinder',
      theme: ThemeData(
        fontFamily: 'inter',
        primaryColor: Colors.blueAccent.shade400,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.blueAccent.shade400,
          onPrimary: Colors.blueAccent.shade700,
          secondary: Colors.blueAccent,
          onSecondary: Colors.blueAccent.shade100,
          error: Colors.red.shade600,
          onError: Colors.redAccent,
          background: Colors.grey.shade100,
          onBackground: Colors.grey.shade200,
          surface: Colors.white,
          onSurface: Colors.black87,
        ),
        useMaterial3: true,
      ),
      home: const 
      SplashScreen(),
      //QRISPage(),
      //AddSecurityPIN()
    );
  }
}
