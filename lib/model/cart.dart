class Cart {
  String code;
  String name;
  String image;
  double oldPrice;
  double newPrice;
  int quantity;

  Cart(
      {this.code,
      this.name,
      this.image,
      this.oldPrice,
      this.newPrice,
      this.quantity});

  Cart.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    image = json['image'];
    oldPrice = json['oldPrice'];
    newPrice = json['newPrice'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['image'] = this.image;
    data['oldPrice'] = this.oldPrice;
    data['newPrice'] = this.newPrice;
    data['quantity'] = this.quantity;
    return data;
  }
}