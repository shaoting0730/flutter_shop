import 'package:flutter/material.dart';  // getCategory
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryPage extends StatefulWidget {
  final Widget child;

  CategoryPage({Key key, this.child}) : super(key: key);

  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('商品分类')),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
          ],
        ),
      )
    );
  }
}


// 左侧导航
class LeftCategoryNav extends StatefulWidget {
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];

 void _getCategoryData() async{
    await request('getCategory').then((val){
        var data = json.decode(val.toString());
        CategoryModel categoryModel= CategoryModel.fromJson(data);
        setState(() {
          list = categoryModel.data;
        });
    });
  }

  void initState() { 
    super.initState();
    _getCategoryData();
  }

  Widget _leftInkWell(int index){
    return InkWell(
      onTap: (){},
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left:10,top: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1,color: Colors.black12)
          )
        ),
        child: Text(list[index].mallCategoryName,style: TextStyle(fontSize: ScreenUtil().setSp(28)),),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       width: ScreenUtil().setWidth(180),
       decoration: BoxDecoration(
         border: Border(
           right: BorderSide(
             width: 1,color: Colors.black12
           )
         )
       ),
       child: ListView.builder(
         itemCount: list.length,
         itemBuilder: (context,index){
           return _leftInkWell(index);
         },
       )
    );
  }
  
}