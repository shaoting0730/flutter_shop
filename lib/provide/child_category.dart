import 'package:flutter/material.dart';
import '../model/category_model.dart';

class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];
  getChildCategoryList(List list){
    childCategoryList = list;
    notifyListeners();
  }
}