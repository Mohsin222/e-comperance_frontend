import 'package:e_comperce_app/views/auth/login_screen.dart';
import 'package:e_comperce_app/views/auth/signup_screen.dart';
import 'package:e_comperce_app/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
 runApp(ProviderScope( child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
               designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context,child) {
        return MaterialApp(
          title: 'E-Comerance',
          theme: ThemeData(
            
            primarySwatch: Colors.pink,
          ),
          home: const LoginScreen(),
        );
      }
    );
  }
}

