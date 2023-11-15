import 'package:e_comperce_app/repositary/load_data.dart';
import 'package:e_comperce_app/repositary/local_storage_services/local_storage_repositary.dart';
import 'package:e_comperce_app/views/auth/login_screen.dart';
import 'package:e_comperce_app/views/home/home_screen.dart';
import 'package:e_comperce_app/views/widgets/bottom_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> with SingleTickerProviderStateMixin {

 AnimationController? _animationController;
  Animation? _animation;

  @override
  void initState() {
    super.initState();
    
        _animationController = AnimationController(
      vsync: this,
      
      duration: Duration(seconds: 2),
    );
    _animationController!.forward();
    _animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.fastOutSlowIn,
    ));
    nextScreen();
  }

  nextScreen()async{

    LocalStorageRepository localStorageRepository =LocalStorageRepository();
    var token = await localStorageRepository.getToken();
print(token);
    if(token ==null || token ==''){
       Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
    }else{
        await Future.delayed(const Duration(seconds: 2),()async{
    // ignore: use_build_context_synchronously
            await   LoadData.getProductData(context: context, ref: ref);
        // ignore: use_build_context_synchronously
        await   LoadData.getCategoryData(context: context, ref: ref);
        // ignore: use_build_context_synchronously
        await LoadData.getUserData(context: context, ref: ref);
    }).then((value) {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const CustomBottomNavigationBar()));

    }).catchError((err){
      print(err);
    });
    }
 
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController!.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // backgroundColor: Colors.pinkAccent,
      body: Container(
        width: 1.sw,
        height: 1.sh,
        decoration: BoxDecoration(image: DecorationImage(image: NetworkImage("https://images.unsplash.com/photo-1570857502809-08184874388e?q=80&w=1478&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),fit: BoxFit.cover)),
        child: AnimatedBuilder
        
        (
                animation: _animationController!,
          builder: (context,child) {
            return Transform(
                              transform: Matrix4.translationValues(
                   
                    0.0,
                     _animation!.value * 50,
                    0.0,
                  ),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomBottomNavigationBar()));
                },
                
                child: Center(child: Text("SHOP SHOP",
                style: TextStyle(fontSize: 40.sp,color: Colors.white,
                fontWeight: FontWeight.w600
                ),
                ))),
            );
          }
        ),
      ),
    );
  }
}