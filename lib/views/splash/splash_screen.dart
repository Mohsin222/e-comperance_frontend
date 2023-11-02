import 'package:e_comperce_app/repositary/load_data.dart';
import 'package:e_comperce_app/views/home/home_screen.dart';
import 'package:e_comperce_app/views/widgets/bottom_bar_widget.dart';
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
   await Future.delayed(Duration(seconds: 0),()async{
            await   LoadData.getProductData(context: context, ref: ref);
        await   LoadData.getCategoryData(context: context, ref: ref);
    }).then((value) {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> CustomBottomNavigationBar()));

    }).catchError((err){
      print(err);
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