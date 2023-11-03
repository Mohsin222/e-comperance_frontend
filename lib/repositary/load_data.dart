import 'package:e_comperce_app/controller/aurh_controller.dart';
import 'package:e_comperce_app/controller/product_controller.dart';
import 'package:e_comperce_app/repositary/auth_services/auth_services.dart';
import 'package:e_comperce_app/repositary/local_storage_services/local_storage_repositary.dart';
import 'package:flutter/material.dart';

class LoadData{


     static Future<void> getUserData(
      {required BuildContext context, required ref}) async {
    LocalStorageRepository localStorage = LocalStorageRepository();
print('maaa');
    // String? email = await localStorage.getEmail();
    // await localStorage.getToken().then((value) => ref
    //     .read(productControllerProvider.notifier)
    //     .getAllPatients(context, value));
// print(email.toString()+'aaaaaaaaaaaaaaaa');

        
  // ignore: use_build_context_synchronously
  await ref.read(authControllerProvider.notifier).getuserData(context);
      
  }

   static Future<void> getProductData(
      {required BuildContext context, required ref}) async {
    LocalStorageRepository localStorage = LocalStorageRepository();
    // await localStorage.getToken().then((value) => ref
    //     .read(productControllerProvider.notifier)
    //     .getAllPatients(context, value));


        
  await ref.read(productControllerProvider.notifier)
        .fetchListOfProduct(context);
  }



  //get category data
     static Future<void> getCategoryData(
      {required BuildContext context, required ref}) async {
    LocalStorageRepository localStorage = LocalStorageRepository();
    // await localStorage.getToken().then((value) => ref
    //     .read(productControllerProvider.notifier)
    //     .getAllPatients(context, value));


        
  await ref.read(productControllerProvider.notifier)
        .listOfCategory(context);
  }

}