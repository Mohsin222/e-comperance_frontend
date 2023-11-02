import 'package:e_comperce_app/repositary/auth_services/auth_services.dart';
import 'package:e_comperce_app/repositary/load_data.dart';
import 'package:e_comperce_app/utils/text_field_decoration.dart';
import 'package:e_comperce_app/views/auth/signup_screen.dart';
import 'package:e_comperce_app/views/home/home_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../controller/aurh_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //Sign In User
  Future<int?> signIn(WidgetRef ref) async {
    await ref.watch(authControllerProvider.notifier).signIn(
          context,
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );



  //  _completeLogin();
  nextScreen();
  }

    nextScreen()async{
   await Future.delayed(Duration(seconds: 0),()async{
            await   LoadData.getProductData(context: context, ref: ref);
 await   LoadData.getCategoryData(context: context, ref: ref);
    }).then((value) {
          _completeLogin();

    }).catchError((err){
      print(err);
    });
  }
  
  void _completeLogin() {
  Navigator.pushReplacement<void, void>(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) =>  HomeScreen(),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        child: Form(
          key: _formKey,
          child: Column(children: [
            SizedBox(
              height: 39.h,
            ),
            Lottie.network(
                'https://lottie.host/9fa8be04-804a-49bc-80e2-fb1063434590/44ifbEWgqt.json',
                repeat: true),
            TextFormField(
              controller: _emailController,
              decoration: TextFieldDecoration.decoration(
                hintTxt: 'Email',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Email cannot be empty";
                } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                    .hasMatch(value)) {
                  return "Please enter a valid email";
                }

                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: TextFieldDecoration.decoration(hintTxt: 'Password'),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Password cannot be empty";
                }
                return null;
              },
            ),
            GestureDetector(
              onTap: () {
              // Add your onPress function here
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
            },
              child: RichText(
                text: const TextSpan(
                    text: "Don'\t have an Account  ",
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        
                        text: 'SignUp',
                        // moh@g.com
                        // recognizer:TapGestureRecognizer()..onTap = () => print("The word touched i"),
                    
                        style: TextStyle(color: Colors.pinkAccent),
                      )
                    ]),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              // padding: const EdgeInsets.all(8.0),
              width: 1.sw,
              height: 50.h,
              child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await signIn(ref);




                      //  await   AuthRepository.getUserData(_emailController.text.toString());

                      //  ref.watch(authControllerProvider.notifier).signUp(

                      //       context,

                      //       _emailController.text.trim(),

                      //       _passwordController.text.trim(),

                      //     );

                      // await AuthRepository.signIn(context: context, email: _emailController.text.trim(), password: _passwordController.text.trim());
                    }
                  },
                  child: Text('LOGIN',style: TextStyle(letterSpacing: 2),)),
            )
          ]),
        ),
      ),
    );
  }
}
