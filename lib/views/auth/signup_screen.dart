import 'package:e_comperce_app/controller/aurh_controller.dart';
import 'package:e_comperce_app/models/user_model.dart';
import 'package:e_comperce_app/repositary/auth_services/auth_services.dart';
import 'package:e_comperce_app/utils/text_field_decoration.dart';
import 'package:e_comperce_app/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
    final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _nameController = TextEditingController();
       final TextEditingController _confPasswordController = TextEditingController();
              final TextEditingController _phoneController = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();


@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confPasswordController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  //Sign In User
  Future signUp({required WidgetRef ref, UserModel? userModel}) async {
  
    await ref.watch(authControllerProvider.notifier).signUp(
          context,
          userModel
   
        );
   _moveToLogin();

  }
void _moveToLogin() {
  Navigator.pushReplacement<void, void>(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) => const LoginScreen(),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    // final isloading= ref.watch(authControllerProvider);
    print(isLoading);
    return  Scaffold(
      body: Container(
               margin: EdgeInsets.symmetric(horizontal: 15.w),
child: Form(
  key: _formKey,
  child: SingleChildScrollView(
  child: Column(children: [
      SizedBox(
              height: 39.h,
            ),

            //email field
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
              height: 5.h,
            ),
             //password field
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
             SizedBox(
              height: 5.h,
            ),
            // conf password field
            TextFormField(
              controller: _confPasswordController,
              decoration: TextFieldDecoration.decoration(hintTxt: 'Conform Password'),
              validator: (value) {
                if (value!.isEmpty) {
                  return "confPassword cannot be empty";
                }
                return null;
              },
            ),
               SizedBox(
              height: 5.h,
            ),
              // conf password field
            TextFormField(
              controller: _nameController,
              decoration: TextFieldDecoration.decoration(hintTxt: 'Name'),
              validator: (value) {
                if (value!.isEmpty) {
                  return "name cannot be empty";
                }
                return null;
              },
            ),
               SizedBox(
              height: 5.h,
            ),
              // phone  field
            TextFormField(
              controller: _phoneController,
              decoration: TextFieldDecoration.decoration(hintTxt: 'Phone Number'),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Phone number cannot be empty";
                }
                return null;
              },
            ),

             SizedBox(
              height: 20.h,
            ),
             GestureDetector(
              onTap: () {
              // Add your onPress function here
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
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
                  onPressed:isLoading ==false ? () async {
                    if (_formKey.currentState!.validate()) {
                      // await signIn(ref);
                      if(_passwordController.text.trim() !=_confPasswordController.text.trim()){
                        print('PASSWORD and Conform password not match');
                      }else{
                        UserModel? userModel =UserModel(
                          email: _emailController.text.trim(),
                          passwordHash: _passwordController.text.trim(),
                          name: _nameController.text.trim(),
                          phone: _phoneController.text.trim()
                        );
                        signUp(ref:ref, userModel:userModel);
                      }




                    }
                  }:null,
                  child: isLoading==false ?Text('SIGN UP',style: TextStyle(letterSpacing: 2),):Center(child: CircularProgressIndicator(color: Colors.white,),)),
            )
  ]),
)),
      ),
    );
  }
}