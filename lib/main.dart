import 'package:e_comperce_app/pp.dart';
import 'package:e_comperce_app/pract_pagination.dart';
import 'package:e_comperce_app/practice/stripe/stripe.dart';
import 'package:e_comperce_app/views/auth/login_screen.dart';
import 'package:e_comperce_app/views/auth/signup_screen.dart';
import 'package:e_comperce_app/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey='pk_test_51IMtIYCIzz5B7On2k2MBzHgwMYwWCci2bLRmUoIURWRvzGmhmJp3TneBYBGGrtja15vdF6adzpOy1Rz62T1aE4pD00SwmyE3b3';
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
          home:  SplashScreen(),
        );
      }
    );
  }
}

