import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MeBar extends StatefulWidget implements PreferredSizeWidget {
  MeBar({Key key}) : super(key: key);

  @override
  _MeBarState createState() => _MeBarState();

  @override
  Size get preferredSize => Size.fromHeight(ScreenUtil().setHeight(80 + ScreenUtil.statusBarHeight));
}

class _MeBarState extends State<MeBar> {
  @override
  Widget build(BuildContext context) {
    Widget avatar = ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Image.network(
        'https://wx1.sinaimg.cn/mw1024/0065lJGuly1g4zqg5sd9wj30u00u0q6c.jpg',
        width: ScreenUtil().setWidth(48),
        height: ScreenUtil().setWidth(48),
      ),
    );

    Widget username = Container(
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(17)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(110),
            child: Text(
              "Atmospheresssssssssssssssssss",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(20)
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                // child: ,
              ),
              Container(
                // child: ,
              )
            ],
          )
        ],
      )
    );
        
  
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil.statusBarHeight,
        left: ScreenUtil().setWidth(15),
        right: ScreenUtil().setWidth(15)
      ),
      width: ScreenUtil.screenWidth,
      height: ScreenUtil().setHeight(80) + ScreenUtil.statusBarHeight,
      child: Row(
        children: <Widget>[
          avatar,
          username
        ],
      ),
    );
  }
}