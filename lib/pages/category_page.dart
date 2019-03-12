import 'package:flutter/material.dart';  // getCategory
import '../service/service_method.dart';
import 'dart:convert';

class CategoryPage extends StatefulWidget {
  final Widget child;

  CategoryPage({Key key, this.child}) : super(key: key);

  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  void _CategoryPage() async{
    await request('getCategory').then((val){
        var data = json.decode(val.toString());
        print('数据来了');
        print(data);
    });
  }


  @override
  Widget build(BuildContext context) {
    _CategoryPage();
    return Container(
       child: Text('分类页面'),
    );
  }
}