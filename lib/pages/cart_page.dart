import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/cart.dart';
import 'dart:async';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context,snapshot){
          if(snapshot.hasData){
            List castList = Provide.value<CartProvide>(context).cartList;
            return ListView.builder(
              itemCount:castList.length,
              itemBuilder: (context,index){
                return ListTile(
                  title: Text(castList[index].goodsName),
                );
              },
            );
          }else{
              return Text('正在加载');
          }
        },
      )
    );
  }
 
   Future<String> _getCartInfo(BuildContext context) async{
     await Provide.value<CartProvide>(context).getCartInfo();
     return 'end';
   }
  
}
