import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import 'constants/app_contants.dart';
class PP2 extends ConsumerStatefulWidget {
  const PP2({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PP2State();
}

class _PP2State extends ConsumerState<PP2> {

    late ScrollController _controller;

       int _page = 0;

  final int _limit = 100;


  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
    List _products = [];

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
  void _loadMore() async{

          setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _page += 1; 

      try {
          var url =AppConstants.baseUrl+"api/v1/orders/";  
           final res =
          await http.get(Uri.parse("$url$_page"));
     

        print(res.body);
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

  
      } catch (e) {
               if (kDebugMode) {
          print('Something went wrong!');
        }
        
      }
      setState(() {
        _isLoadMoreRunning = false;
      });


  }

     void _firstLoad() async {
        setState(() {
      _isFirstLoadRunning = true;
      
    });

    var url =AppConstants.baseUrl+"api/v1/orders/";

    print(url);
       try {
      final res =
          await http.get(Uri.parse("$url$_page"));
      setState(() {

        print(res.body);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('aaaaaaaaa'),
      ),
      body: _isFirstLoadRunning
          ? const Center(
              child: const CircularProgressIndicator(),
            )
            :Container(
              height: 1.sh,
              width: 1.sw,
              child: Column(
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
                  decoration: BoxDecoration(image: DecorationImage(image:NetworkImage(_products[index]['orderItems'][0]["product"]["image"]),fit: BoxFit.cover)),
                       
                             
                        ),
                                  
                        SizedBox(height: 5.h,),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                       
                               SizedBox(height: 5.h,),
                        Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                              Text('_id :'  ,  style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500),),
                                       SizedBox(width: 20.w,),
                             Flexible(child: Text(_products[index]['_id'] ?? '',
                                 textAlign: TextAlign.justify,
                             ),
                             
                             )
                          
                          ],
                        ),
                          Text(_products.length.toString()),
                          SizedBox(height: 5.h,),
               
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
            )
            ,
    );
  }
}