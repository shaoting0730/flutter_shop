class CartInfoModel {
  String goodsId;
  String goodsName;
  int count;
  double price;
  String image;
  bool isCheck;

  CartInfoModel(
      {this.goodsId, this.goodsName, this.count, this.price, this.image, this.isCheck});

  CartInfoModel.fromJson(Map<String, dynamic> json) {
    goodsId = json['goodsId'];
    goodsName = json['goodsName'];
    count = json['count'];
    price = json['price'];
    image = json['image'];
    isCheck = json['isCheck'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodsId'] = this.goodsId;
    data['goodsName'] = this.goodsName;
    data['count'] = this.count;
    data['price'] = this.price;
    data['image'] = this.image;
    data['isCheck'] = this.isCheck;
    return data;
  }
}