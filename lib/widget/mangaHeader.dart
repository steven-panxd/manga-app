import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manga/db/models.dart';
import 'package:manga/utils/numberUtil.dart';


class MangaHeader extends StatelessWidget with PreferredSizeWidget {
  final PostModel data;

  MangaHeader({
    Key key,
    @required this.data
  }) : assert(data != null);

  @override
  Size get preferredSize => Size.fromHeight(ScreenUtil().setHeight(224));

  @override
  Widget build(BuildContext context) {

    Widget coverImage = Container(
      width: ScreenUtil().setWidth(100),
      height: ScreenUtil().setHeight(145),
      margin: EdgeInsets.only(
        left: ScreenUtil().setWidth(21),
        right: ScreenUtil().setWidth(21),
        top: ScreenUtil().setHeight(14)
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 5,
            color: Colors.black.withOpacity(0.1),
          )
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.network(
          this.data.coverImage,
          fit: BoxFit.fill,
        ),
      )
    );

    Widget information = Container(
      width: ScreenUtil().setWidth(180),
      height: ScreenUtil().setHeight(140),
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(14)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            this.data.title,
            style: TextStyle(
              fontSize: ScreenUtil().setHeight(24)
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(10),
              bottom: ScreenUtil().setHeight(10)
            ),
            child: Text(
              "Author: " + this.data.author,
              style: TextStyle(
                fontSize: ScreenUtil().setHeight(16)
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.visibility,
                      size: ScreenUtil().setSp(16),
                      color: Colors.black.withOpacity(0.6),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: ScreenUtil().setWidth(4)
                      ),
                      child: Text(
                        NumberUtil.parseNumberFromBigIntegerToString(this.data.viewNum),
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(12),
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    )
                  ],
                )
              ),
              Container(
                margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(30)
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.copyright,
                      size: ScreenUtil().setSp(16),
                      color: Colors.black.withOpacity(0.6),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: ScreenUtil().setWidth(4)
                      ),
                      child: Text(
                        NumberUtil.parseNumberFromBigIntegerToString(this.data.coinNum),
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(12),
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    )
                  ],
                )
              ),
              Container(
                margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(30)
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.collections_bookmark,
                      size: ScreenUtil().setSp(16),
                      color: Colors.black.withOpacity(0.6),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: ScreenUtil().setWidth(4)
                      ),
                      child: Text(
                        NumberUtil.parseNumberFromBigIntegerToString(this.data.collectedNum),
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(12),
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    )
                  ],
                )
              ),
            ],
          )
        ],
      ),
    );

    Widget content = Container(
      padding: EdgeInsets.only(
        top: ScreenUtil().setHeight(60)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          coverImage,
          information
        ],
      ),
    );

    return Container(
      width: ScreenUtil.screenWidth,
      height: ScreenUtil().setHeight(224),
      child: content
    );
  }
}