import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manga/api/apiV1.dart';
import 'package:manga/db/models.dart';
import 'package:manga/widget/mangaHeader.dart';
import 'package:manga/widget/myTabView.dart';

class MangaDetailScreen extends StatefulWidget {
  static String routeName = "MangaDetailScreen";
  @override
  _MangaDetailScreenState createState() => _MangaDetailScreenState();
}

class _MangaDetailScreenState extends State<MangaDetailScreen> with TickerProviderStateMixin {
  PostModel data;
  double opacity = 0;
  TabController controller;

  @override
  void initState() {
    super.initState();
    this.initData();
    this.controller = TabController(length: 3, vsync: this);
  }

  Future initData() async {
    PostModel data = await ApiV1.getSinglePost();
    setState(() {
      this.data = data;
    });
  }

  bool _onScroll(ScrollUpdateNotification n) {
    if(n.depth == 0) {
      double opacity = n.metrics.pixels / 200;
      if(opacity > 1) {
        opacity = 1;
      } else if(opacity < 0) {
        opacity = 0;
      }
      setState(() {
        this.opacity = opacity;
      });
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if(this.data != null) {

      Widget backgroundImage = Positioned(
        left: 0, right: 0, top: 0, bottom: 0,
        child: Container(
          child: Stack(
            children: <Widget>[
              Image.network(
                this.data.coverImage,
                height: ScreenUtil.screenHeight,
                fit: BoxFit.fill,
              )
            ],
          )
        ),
      );

      Widget blur = Positioned(
        left: 0, right: 0, top: 0, bottom: 0,
        child: Container(
          width: ScreenUtil.screenWidth,
          height: ScreenUtil().setHeight(365),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              color: Color.fromRGBO(255, 255, 255, 0.5),
            ),
          ),
        )
      );

      List<String> tabNames = [
        'Preview',
        'Detail',
        'Comments'
      ];

      Widget preview = Container();

      Widget detail = Container();

      Widget comments = Container();

      return Scaffold(
        body: Stack(
          children: <Widget>[
            backgroundImage,
            blur,
            NotificationListener(
              onNotification: (ScrollUpdateNotification n) => this._onScroll(n),
              child: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      pinned: true,
                      backgroundColor: Theme.of(context).backgroundColor.withOpacity(this.opacity),
                      elevation: 0,
                      leading: FlatButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Icon(
                          Icons.arrow_back,
                        ),
                      ),
                      title: Text(
                        this.data.title,
                        style: TextStyle(
                          color: Colors.black.withOpacity(this.opacity)
                        ),
                      ),
                      centerTitle: true,
                      expandedHeight: ScreenUtil().setHeight(272),
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.none,
                        background: MangaHeader(
                          data: this.data,
                        )
                      ),
                      bottom: MyTabBar(
                        tabNames: tabNames,
                        paddingLeft: ScreenUtil.screenWidth / 15,
                        paddingRight: ScreenUtil.screenWidth / 15,
                        controller: this.controller,
                        backgroundColor: Theme.of(context).backgroundColor,
                      ),
                    )
                  ];
                },
                body: Container(
                  color: Theme.of(context).backgroundColor,
                  child: TabBarView(
                    controller: this.controller,
                    children: <Widget>[
                      preview,
                      detail,
                      comments
                    ],
                  ),  
                )
              )
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

}
