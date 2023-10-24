import 'package:e_comperce_app/repositary/load_data.dart';
import 'package:e_comperce_app/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {


  @override
  void initState() {
    super.initState();
    nextScreen();
  }

  nextScreen()async{
    Future.delayed(Duration(seconds: 0),(){
               LoadData.getProductData(context: context, ref: ref);

    }).then((value) {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));

    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: Center(child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
        },
        
        child: Text("E CONERANCE")),),
    );
  }
}