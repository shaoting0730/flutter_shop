import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: (context,child,val){
        var goodsInfo = Provide.value<DetailsInfoProvide>(context).goodsInfo;
        if(goodsInfo != null){
          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _goodsImage(goodsInfo.data.goodInfo.image1),
                _goodsName(goodsInfo.data.goodInfo.goodsName),
                _goodsNum(goodsInfo.data.goodInfo.goodsSerialNumber),
                _goodsPrice(goodsInfo.data.goodInfo.presentPrice,goodsInfo.data.goodInfo.oriPrice),
              ],
            ),
          );
        }else{
          return Text('正在加载....');
        }
      },
    );
  }

  // 商品图片
  Widget _goodsImage(url){
    return Image.network(
      url,
      width: ScreenUtil().setWidth(740),
    );
  }

  // 商品名称
  Widget _goodsName(name){
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15.0),
      child: Text(
        name.toString(),
        style: TextStyle(fontSize: ScreenUtil().setSp(30)),
        maxLines: 1,
      ),
    );
  }

  // 商品编号
  Widget _goodsNum(num){
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Text(
        '编号:' + num.toString(),
        style: TextStyle(color: Colors.black12),
      ),
    );
  }

   //商品价格方法
  Widget _goodsPrice(presentPrice,oriPrice){
    return  Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left:15.0),
      margin: EdgeInsets.only(top:8.0),
      child: Row(
        children: <Widget>[
          Text(
            presentPrice.toString(),
            style: TextStyle(
              color:Colors.pinkAccent,
              fontSize: ScreenUtil().setSp(40),
            ),
          ),
          SizedBox(width: 10.0,),
          Text(
            '市场价:' + oriPrice.toString(),
            style: TextStyle(
              color: Colors.black26,
              decoration: TextDecoration.lineThrough
            ),
            )
        ],
      ),
    );
  }

}