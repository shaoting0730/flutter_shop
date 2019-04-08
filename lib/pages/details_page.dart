import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/details_info.dart';
import './details_page/details_top_area.dart';  // 商品图片 + 名字 + 价格
import './details_page/details_explain.dart'; // 
import './details_page/details_tab.dart'; // 
import './details_page/details_web.dart';
import './details_page/details_bottom.dart';


class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('详情')),
      body: FutureBuilder(
        future: _getBackInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                Container(
              child: ListView(
                children: <Widget>[
                  DetailsTopArea(),
                  DetailsExplain(),
                  DetailsTab(),
                  DetailsWeb()
                ],
              ),
            ),
            Positioned(
              bottom:0,
              left: 0,
              child: DetailsBottom(),
            )
              ],
            );
          } else {
            return Center(
              child: Text('加载中'),
            );
          }
        },
      ),
    );
  }

  Future _getBackInfo(BuildContext context) async {
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    return '加载完成';
  }
}
