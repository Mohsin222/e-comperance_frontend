class UserModel {
  String? name;
  String? email;
  String? passwordHash;
  String? phone;
  bool? isAdmin;
  String? street;
  String? appartment;
  String? zip;
  String? city;
  String? country;
  String? sId;
  int? iV;

  UserModel(
      {this.name,
      this.email,
      this.passwordHash,
      this.phone,
      this.isAdmin,
      this.street,
      this.appartment,
      this.zip,
      this.city,
      this.country,
      this.sId,
      this.iV});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    passwordHash = json['passwordHash'];
    phone = json['phone'];
    isAdmin = json['isAdmin'];
    street = json['street'];
    appartment = json['appartment'];
    zip = json['zip'];
    city = json['city'];
    country = json['country'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['passwordHash'] = this.passwordHash;
    data['phone'] = this.phone;
    data['isAdmin'] = this.isAdmin;
    data['street'] = this.street;
    data['appartment'] = this.appartment;
    data['zip'] = this.zip;
    data['city'] = this.city;
    data['country'] = this.country;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}
