class CartModel {
  String? name;
  String? price;
  String? image;
  String? quantity;

  CartModel({this.name, this.price, this.image, this.quantity});

  CartModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    image = json['image'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    data['image'] = image;
    data['quantity'] = quantity;
    return data;
  }
}
