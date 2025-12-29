import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/splash_screen.dart';
import 'utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SafetyApp());
}

class SafetyApp extends StatelessWidget {
  const SafetyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safety for all',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryPink,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.darkText),
          titleTextStyle: TextStyle(
            color: AppColors.darkText,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
