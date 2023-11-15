import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageRepository {
  //Set token to Authorization header to check if user is logged in or not
  void setToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('Authorization', token);
  }

  // Get the Authorization token that is saved in shared preferences
  Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('Authorization');
    return token;
  }
Future removeToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
 var d =  await preferences.remove('Authorization');

 return d;
   
  }

   //Set token to Authorization header to check if user is logged in or not
  void setUserType(String userType) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('userType', userType);
  }


   void saveEmail(String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('email', email);
  }
   Future<String?> getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? email = preferences.getString('email');
    return email;
  }

}