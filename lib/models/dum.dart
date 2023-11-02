class UserOrderListModel {
  bool? success;
  List<Data>? data;

  UserOrderListModel({this.success, this.data});

  UserOrderListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  List<OrderItems>? orderItems;
  String? shippingAddress1;
  String? shippingAddress2;
  String? city;
  String? zip;
  String? country;
  String? phone;
  String? status;
  int? totalPrice;
  String? user;
  String? dateordered;
  int? iV;
  String? id;

  Data(
      {this.sId,
      this.orderItems,
      this.shippingAddress1,
      this.shippingAddress2,
      this.city,
      this.zip,
      this.country,
      this.phone,
      this.status,
      this.totalPrice,
      this.user,
      this.dateordered,
      this.iV,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['orderItems'] != null) {
      orderItems = <OrderItems>[];
      json['orderItems'].forEach((v) {
        orderItems!.add(new OrderItems.fromJson(v));
      });
    }
    shippingAddress1 = json['shippingAddress1'];
    shippingAddress2 = json['shippingAddress2'];
    city = json['city'];
    zip = json['zip'];
    country = json['country'];
    phone = json['phone'];
    status = json['status'];
    totalPrice = json['totalPrice'];
    user = json['user'];
    dateordered = json['dateordered'];
    iV = json['__v'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.orderItems != null) {
      data['orderItems'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    data['shippingAddress1'] = this.shippingAddress1;
    data['shippingAddress2'] = this.shippingAddress2;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['status'] = this.status;
    data['totalPrice'] = this.totalPrice;
    data['user'] = this.user;
    data['dateordered'] = this.dateordered;
    data['__v'] = this.iV;
    data['id'] = this.id;
    return data;
  }
}

class OrderItems {
  String? sId;
  int? quantity;
  Product? product;
  int? iV;

  OrderItems({this.sId, this.quantity, this.product, this.iV});

  OrderItems.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    quantity = json['quantity'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['quantity'] = this.quantity;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class Product {
  String? sId;
  String? name;
  String? description;
  String? richDescription;
  String? image;
  List<Null>? images;
  String? brand;
  int? price;
  Category? category;
  int? countInStock;
  int? rating;
  int? numReviews;
  bool? isFeatured;
  String? dateCreated;
  int? iV;

  Product(
      {this.sId,
      this.name,
      this.description,
      this.richDescription,
      this.image,
      this.images,
      this.brand,
      this.price,
      this.category,
      this.countInStock,
      this.rating,
      this.numReviews,
      this.isFeatured,
      this.dateCreated,
      this.iV});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    richDescription = json['richDescription'];
    image = json['image'];
    if (json['images'] != null) {
      images = <Null>[];
      // json['images'].forEach((v) {
      //   images!.add(new Null.fromJson(v));
      // });
    }
    brand = json['brand'];
    price = json['price'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    countInStock = json['countInStock'];
    rating = json['rating'];
    numReviews = json['numReviews'];
    isFeatured = json['isFeatured'];
    dateCreated = json['dateCreated'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['richDescription'] = this.richDescription;
    data['image'] = this.image;
    if (this.images != null) {
      // data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['brand'] = this.brand;
    data['price'] = this.price;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['countInStock'] = this.countInStock;
    data['rating'] = this.rating;
    data['numReviews'] = this.numReviews;
    data['isFeatured'] = this.isFeatured;
    data['dateCreated'] = this.dateCreated;
    data['__v'] = this.iV;
    return data;
  }
}

class Category {
  String? sId;
  String? name;
  String? color;
  int? iV;

  Category({this.sId, this.name, this.color, this.iV});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    color = json['color'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['color'] = this.color;
    data['__v'] = this.iV;
    return data;
  }
}
