import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/cartinfo.dart';

class CartProvide with ChangeNotifier{
    String carString = "[]";
    List<CartInfoModel> cartList = [];
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
          cartList[ival].count++;
          isHave = true;
        }
        ival++;
      });
      if(!isHave){
        Map<String,dynamic> newGoods = {
          'goodsId':goodsId,
          'goodsName':goodsName,
          'count':count,
          'price':price,
          'image':images,
          'isCheck':true
        };
        tempList.add(newGoods);
        cartList.add(CartInfoModel.fromJson(newGoods));
      }

      carString = json.encode(tempList).toString();
      print(carString);
      print(cartList);

      prefs.setString('cartInfo', carString);
      notifyListeners();

    }

    // 清空购物车
    remove() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('cartInfo');
      cartList = [];
      notifyListeners();
      print('清空购物车');
    }

    // 获取购物车
    getCartInfo() async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        carString = prefs.getString('cartInfo');
        cartList = [];
        if(carString == null){
          cartList = [];
        }else{
          List<Map> tempList = (json.decode(carString.toString()) as List).cast();
          print(tempList);
          tempList.forEach((item){
            cartList.add(CartInfoModel.fromJson(item));
          });
        }
       notifyListeners();

    }

    // 删除单个购物车商品
    deleteOneGoods(String goodsId) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      carString = prefs.getString('cartInfo');
      List<Map> tempList = (json.decode(carString.toString()) as List).cast();
      int tempIndex = 0;
      int deleteIndex = 0;
      tempList.forEach((item){
        if(item['goodsId'] == goodsId){
          deleteIndex = tempIndex;
        }
        tempIndex++;
      });
      tempList.removeAt(deleteIndex);
      carString = json.encode(tempList).toString();
      prefs.setString('cartInfo', carString);
      getCartInfo();
    }

}