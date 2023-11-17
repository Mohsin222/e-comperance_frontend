import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCarsolSlider extends ConsumerWidget {
   CustomCarsolSlider({super.key});
CarouselController buttonCarouselController = CarouselController();

List images=[
  "https://images.unsplash.com/photo-1556905055-8f358a7a47b2?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://images.unsplash.com/photo-1503160865267-af4660ce7bf2?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://images.unsplash.com/photo-1571461082962-35e96a795dfc?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://images.unsplash.com/flagged/photo-1556637640-2c80d3201be8?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://images.unsplash.com/photo-1565084888279-aca607ecce0c?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",

];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return        
        CarouselSlider(
                  carouselController: buttonCarouselController,
  options: CarouselOptions(height:0.2.sh,
  autoPlay: true,
   viewportFraction: 0.8,
         enlargeCenterPage: true,
  ),

  
  items: images.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
             decoration: BoxDecoration(

               color: Colors.red,
               borderRadius: BorderRadius.circular(10.r),
               image: DecorationImage(image: NetworkImage(i.toString()),fit: BoxFit.cover)
              ),
              // child: Center(child: Text('--', style: TextStyle(fontSize: 16.0,color: Colors.white,fontWeight: FontWeight.bold),))
            );
          },
        );
  }).toList(),
);
  }
}