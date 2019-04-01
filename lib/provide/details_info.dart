
import 'package:flutter/material.dart';
import '../model/details_model.dart';
import '../service/service_method.dart';
import 'dart:convert';

class DetailsInfoProvide with ChangeNotifier{
  DetailsModel goodsInfo;
  // 从后台获取商品详情
  getGoodsInfo(String id){
     var formData = {'goodId':id};
     request('getGoodDetailById',formData:formData).then((val){
       var responseData = json.decode(val.toString());
       print(responseData);
       goodsInfo = DetailsModel.fromJson(responseData);
       notifyListeners();
     }); 
  }
}