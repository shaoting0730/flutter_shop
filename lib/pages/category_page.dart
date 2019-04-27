import 'package:flutter/material.dart'; // getCategory
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category_model.dart';
import '../model/categoryGoodsList.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/category_goods_list.dart';
import '../provide/child_category.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart'; 
import '../routers/application.dart';

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
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoodsList(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// 右侧导航
class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context, child, childCategory) {
        return Container(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(570),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(
                color: Colors.black12,
                width: 1,
              ))),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: childCategory.childCategoryList.length,
            itemBuilder: (context, index) {
              return _rightInkWell(
                  index, childCategory.childCategoryList[index]);
            },
          ),
        );
      },
    );
  }

  Widget _rightInkWell(int index, BxMallSubDto item) {
    bool isClick = false; //是否点击.默认未点击
    isClick = index == Provide.value<ChildCategory>(context).childIndex
        ? true
        : false;

    return InkWell(
      onTap: () {
        print('00000000000');
        print(item.mallSubId);
        Provide.value<ChildCategory>(context)
            .changeChildIndex(index, item.mallSubId);
        _getMallGoods(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 8.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: isClick ? Colors.pink : Colors.black),
        ),
      ),
    );
  }

  // 请求右侧数据
  void _getMallGoods(String mallSubId) {
    var data = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId': mallSubId,
      'page': 1
    };

    request('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if (goodsList.data == null) {
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList([]);
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .getGoodsList(goodsList.data);
      }
    });
  }
}

// 左侧导航
class LeftCategoryNav extends StatefulWidget {
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];
  var listIndex = 0; // 默认点击第一行

  // 请求左侧数据
  void _getCategoryData() async {
    await request('getCategory').then((val) {
      var data = json.decode(val.toString());
      CategoryModel categoryModel = CategoryModel.fromJson(data);
      setState(() {
        list = categoryModel.data;
      });
      //改变右侧分类数据
      Provide.value<ChildCategory>(context)
          .getChildCategoryList(list[0].bxMallSubDto, list[0].mallCategoryId);
    });
  }

  // 请求右侧数据
  void _getMallGoods({String categoryId}) {
    var data = {
      'categoryId': categoryId == null ? '4' : categoryId,
      'categorySubId': '',
      'page': 1
    };

    request('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryGoodsListProvide>(context)
          .getGoodsList(goodsList.data);
    });
  }

  void initState() {
    super.initState();
    _getCategoryData(); // 得到左侧数据
    _getMallGoods(); // 得到右侧第一栏数据
  }

  // 左侧UI
  Widget _leftInkWell(int index) {
    bool isClick = false; // 默认未点击
    isClick = listIndex == index ? true : false;

    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        var categoryId = list[index].mallCategoryId;
        // 改变右侧分类数据
        Provide.value<ChildCategory>(context)
            .getChildCategoryList(childList, categoryId);
        // 发送右侧商品请求
        _getMallGoods(categoryId: categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
            color: isClick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil().setWidth(180),
        decoration: BoxDecoration(
            border: Border(right: BorderSide(width: 1, color: Colors.black12))),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return _leftInkWell(index);
          },
        ));
  }
}

// 商品列表
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
  var scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data) {
        try {
          if (Provide.value<ChildCategory>(context).page == 1) {
            // 列表返回最上层
            scrollController.jumpTo(0.0);
          }
        } catch (e) {
          print('第一次进入初始化,不try会报错');
          print(e);
        }

        if (data.goodsList.length > 0) {
          return Expanded(
              child: Container(
            width: ScreenUtil().setWidth(570),
            child: EasyRefresh(
              refreshFooter: ClassicsFooter(
                key: _footerKey,
                bgColor: Colors.white,
                textColor: Colors.pink,
                moreInfoColor: Colors.pink,
                showMore: true,
                noMoreText: Provide.value<ChildCategory>(context).noMoreText,
                moreInfo: '加载中...',
                loadReadyText: '上拉加载😝',
              ),
              child: ListView.builder(
                controller: scrollController,
                itemCount: data.goodsList.length,
                itemBuilder: (context, index) {
                  return _goodsItem(data.goodsList, index,context);
                },
              ),
              loadMore: () async {
                // 分类数据上拉加载更多
                _getMoreList();
              },
            ),
          ));
        } else {
          return Text('暂无商品');
        }
      },
    );
  }

  // 请求右侧数据
  void _getMoreList() {
    Provide.value<ChildCategory>(context).addPage();
    var data = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId': Provide.value<ChildCategory>(context).subId,
      'page': Provide.value<ChildCategory>(context).page
    };

    request('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if (goodsList.data == null) {
        Provide.value<ChildCategory>(context).changeNoMoreText('木有更多了');
        Fluttertoast.showToast(
          msg: '已经到底了',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.pink,
          textColor: Colors.white
        );
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .getMoreList(goodsList.data);
      }
    });
  }
}

// 商品图片
Widget _goodsImage(newlist, index) {
  return Container(
    width: ScreenUtil().setWidth(200),
    child: Image.network(newlist[index].image),
  );
}

// 商品名字
Widget _goodsName(newlist, index) {
  return Container(
    padding: EdgeInsets.all(5.0),
    width: ScreenUtil().setWidth(370),
    child: Text(
      newlist[index].goodsName,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: ScreenUtil().setSp(28)),
    ),
  );
}

// 价格
Widget _goodsPrice(newlist, index) {
  return Container(
    width: ScreenUtil().setWidth(370),
    margin: EdgeInsets.only(top: 20.0),
    child: Row(
      children: <Widget>[
        Text(
          '价格:¥${newlist[index].presentPrice}',
          style:
              TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(30)),
        ),
        Text(
          '¥${newlist[index].oriPrice}',
          style: TextStyle(
              color: Colors.black26, decoration: TextDecoration.lineThrough),
        )
      ],
    ),
  );
}

// 商品item
Widget _goodsItem(List newlist, int index,context) {
  return InkWell(
    onTap: () {
       Application.router.navigateTo(context, "./detail?id=${newlist[index].goodsId}");
    },
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.black12, width: 1))),
      child: Row(
        children: <Widget>[
          _goodsImage(newlist, index),
          Column(
            children: <Widget>[
              _goodsName(newlist, index),
              _goodsPrice(newlist, index),
            ],
          )
        ],
      ),
    ),
  );
}
