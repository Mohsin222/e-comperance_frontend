import 'package:e_comperce_app/models/product_list_model.dart';

class CartModel {
  String? productId;
  int? quantity;
  ProductModel? productModel;
 CartModel({this.productId, this.quantity,this.productModel});
  CartModel.fromJson(Map<String, dynamic> json) {
    productId = json['_id'] as String;
    quantity = json['quantity'] ;
        productModel = json['product'] != null
        ? new ProductModel.fromJson(json['product'])
        : null;
          // productModel = json['product'] ; 
          
  }


//jab hunm data bje the ho sife product ki id send karte  
///or jab fetch karte ha using populate ho jata a product is liya product ko model ma fatch karte ha

  Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['productId']=this.productId;
        data['quantity']=this.quantity;
          if (this.productModel != null) {
      // data['product'] = this.productModel!.toJson();
    }
       data['product']=productModel!.sId ; 
    return data;
  }
}