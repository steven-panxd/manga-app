import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manga/api/apiV1.dart';
import 'package:manga/db/models.dart';
import 'package:manga/widget/mangaList.dart';
import 'package:manga/widget/myAppBar.dart';
import 'package:manga/widget/myTabView.dart';


class SubscriptionScreen extends StatefulWidget {
  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> with TickerProviderStateMixin {
  List<PostModel> mangaListData;
  TabController tabController;

  @override
  void initState() {
    super.initState();
    this.initData();
    this.tabController = TabController(vsync: this, length: 2);
  }

  Future initData () async {
    List<PostModel> data = await ApiV1.getSubscriptionData();
    setState(() {
      this.mangaListData = data;
    });
  }

  void _onItemTap(int id) {
    Fluttertoast.showToast(msg: id.toString());
  }

  @override
  Widget build(BuildContext context) {

    List<String> tabNames = [
      "Manga",
      "Novel"
    ];

    List<Widget> tabViews = <Widget>[
      MangaList(
        type: MangaListType.UPLOADER,
        data: this.mangaListData,
        onItemTap: (id) => this._onItemTap(id),
      ),
      MangaList(
        type: MangaListType.UPLOADER,
        data: this.mangaListData,
        onItemTap: (id) => this._onItemTap(id),
      ),
    ];

    return Scaffold(
      appBar: MyAppBar(
        title: "Subscription",
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        width: ScreenUtil.screenWidth,
        alignment: Alignment.topCenter,
        child: MyTabView(
          paddingLeft: ScreenUtil.screenWidth / 12,
          paddingRight: ScreenUtil.screenWidth / 12,
          tabNames: tabNames,
          tabViews: tabViews,
          controller: this.tabController,
        )
      )
    );
  }
}