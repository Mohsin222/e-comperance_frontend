class ProductListModel {
  bool? success;
  List<ProductModel>? productModel;

  ProductListModel({this.success, this.productModel});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      productModel = <ProductModel>[];
      json['data'].forEach((v) {
        productModel!.add(new ProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.productModel != null) {
      data['data'] = this.productModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductModel {
  String? sId;
  String? name;
  String? description;
  String? richDescription;
  String? image;
  List<String>? images;
  String? brand;
  int? price;
  Category? category;
  int? countInStock;
  int? rating;
  int? numReviews;
  bool? isFeatured;
  String? dateCreated;
  int? iV;

  ProductModel(
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

  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    richDescription = json['richDescription'];
    image = json['image'];
    images = json['images'].cast<String>();
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
    data['images'] = this.images;
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
