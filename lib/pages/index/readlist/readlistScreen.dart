import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manga/api/apiV1.dart';
import 'package:manga/db/models.dart';
import 'package:manga/widget/mangaList.dart';
import 'package:manga/widget/myAppBar.dart';
import 'package:manga/widget/myTabView.dart';


class ReadlistScreen extends StatefulWidget {
  @override
  _ReadlistScreenState createState() => _ReadlistScreenState();
}

class _ReadlistScreenState extends State<ReadlistScreen> with TickerProviderStateMixin {
  List<ReadlistModel> mangaListData;
  TabController tabController;

  @override
  void initState() {
    super.initState();
    this.initData();
    this.tabController = TabController(length: 2, vsync: this);
  }

  Future initData () async {
    List<ReadlistModel> data = await ApiV1.getReadlistModelData();
    setState(() {
      this.mangaListData = data;
    });
  }

  void _onItemTap(int id) {
    Fluttertoast.showToast(msg: id.toString());
  }

  void _onDeleteItem(int id) {
    Fluttertoast.showToast(msg: "del" + id.toString());
  }

  @override
  Widget build(BuildContext context) {

    List<String> tabNames = [
      "Manga",
      "Novel"
    ];

    List<Widget> tabViews = <Widget>[
      MangaList(
        onDelete: (id) => this._onDeleteItem(id),
        type: MangaListType.PROGRESS,
        data: this.mangaListData,
        onItemTap: (id) => this._onItemTap(id),
      ),
      MangaList(
        onDelete: (id) => this._onDeleteItem(id),
        type: MangaListType.PROGRESS,
        data: this.mangaListData,
        onItemTap: (id) => this._onItemTap(id),
      ),
    ];

    return Scaffold(
      appBar: MyAppBar(
        title: "Readlist",
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