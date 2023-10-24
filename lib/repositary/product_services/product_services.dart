import 'dart:convert';
import 'dart:io';

import 'package:e_comperce_app/constants/app_contants.dart';
import 'package:e_comperce_app/models/product_list_model.dart';
import 'package:e_comperce_app/repositary/api_response_helper.dart';
import 'package:e_comperce_app/repositary/local_storage_services/local_storage_repositary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final productRepositaryClassProvider = Provider((ref) {
  return ProductRepositaryClass(
      client: Client(),
      localStorageRepository: LocalStorageRepository(),
      ref: ref);
});

class ProductRepositaryClass {

    final Client _client;
  final LocalStorageRepository _localStorageRepository;
  final Ref _ref;

  ProductRepositaryClass({
    required Client client,
    required Ref ref,
    required LocalStorageRepository localStorageRepository,
  })  : _client = client,
        _ref = ref,
        _localStorageRepository = localStorageRepository;





  Future products({required BuildContext context}) async {
    try {

     String url = AppConstants.baseUrl + 'api/v1/products/';

    // String url ='http://localhost:8000/api/v1/products/';

  Uri uri = Uri.parse(url);
 Response response = await _client.get(uri,
      headers: {'Content-Type': 'application/json'},);

      switch (response.statusCode) {

        
        case 200:
        var data =jsonDecode(response.body);
         print(data);
          // UserModel? userModel = UserModel();
 ProductListModel? productListModel =ProductListModel.fromJson(data);
          return productListModel;
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