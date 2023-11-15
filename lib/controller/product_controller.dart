

import 'package:e_comperce_app/models/cart_model.dart';
import 'package:e_comperce_app/models/product_list_model.dart';
import 'package:e_comperce_app/repositary/local_storage_services/local_storage_repositary.dart';
import 'package:e_comperce_app/repositary/product_services/product_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final prodcutListProvider = StateProvider<ProductListModel?>((ref) => null);
final categoryListProvider = StateProvider<List<Category?>>((ref) => [

]);

final categoryValue = StateProvider<String>((ref) => 'All');
final seachValue = StateProvider<String>((ref) => '');
// final totalPriceProvider = StateProvider<double?>((ref) => 0);
// final cartListProvider = StateProvider<List<CartModel>?>((ref) => []);




// Controller Provider
final productControllerProvider =
    StateNotifierProvider<ProductController, bool>((ref) {
  return ProductController(
    productRepositaryClass: ref.read(productRepositaryClassProvider),
    localStorageRepository: LocalStorageRepository(),
    ref: ref,
  );
});

class ProductController extends StateNotifier<bool> {
  final ProductRepositaryClass _productRepositaryClass;
  final LocalStorageRepository _localStorageRepository;
  final Ref _ref;

  ProductController(
      {required ProductRepositaryClass productRepositaryClass,
      required LocalStorageRepository localStorageRepository,
      required Ref ref})
      : _productRepositaryClass = productRepositaryClass,
        _localStorageRepository = localStorageRepository,
        _ref = ref,
        super(false);




  Future fetchListOfProduct(BuildContext context,) async {
    state = true;

    
     ProductListModel? productListModel =
         await _productRepositaryClass.products(context:context,);


    // print(user);
        state = false;
    _ref.read(prodcutListProvider.notifier).update((state){
state = productListModel;
      return productListModel;

    });

  
  }





  
  Future listOfCategory(BuildContext context,) async {
    state = true;

    
List<Category?> d=         await _productRepositaryClass.fetchCategories(context:context,);


    // print(user);
        state = false;
    _ref.read(categoryListProvider.notifier).update((state){
state = d;


      return state;

    });

  
  }

}