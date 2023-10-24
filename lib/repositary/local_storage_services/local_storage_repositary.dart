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
   //Set token to Authorization header to check if user is logged in or not
  void setUserType(String userType) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('userType', userType);
  }

}