import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<MyAppBarAction> actions;
  final Widget leading;
  final double opacity;
  final Color color;

  MyAppBar({
    Key key,
    @required this.title,
    this.leading,
    this.actions,
    this.opacity = 1.0,
    this.color = const Color.fromRGBO(240, 240, 240, 1)
  }) : assert(title != null),
       assert(opacity >= 0 && opacity <=1.0),
       super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(ScreenUtil().setHeight(80 + ScreenUtil.statusBarHeight));

  @override
  Widget build(BuildContext context) {
    
    Widget title = Container(
      child: Text(
        this.title,
        style: TextStyle(
          fontSize: 32,
        )
      )
    );

    Widget leadingWidget;
    if(this.leading == null) {
      leadingWidget = title;
    } else {
      leadingWidget = Container(
        child: Row(
          children: <Widget>[
            Container(
              child: this.leading,
              width: ScreenUtil().setWidth(40),
              height: ScreenUtil().setHeight(40),
            ),
            title
          ],
        )
      );
    }
    
    Widget actionWidgets;
    if(this.actions == null) {
      actionWidgets = Row();
    } else {
      actionWidgets = Row(
        children: this.actions,
      );
    }
    
    return Container(
      padding: EdgeInsets.only(top: ScreenUtil.statusBarHeight, left: ScreenUtil().setWidth(18), right: ScreenUtil().setWidth(18)),
      color: this.color.withOpacity(this.opacity),
      width: ScreenUtil.screenWidth,
      height: ScreenUtil().setHeight(80 + ScreenUtil.statusBarHeight),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          leadingWidget,
          actionWidgets
        ],
      )
    );
  }
}

class MyAppBarAction extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  MyAppBarAction({
    Key key,
    this.child,
    this.onPressed
  }) : assert(child != null),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: this.onPressed,
      icon: this.child
    );
  }
}