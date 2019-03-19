import 'package:flutter/material.dart';
import '../model/category_model.dart';

class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];
  getChildCategoryList(List<BxMallSubDto> list){
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = "00";
    all.mallCategoryId = "00";
    all.comments = "null";
    all.mallSubName = "全部";
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }
}