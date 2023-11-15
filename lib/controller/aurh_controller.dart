//User provider
import 'package:e_comperce_app/repositary/auth_services/auth_services.dart';
import 'package:e_comperce_app/repositary/local_storage_services/local_storage_repositary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);


//Auth Controller Provider
final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authRepository: ref.read(authRepositoryProvider),
    localStorageRepository: LocalStorageRepository(),
    ref: ref,
  );
});


final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final LocalStorageRepository _localStorageRepository;
  final Ref _ref;

  AuthController(
      {required AuthRepository authRepository,
      required LocalStorageRepository localStorageRepository,
      required Ref ref})
      : _authRepository = authRepository,
        _localStorageRepository = localStorageRepository,
        _ref = ref,
        super(false);


  Future signIn(BuildContext context, String email,String password) async {
    state = true;

    
     UserModel? user =    await _authRepository.signIn(context:context, email:email,password: password );


    // print(user);
        state = false;
    _ref.read(userProvider.notifier).update((state){
state = user;
      return user;

    });

  
  }
 Future getuserData(BuildContext context,) async {
    state = true;

    
     UserModel? user =    await _authRepository.getUserData(context:context, );


    // print(user);
        state = false;
    _ref.read(userProvider.notifier).update((state){
state = user;
      return state;

    });

  
  }






   Future signUp(BuildContext context,UserModel? userModel) async {
    state = true;
  await _authRepository.registerUser(context:context, userModel: userModel);
      state = false;
  }


     Future updateUser({required BuildContext context,UserModel? userModel}) async {
    state = true;
      UserModel? user =  await _authRepository.updateUser(context:context, userModel: userModel);
      state = false;

         _ref.read(userProvider.notifier).update((state){
state = user;
      return state;

    });
  }

}