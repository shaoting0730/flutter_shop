import 'package:flutter/material.dart';
import '../model/details_model.dart';
import '../service/service_method.dart';
import 'dart:convert';

class DetailsInfoProvide with ChangeNotifier {
  DetailsModel goodsInfo;
  bool isLeft = true;
  bool isRight = false;

  // 从后台获取商品详情
   getGoodsInfo(String id) async {
    var formData = {'goodId': id};
    await request('getGoodDetailById', formData: formData).then((val) {
      var responseData = json.decode(val.toString());
      print(responseData);
      goodsInfo = DetailsModel.fromJson(responseData);
      notifyListeners();
    });
  }

  // tab切换
  changeLeftAndRight(String changeState) {
    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }
}
