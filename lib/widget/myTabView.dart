import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MyTabView extends StatelessWidget {
  final List<String> tabNames;
  final List<Widget> tabViews;
  final Color backgroundColor;
  final double paddingLeft;
  final double paddingRight;
  final TabController controller;

  MyTabView({
    Key key,
    this.paddingLeft = 0,
    this.paddingRight = 0,
    @required this.tabNames,
    @required this.tabViews,
    @required this.controller,
    this.backgroundColor = Colors.transparent,
  }) : assert(tabNames != null),
       assert(tabViews != null),
       assert(tabNames.length == tabViews.length),
       assert(paddingLeft != null),
       assert(paddingRight != null),
       assert(controller != null),
       super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget tabBar = MyTabBar(
      paddingLeft: this.paddingLeft,
      paddingRight: this.paddingRight,
      tabNames: this.tabNames,
      backgroundColor: this.backgroundColor,
      controller: this.controller
    );

    Widget tabView = Expanded(
      child: TabBarView(
        controller: this.controller,
        children: this.tabViews
      )
    );

    return Container(
      color: this.backgroundColor,
      child: Column(
        children: <Widget>[
          tabBar,
          tabView
        ],
      ), 
    );
  }
}

class MyTabBar extends StatelessWidget with PreferredSizeWidget {
  final double paddingLeft;
  final double paddingRight;
  final List<String> tabNames;
  final Color backgroundColor;
  final TabController controller;

  MyTabBar({
    Key key,
    this.paddingLeft = 0,
    this.paddingRight = 0,
    @required this.tabNames,
    @required this.controller,
    this.backgroundColor = Colors.transparent
  }) : assert(paddingLeft != null),
       assert(paddingRight != null),
       assert(tabNames != null),
       assert(controller != null),
       super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(ScreenUtil().setHeight(48));

  List<Widget> _generateTabs() {
    List<Widget> tabs = [];
    this.tabNames.forEach((item) {
      tabs.add(Container(
        child: Text(
          item,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(14)
          ),
        ),
      ));
    });
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.backgroundColor,
      height: ScreenUtil().setHeight(48),
      padding: EdgeInsets.only(
        top: ScreenUtil().setHeight(3),
        bottom: ScreenUtil().setHeight(3),
        left: paddingLeft,
        right: paddingRight
      ),
      child: TabBar(
        controller: this.controller,
        labelColor: Theme.of(context).primaryColor,
        unselectedLabelColor: Colors.black,
        labelPadding: EdgeInsets.only(
          bottom: ScreenUtil().setHeight(3)
        ),
        indicatorColor: Theme.of(context).primaryColor,
        indicatorWeight: ScreenUtil().setHeight(3),
        indicatorSize: TabBarIndicatorSize.label,
        tabs: this._generateTabs()
      ),
    );
  }
}
