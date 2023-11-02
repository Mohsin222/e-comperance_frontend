import 'package:e_comperce_app/models/product_list_model.dart';

class CartModel {
  String? productId;
  double? quantity;
  ProductModel? productModel;
 CartModel({this.productId, this.quantity,this.productModel});
  CartModel.fromJson(Map<String, dynamic> json) {
    productId = json['_id'] as String;
    // quantity = json['quantity'] as double;
        productModel = json['product'] != null
        ? new ProductModel.fromJson(json['product'])
        : null;
          // productModel = json['product'] ; 
          
  }


  Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['_id']=this.productId;
        data['quantity']=this.quantity;
          if (this.productModel != null) {
      data['product'] = this.productModel!.toJson();
    }
      //  productModel = data['product'] ; 
    return data;
  }
}