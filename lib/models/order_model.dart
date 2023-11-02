import 'package:e_comperce_app/models/cart_model.dart';

class OrderModel {
  List<CartModel>? orderItems;
  String? shippingAddress1;
  String? shippingAddress2;
  String? city;
  String? zip;
  String? country;
  String? phone;
  String? user;
  int? totalPrice;
String? sId;
  OrderModel(
      {this.orderItems,
      this.shippingAddress1,
      this.shippingAddress2,
      this.city,
      this.zip,
      this.country,
      this.phone,
      this.user,
      this.sId});

  OrderModel.fromJson(Map<String, dynamic> json) {
    if (json['orderItems'] != null) {
      orderItems = <CartModel>[];
      json['orderItems'].forEach((v) {
        orderItems!.add(new CartModel.fromJson(v));
      });
    }
    shippingAddress1 = json['shippingAddress1'];
    shippingAddress2 = json['shippingAddress2'];
    city = json['city'];
    zip = json['zip'];
    country = json['country'];
    phone = json['phone'];
    user = json['user'];
    totalPrice=json['totalPrice'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderItems != null) {
      data['orderItems'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    data['shippingAddress1'] = this.shippingAddress1;
    data['shippingAddress2'] = this.shippingAddress2;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['user'] = this.user;
     data['_id'] = this.sId;
    return data;
  }
}



