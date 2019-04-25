import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('会员中心')),
        body: ListView(
          children: <Widget>[
            _topHeader(),
            _orderTitle(),
            _orderType(),
            _actionList(),
          ],
        ));
  }

  // 顶部UI
  Widget _topHeader() {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20),
      color: Colors.pinkAccent,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            child: ClipOval(
              child: Image.network(
                'https://upload-images.jianshu.io/upload_images/2822163-70ac87aa2d2199d1.jpg',
                width: ScreenUtil().setWidth(200),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              '少停猿',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(36),
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 我的订单
  Widget _orderTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12),
        ),
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  //订单类型UI
  Widget _orderType() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.only(top: 20),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: Container(
              width: ScreenUtil().setWidth(187),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.party_mode,
                    size: 30,
                  ),
                  Text('待付款')
                ],
              ),
            ),
          ),
          //----------------
          InkWell(
            onTap: () {},
            child: Container(
              width: ScreenUtil().setWidth(187),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.query_builder,
                    size: 30,
                  ),
                  Text('待发货')
                ],
              ),
            ),
          ),
          //----------------
          InkWell(
            onTap: () {},
            child: Container(
              width: ScreenUtil().setWidth(187),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.directions_car,
                    size: 30,
                  ),
                  Text('待收货')
                ],
              ),
            ),
          ),
          //----------------
          InkWell(
            onTap: () {},
            child: Container(
              width: ScreenUtil().setWidth(187),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.comment,
                    size: 30,
                  ),
                  Text('待评价')
                ],
              ),
            ),
          ),
          //----------------
        ],
      ),
    );
  }

  //通用listTitle
  Widget _myListTitle(Icon icon,String title){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1,color: Colors.black12)
        ),
      ),
      child: ListTile(
        leading: icon,
        title: Text(title),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  Widget _actionList(){
    return Container(
      margin: EdgeInsets.only(top:10),
      child: Column(
        children: <Widget>[
            InkWell(
              onTap: (){},
              child: _myListTitle(Icon(Icons.pan_tool),'领取优惠券'),
            ),
            InkWell(
              onTap: (){},
              child: _myListTitle(Icon(Icons.panorama),'已领取优惠券'),
            ),
            InkWell(
              onTap: (){},
              child: _myListTitle(Icon(Icons.panorama_vertical),'地址管理'),
            ),
            InkWell(
              onTap: (){},
              child: _myListTitle(Icon(Icons.table_chart),'客服电话'),
            ),
            InkWell(
              onTap: (){},
              child: _myListTitle(Icon(Icons.unfold_more),'关于我们'),
            )
        ],
      ),
    );
  }

}
