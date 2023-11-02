import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:e_comperce_app/constants/app_contants.dart';
import 'package:e_comperce_app/models/user_model.dart';
import 'package:e_comperce_app/repositary/api_response_helper.dart';
import 'package:e_comperce_app/repositary/local_storage_services/local_storage_repositary.dart';
import 'package:e_comperce_app/views/widgets/custom_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';



final authRepositoryProvider = Provider((ref) {
  return AuthRepository(
      client: Client(),
      localStorageRepository: LocalStorageRepository(),
      ref: ref);
});

class AuthRepository {

  final http.Client _client;
  final LocalStorageRepository _localStorageRepository;
  final Ref _ref;

  AuthRepository({
    required Client client,
    required Ref ref,
    required LocalStorageRepository localStorageRepository,
  })  : _client = client,
        _ref = ref,
        _localStorageRepository = localStorageRepository;









  // SignUp verification
  Future registerUser(
{
      BuildContext? context,
  UserModel? userModel
}
  ) async {
    try {
        String url = '${AppConstants.baseUrl}api/v1/users/';

  Uri uri = Uri.parse(url);

 http.Response response = await http.post(uri,
      headers: {'Content-Type': 'application/json'}, body: json.encode(userModel!.toJson()));
  
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
var data =jsonDecode(response.body);
          UserModel? rNetUser =UserModel.fromJson(data);
          return response.statusCode;
        default:
          throw Exception(response.reasonPhrase);
      }
    } on SocketException {
            CustomSnackBar.buildErrorSnackbar(context!, 'No Internet');
      throw NoInternetException('No Internet');
    } on HttpException {
            CustomSnackBar.buildErrorSnackbar(context!, 'No Service Found');
      throw NoServiceFoundException('No Service Found');
    } on FormatException {
            CustomSnackBar.buildErrorSnackbar(context!, 'Invalid Data Format');
      throw InvalidFormatException('Invalid Data Format');
    } catch (e) {

    
         CustomSnackBar.buildErrorSnackbar(context!,e.toString());
      throw UnknownException(e.toString());
    }
  }


  // Sign IN
  Future signIn({ required  context,required String email, required String password}) async {
    try {


 

     String url = '${AppConstants.baseUrl}api/v1/users/login';

  Uri uri = Uri.parse(url);
  print(uri);
 http.Response response = await http.post(uri,
      headers: {'Content-Type': 'application/json'}, body: json.encode({
        "email":email,
        "passwordHash":password
      }));
print(response.statusCode);
      switch (response.statusCode) {
        case 200:
 
          var data = await jsonDecode(response.body);

       LocalStorageRepository localStorageRepository = LocalStorageRepository();
        localStorageRepository.setToken(data['token']);


        print(localStorageRepository.getToken());
          // storeUserTokenInSharedPref(data['accessToken']);
          // UserModel? rNetUser = await getUserData(email);
          return await getUserData(context,email);
          // return 200;
        default:
          throw Exception(response.reasonPhrase);
      }
    } on SocketException {
      CustomSnackBar.buildErrorSnackbar(context, 'No Internet');
      throw NoInternetException('No Internet');
    } on HttpException {
      CustomSnackBar.buildErrorSnackbar(context, 'No Service Found');
      throw NoServiceFoundException('No Service Found');
    } on FormatException {
         CustomSnackBar.buildErrorSnackbar(context, 'Invalid Data Format');
      throw InvalidFormatException('Invalid Data Format');
    } catch (e) {
       CustomSnackBar.buildErrorSnackbar(context, e.toString());
      throw UnknownException(e.toString());
    }
  }




  //user Info data
  Future<UserModel?> getUserData(BuildContext context,String email) async {
    try {

     String url = AppConstants.baseUrl + 'api/v1/users/getUserData';

      //  LocalStorageRepository localStorageRepository = LocalStorageRepository();
    var token  =await _localStorageRepository.getToken();
  Uri uri = Uri.parse(url);

  print(token);
 http.Response response = await http.post(uri,
      headers: {'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      },body: json.encode({"email":email}));

    
      switch (response.statusCode) {

        
        case 200:
        var data =jsonDecode(response.body);
        //  print(data['data']);
          UserModel? userModel = UserModel.fromJson(data['data']);

          return userModel;
        default:
          throw Exception(response.reasonPhrase);
      }
    } on SocketException {
            CustomSnackBar.buildErrorSnackbar(context, 'No Internet');
      throw NoInternetException('No Internet');
    } on HttpException {
         CustomSnackBar.buildErrorSnackbar(context, 'No Service Found');
      throw NoServiceFoundException('No Service Found');
    } on FormatException {
       CustomSnackBar.buildErrorSnackbar(context, 'Invalid Data Format');
      throw InvalidFormatException('Invalid Data Format');
    } catch (e) {
            CustomSnackBar.buildErrorSnackbar(context, e.toString());
      throw UnknownException(e.toString());
    }
  }



 static Future products() async {
    try {

    //  String url = AppConstants.baseUrl + 'api/v1/users/getUserData';

    String url ='http://localhost:8000/api/v1/products/';

  Uri uri = Uri.parse(url);
 http.Response response = await http.get(uri,
      headers: {'Content-Type': 'application/json'},);

          print(response.body);
      switch (response.statusCode) {

        
        case 200:
        var data =jsonDecode(response.body);
         print(data['data']);
          UserModel? userModel = UserModel();
 
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
}
