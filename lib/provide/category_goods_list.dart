import 'package:flutter/material.dart';
import '../model/categoryGoodsList.dart';

class CategoryGoodsListProvide with ChangeNotifier{
   List<CategoryListData> goodsList = [];
   // 点击左边大类时更换商品列表
   getGoodsList(List<CategoryListData> list){
     goodsList = list;
    notifyListeners();
   }

    // 上拉加载更多
   getMoreList(List<CategoryListData> list){
     goodsList.addAll(list);
    notifyListeners();
   }
}