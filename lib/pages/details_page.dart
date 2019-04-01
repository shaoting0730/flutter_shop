import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/details_info.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    _getBackInfo(context);
    return Scaffold(
      appBar: AppBar(title: Text('详情')),
      body: Container(
        child: Text(goodsId),
      ),
    );
  }

  void _getBackInfo(BuildContext context) async{
      await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
      print('👌');

  }

}
