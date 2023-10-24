import 'package:e_comperce_app/models/product_list_model.dart';

class CartModel {
  String? product;
  double? quantity;
  ProductModel? productModel;
 CartModel({this.product, this.quantity,this.productModel});
  CartModel.fromJson(Map<String, dynamic> json) {
    product = json['product'] as String;
    quantity = json['quantity'] as double;
        productModel = json['ProductModel'] != null
        ? new ProductModel.fromJson(json['ProductModel'])
        : null;
  }


  Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['product']=this.product;
        data['quantity']=this.quantity;
          if (this.productModel != null) {
      data['ProductModel'] = this.productModel!.toJson();
    }
    return data;
  }
}