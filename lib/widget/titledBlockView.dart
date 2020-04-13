import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manga/db/models.dart';


class TitledBlockView extends StatelessWidget {
  final List<PostModel> data;
  final String title;

  TitledBlockView({
    Key key,
    this.title,
    this.data
  }) : assert(title != null),
       super(key: key);

  void _onItemTap(id) {
    Fluttertoast.showToast(msg: id.toString());
  }

  @override
  Widget build(BuildContext context) {
    if (data != null) {
      List<TitledBlockViewItem> items = [];
      this.data.forEach((item) {
        items.add(
          TitledBlockViewItem(
            data: item,
            onTap: (id) => _onItemTap(id),
          )
        );
      });

      return Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(11),
          right: ScreenUtil().setWidth(11),
          top: ScreenUtil().setHeight(15),
          bottom: ScreenUtil().setHeight(15),
        ),
        margin: EdgeInsets.only(
          bottom: ScreenUtil().setHeight(16)
        ),
        width: ScreenUtil.screenWidth,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(15),
                right: ScreenUtil().setWidth(15),
                top: ScreenUtil().setHeight(8),
                bottom: ScreenUtil().setHeight(12)
              ),
              child: Text(
                this.title,
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ),
            Wrap(
              children: items,
            )
          ],
        )
      );
    } else {
      return Container();
    }  
  }
}


class TitledBlockViewItem extends StatelessWidget {
  final PostModel data;
  final ValueChanged<int> onTap;

  TitledBlockViewItem({
    Key key,
    @required this.data,
    @required this.onTap
  }) : assert(data != null),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => this.onTap(data.id),
      child: Container(
        margin: EdgeInsets.only(
          top: ScreenUtil().setHeight(3),
          left: ScreenUtil().setWidth(11),
          right: ScreenUtil().setWidth(11),
        ),
        width: ScreenUtil().setWidth(90),
        height: ScreenUtil().setHeight(193),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(
                  spreadRadius: 0.01,
                  blurRadius: 4,
                  color: Colors.black.withOpacity(0.4)
                )]
              ),
              child: Image.network(
                data.coverImage,
                fit: BoxFit.fill,
                width: ScreenUtil().setWidth(90),
                height: ScreenUtil().setHeight(132),
              )
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(2.5),
                bottom: ScreenUtil().setHeight(2.5)
              ),
              child: Text(
                data.title,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(2.5),
                bottom: ScreenUtil().setHeight(2.5)
              ),
              child: Text(
                data.author,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(14),
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
