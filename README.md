#  Flutter 电商学习项目 (更新中)
 [视频教程:技术胖]( https://m.qlchat.com/wechat/page/topic-simple-video?topicId=2000003599735644&byhand=1 )    <br/>

## 版本信息:
  version: 1.0.0+1   <br/>
  environment:   sdk: ">=2.0.0-dev.68.0 <3.0.0"  <br/>
    
### model转换  [https://javiercbk.github.io/json_to_dart/ ]( https://javiercbk.github.io/json_to_dart/  )  <br/>
### state管理  [provide: ^1.0.2 ]( https://github.com/google/flutter-provide  )  <br/>


### 使用三方库
 [网络请求库: dio]( https://github.com/flutterchina/dio )  <br/>
 [轮播库: flutter_swiper]( https://github.com/best-flutter/flutter_swiper )  <br/>
 [UI尺寸适配库: flutter_screenutil]( https://github.com/OpenFlutter/flutter_screenutil )  <br/>
 [打电话: url_launcher]( https://github.com/flutter/plugins )  <br/>
 [下拉刷新&上拉加载: flutter_easyrefresh]( https://github.com/xuelongqy/flutter_easyrefresh )  <br/>
 [提示框: fluttertoast]( https://github.com/PonnamKarthik/FlutterToast )  <br/>
 [路由管理: fluro]( https://github.com/theyakka/fluro )  <br/>
 [html加载: flutter_html]( https://github.com/Sub6Resources/flutter_html)  <br/>


 
 
### 代码结构
>- |--lib
>    - |-- config 
>      - |-- service_url.dart (存放url)
>    - |-- model 
>      - |-- category_model.dart (分类model)
>      - |-- categoryGoodsList.dart (分类列表model)
>      - |-- details_model.dart (详情model)
>    - |-- provide 
>      - |-- category_goods_list.dart <分类页--商品列表>
>      - |-- child_category.dart  <分类页--商品子分类>
>      - |-- details_info.dart <商品详情>
>    - |-- pages (页面)
>      - |-- details_page
>        - |-- details_top_area.dart  (商品详情的顶部)
>        - |-- details_explain.dart  (商品详情的解释固定UI)
>        - |-- details_tab.dart  (商品详情的tab)
>        - |-- details_web.dart  (商品详情的leftweb)
>      - |-- index_page.dart  (tabbar页面)
>      - |-- home_page.dart  (首页页面)
>      - |-- details_page.dart  (商品详情页面)
>      - |-- category_page.dart  (分类页面)
>      - |-- cart_page.dart  (购物车页面)
>      - |-- member_page.dart  (会员中心页面)
>    - |-- service 
>      - |-- service_method.dart (网络请求)
>    - |-- routers 
>      - |-- application.dart (静态化Router对象)
>      - |-- router_handle.dart (handle:负责跳转)
>      - |-- router.dart (handle注册进fluro)
>    - |-- mian.dart  (入口) 

## 项目截图
### 首页
![image](https://github.com/pheromone/flutter_shop/blob/master/homePage1.png) <br/>
![image](https://github.com/pheromone/flutter_shop/blob/master/homepag2.png) <br/>
### 分类
![image](https://github.com/pheromone/flutter_shop/blob/master/%E5%88%86%E7%B1%BB.png) <br/>

### 购物车
...
### 会员中心
...


 
