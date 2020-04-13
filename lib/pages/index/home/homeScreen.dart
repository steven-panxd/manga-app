import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manga/db/models.dart';
import 'package:manga/widget/bluredBackgroundWithMangaSwiper.dart';
import 'package:manga/widget/myAppBar.dart';
import 'package:manga/api/apiV1.dart';
import 'package:manga/widget/titledBlockView.dart';


class HomeScreen extends StatefulWidget {
  static String routeName = "HomeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MangaSwiperItemModel> swiperData;
  List<PostModel> titledBlockViewData;
  double appBarOpacity = 0;

  @override
  void initState() {
    super.initState();
    this.initData();
  }

  Future initData() async {
    List<MangaSwiperItemModel> data1 = await ApiV1.getHomepageSlideData();
    List<PostModel> data2  = await ApiV1.getHomepageGridViewData();
    setState(() {
      this.swiperData = data1;
      this.titledBlockViewData = data2;
    });
  }

  bool _onScroll(ScrollUpdateNotification n) {
    if(n.depth == 0) {
      double opacity = n.metrics.pixels / 100;
      if(opacity > 1) {
        opacity = 1;
      } else if(opacity < 0) {
        opacity = 0;
      }
      setState(() {
        this.appBarOpacity = opacity;
      });
    }
    return true;
  }

  @override
   Widget build(BuildContext context) {
    
    Widget appBar = MyAppBar(
      title: 'Home',
      opacity: this.appBarOpacity,
      leading: FlatButton(
        onPressed: () {},
        child: Icon(Icons.arrow_back),
      ),
      actions: [
        MyAppBarAction(
          child: Icon(Icons.home),
          onPressed: () {
            Fluttertoast.showToast(msg: 'ok');
          },
        )
      ],
    );

    Widget swiper = BluredBackgroundWithMangaSwiper(
      data: swiperData,
    );

    Widget mangaBlockView = TitledBlockView(
      title: 'Manga',
      data: titledBlockViewData,
    );

    Widget novelBlockView = TitledBlockView(
      title: 'Novel',
      data: titledBlockViewData,
    );

    Widget gameBlockView = TitledBlockView(
      title: 'Game',
      data: titledBlockViewData,
    );

    Widget listView = MediaQuery.removePadding(
      removeTop: true,
      context: context, 
      child: NotificationListener(
        onNotification: (Notification n) {
          if (n.runtimeType == ScrollUpdateNotification) {
            this._onScroll(n);
          }
          return false;
        },
        child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return swiper;
            case 1:
              return mangaBlockView;
            case 2:
              return novelBlockView;
            case 3:
              return gameBlockView;
            default:
              return Container();
          }
        }) 
      )
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          listView,
          appBar
        ],
      )
    );
  }
}