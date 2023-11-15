import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final String apiUrl = 'https://fakestoreapi.com/products';
    int _page = 0;

  final int _limit = 100;


  bool _hasNextPage = true;
    // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;

  // This holds the posts fetched from the server
  List _products = [];

   void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res =
          await http.get(Uri.parse("$apiUrl?_page=$_page&_limit=$_limit"));
      setState(() {
        _products = json.decode(res.body);
      });
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong');
      }
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }
  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _page += 1; // Increase _page by 1
      try {
        final res =
            await http.get(Uri.parse("$apiUrl?_page=$_page&_limit=$_limit"));

        final List fetchedPosts = json.decode(res.body);
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _products.addAll(fetchedPosts);
          });
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }
  late ScrollController _controller;

@override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
appBar: AppBar(
  automaticallyImplyLeading: false,
  actions: [
  IconButton(onPressed: ()async{

  }, icon: Icon(Icons.logout,color: Colors.white,))
],),
 body: _isFirstLoadRunning
          ? const Center(
              child: const CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: _products.length,
                    itemBuilder: (_, index) => InkWell(
                      onTap: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsScreen(products: _products[index],)));
                      },
                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      child: Column(
                                  
                      
                      children: [
                        Container(
                          height: 200.h,
                          width: 1.sw,
                        decoration: BoxDecoration(image: DecorationImage(image:NetworkImage(_products[index]['image']),fit: BoxFit.cover)),
                       
                             
                        ),
                                  
                        SizedBox(height: 5.h,),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                    Text('Title :',
                                    style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500),
                                    ),
                                        SizedBox(width: 20.w,),
                                   Flexible(
                                     child: Text(_products[index]['title'],
                                     textAlign: TextAlign.center,
                                     maxLines: 2,
                                     ),
                                   )
                                ],
                              ),
                               SizedBox(height: 5.h,),
                        Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                              Text('Category :'  ,  style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500),),
                                       SizedBox(width: 20.w,),
                             Flexible(child: Text(_products[index]['category'],
                                 textAlign: TextAlign.justify,
                             ),
                             
                             )
                          ],
                        ),
                          SizedBox(height: 5.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                              Text('Price ',  style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500),),
                               SizedBox(width: 20.w,),
                             Flexible(child: Text(_products[index]['price'].toString()),
                             )
                          ],
                        )
                            ],
                          ),
                        ),
                           
                                  
                          
                      ],
                                      ),
                                    ),
                                  ),
                    ),
                  ),
                ),

                // when the _loadMore function is running
                if (_isLoadMoreRunning == true)
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),

                // When nothing else to load
                if (_hasNextPage == false)
                  Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 40),
                    color: Colors.amber,
                    child: const Center(
                      child: Text('You have fetched all of the content'),
                    ),
                  ),
              ],
            ),
    );
  }
}