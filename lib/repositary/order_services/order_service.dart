import 'dart:convert';
import 'dart:io';

import 'package:e_comperce_app/constants/app_contants.dart';
import 'package:e_comperce_app/controller/order_controller.dart';
import 'package:e_comperce_app/models/cart_model.dart';
import 'package:e_comperce_app/models/dum.dart';
import 'package:e_comperce_app/models/order_model.dart';
import 'package:e_comperce_app/models/product_list_model.dart';
import 'package:e_comperce_app/repositary/api_response_helper.dart';
import 'package:e_comperce_app/repositary/local_storage_services/local_storage_repositary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final orderRepositaryClassProvider = Provider((ref) {
  return OrderRepositaryClass(
      client: Client(),
      localStorageRepository: LocalStorageRepository(),
      ref: ref);
});

class OrderRepositaryClass {

    final Client _client;
  final LocalStorageRepository _localStorageRepository;
  final Ref _ref;

  OrderRepositaryClass({
    required Client client,
    required Ref ref,
    required LocalStorageRepository localStorageRepository,
  })  : _client = client,
        _ref = ref,
        _localStorageRepository = localStorageRepository;


  Future placeOrder({required BuildContext context,required  OrderModel? orderModel}) async {
    try {

     String url = AppConstants.baseUrl + 'api/v1/orders/';

    // String url ='http://localhost:8000/api/v1/products/';
       
    var token  =await _localStorageRepository.getToken();
  Uri uri = Uri.parse(url);
 Response response = await _client.post(uri,
      headers: {'Content-Type': 'application/json',
      
          'Authorization': 'Bearer $token',
      },
    //   body: json.encode({
    //        "shippingAddress1":"Johar karachi",
    // "shippingAddress2":"Gulshan  Karachi",
    // "city":"Karachi",
    // "zip":1234,
    // "country":"pakistan",
    // "phone":12345678,
    // "user":"6531151c4aa5fd1e33276f3f",
    // "orderItems":cartList
    // // [
    // //   {
    // //     "product":"6531188363a12b2df402194d",
    // //     "quantity":"12"
    // //   }
    // // ]
    //   })
    body: jsonEncode(orderModel!.toJson())
      );
print(response.statusCode);
      switch (response.statusCode) {

        
        case 200:
        var data =jsonDecode(response.body);
         print(data);
          // UserModel? userModel = UserModel();
//  ProductListModel? productListModel =ProductListModel.fromJson(data);
//           return productListModel;
return 200;
        default:
       
          throw Exception(response.reasonPhrase);
      }
    } on SocketException {

      
      throw NoInternetException('No Internet');
    } on HttpException {
      throw NoServiceFoundException('No Service Found');
    } on FormatException {
      throw InvalidFormatException('Invalid Data Format');
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }






Future userOrders({required BuildContext context,String? userId}) async {
    try {

     String url = AppConstants.baseUrl + 'api/v1/orders/get/userorders/$userId';

    // String url ='http://localhost:8000/api/v1/products/';
       
    var token  =await _localStorageRepository.getToken();
  Uri uri = Uri.parse(url);
 Response response = await _client.get(uri,
      headers: {'Content-Type': 'application/json',
      
          'Authorization': 'Bearer $token',
      },
    
      );

      switch (response.statusCode) {

        
        case 200:
        var data =jsonDecode(response.body) ;
        // print(data['data'][0]!.orderItems);
        //  print(data.runtimeType);
        print(data);
List<OrderModel?> orderlist=[];
        //  OrderModel orderModel =OrderModel.fromJson(data);
// for(int i=0; i<=5;i++){
// orderlist.add(OrderModel.fromJson(data[i]));
// print(i);
// }

    // for (var v in data['data']) {
    //     orderlist.add(OrderModel.fromJson(v));
    //   }

      if (data['data'] != null) {

      data['data'].forEach((v) {
        orderlist.add( OrderModel.fromJson(v));
      });
      }
// UserOrderListModel? orderListModel= UserOrderListModel.fromJson(data);
// print( orderlist[0]!.orderItems![0].quantity);
// print(orderlist[0]!.orderItems);
return orderlist;
        default:
          throw Exception(response.reasonPhrase);
      }
    } on SocketException {
      throw NoInternetException('No Internet');
    } on HttpException {
      throw NoServiceFoundException('No Service Found');
    } on FormatException {
      throw InvalidFormatException('Invalid Data Format');
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }


}