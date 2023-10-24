import 'package:e_comperce_app/repositary/auth_services/auth_services.dart';
import 'package:e_comperce_app/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
   await ref.watch(authControllerProvider.notifier).signUp(
          context,
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );



        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
   
  }

  @override
  Widget build(BuildContext context) {
  
    return  Scaffold(
body: Form(
  key: _formKey,
  child:   Column(children: [
  
  
  
  
  
    TextFormField(
  
      controller: _emailController,
  
      decoration: InputDecoration(hintText: 'Email'),
  
         validator: (value) {
  
                                  if (value!.isEmpty) {
  
                                    return "Email cannot be empty";
  
                                  } else if (!RegExp(
  
                                          "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
  
                                      .hasMatch(value)) {
  
                                    return "Please enter a valid email";
  
                                  }
  
                                  return null;
  
                                },
  
    ),
  
    SizedBox(height: 20,),
  
      TextFormField(
  
      controller: _passwordController,
  
      decoration: InputDecoration(hintText: 'password'),
  
         validator: (value) {
  
                                  if (value!.isEmpty) {
  
                                    return "Email cannot be empty";
  
                                  } 
                                  
  
                                  return null;
  
                                },
  
    ),
  
      SizedBox(height: 20,),
  
      ElevatedButton(onPressed: ()async{
  
           if (_formKey.currentState!.validate()){
  
          await  signIn(ref);
      //  await   AuthRepository.getUserData(_emailController.text.toString());
    //  ref.watch(authControllerProvider.notifier).signUp(
    //       context,
    //       _emailController.text.trim(),
    //       _passwordController.text.trim(),
    //     );

    // await AuthRepository.signIn(context: context, email: _emailController.text.trim(), password: _passwordController.text.trim());

           }
  
      }, child: Text('Sign IN'))
  
  ]),
),
    );
  }
}