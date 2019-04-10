import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvide with ChangeNotifier{
    String carString = "[]";
    // 添加购物车
    save(goodsId,goodsName,count,price,images) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      carString = prefs.getString('cartInfo');
      var temp = carString == null ? [] : json.decode(carString.toString());
      List<Map> tempList = (temp as List).cast();
      bool isHave = false;
      int ival = 0;
      tempList.forEach((item){
        if(item['goodsId'] == goodsId){
          tempList[ival]['count'] = item['count'] + 1;
          isHave = true;
        }
        ival++;
      });
      if(!isHave){
        tempList.add({
          'goodsId':goodsId,
          'goodsName':goodsName,
          'count':count,
          'price':price,
          'image':images
        });
      }

      carString = json.encode(tempList).toString();
      print(carString);
      prefs.setString('cartInfo', carString);
      notifyListeners();

    }

    // 清空购物车
    remove() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('cartInfo');
      notifyListeners();
      print('清空购物车');
    }


}