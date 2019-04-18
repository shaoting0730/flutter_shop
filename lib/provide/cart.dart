import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/cartinfo.dart';

class CartProvide with ChangeNotifier{
    String carString = "[]";
    List<CartInfoModel> cartList = [];
    double allPrice = 0; // 总价格
    int allGoodsCount = 0; //商品总数量
    bool isAllCheck = true; // 是否全选

    // 添加购物车
    save(goodsId,goodsName,count,price,images) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      carString = prefs.getString('cartInfo');
      var temp = carString == null ? [] : json.decode(carString.toString());
      List<Map> tempList = (temp as List).cast();
      bool isHave = false;
      int ival = 0;
      allGoodsCount = 0;
      allPrice = 0;
      tempList.forEach((item){
        if(item['goodsId'] == goodsId){
          tempList[ival]['count'] = item['count'] + 1;
          cartList[ival].count++;
          isHave = true;
          if(item['isCheck']){
            allPrice += (cartList[ival].price * cartList[ival].count);
            allGoodsCount += cartList[ival].count;
          }
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

        allPrice += (count*price);
        allGoodsCount += count;
      }

      carString = json.encode(tempList).toString();
      // print(carString);
      // print(cartList);

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
          // print(tempList);
          allPrice = 0;
          allGoodsCount = 0;
          isAllCheck = true;
          tempList.forEach((item){
            cartList.add(CartInfoModel.fromJson(item));
            if(item['isCheck']){
               allPrice += (item['count']*item['price']);
               allGoodsCount += item['count'];   
            }else{
              isAllCheck = false;
            }
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

    //购物车按钮点击
    chanegCheckState(CartInfoModel cartItem) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      carString = prefs.getString('cartInfo');
      List<Map> tempList = (json.decode(carString.toString()) as List).cast();
      int tempIndex = 0;
      int changeIndex = 0;
      tempList.forEach((item){
          if(item['goodsId'] == cartItem.goodsId){
            changeIndex = tempIndex;
          }
          tempIndex++;
      });
      tempList[changeIndex] = cartItem.toJson();
      carString = json.encode(tempList).toString();
      prefs.setString('cartInfo', carString);
      await getCartInfo();
    }

    //全选按钮点击事件
    changeAllCheckBtnState(bool isCheck) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      carString = prefs.getString('cartInfo');
      List<Map> tempList = (json.decode(carString.toString()) as List).cast();
      List<Map> newList = [];
      for (var item in tempList) {
        var newItem = item;
        newItem['isCheck'] = isCheck;
        newList.add(newItem);
      }
      carString = json.encode(newList).toString();
      prefs.setString('cartInfo', carString);
      await getCartInfo(); 
    }

    // 商品数量加减
    addOrReduceAction(var cartItem,String todo) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      carString = prefs.getString('cartInfo');
      List<Map> tempList = (json.decode(carString.toString()) as List).cast();
      int tempIndex = 0;
      int changeIndex = 0; 
      tempList.forEach((item){
        if(item['goodsId'] == cartItem.goodsId){
            changeIndex = tempIndex;
        }
        tempIndex++;
      });

      if(todo == 'add'){
        cartItem.count++;
      }else if(cartItem.count > 1){
        cartItem.count--;
      }
      tempList[changeIndex] = cartItem.toJson();
      carString = json.encode(tempList).toString();
      prefs.setString('cartInfo', carString);
      await getCartInfo(); 
    }



  
}