import 'package:flutter/material.dart';
import '../model/category_model.dart';

class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0; // 右侧子导航高亮索引
  String categoryId = "4";  // 大类id,默认4
  String subId = ""; // 子类id
  int page = 1; // 默认加载第一页
  String noMoreText = '';  // 没有数据显示
  // 改变右侧分类数据
  getChildCategoryList(List<BxMallSubDto> list,String id){
    page = 1;
    noMoreText = '';
    childIndex = 0;  // 每次点击都需要重置0
    categoryId = id; 
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = "";
    all.mallCategoryId = "";
    all.comments = "null";
    all.mallSubName = "全部";
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }
   // 点击右侧分类
   changeChildIndex(index,String id){
     page = 1;
    noMoreText = '';
     childIndex = index;
     subId = id;
     notifyListeners();
   }

   // 增加page
   addPage(){
     page++;
   }

   //改变noMoreText文字
   changeNoMoreText(String text){
      noMoreText = text;
      notifyListeners();
   }


}