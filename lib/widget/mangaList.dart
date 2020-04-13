import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manga/db/models.dart';
import 'package:manga/utils/dateTimeUtil.dart';


enum MangaListType {
  UPLOADER,
  PROGRESS
}


class MangaList extends StatefulWidget {
  final List<BaseModel> data;
  final ValueChanged<int> onItemTap;
  final MangaListType type;
  final ValueChanged<int> onDelete;
  

  MangaList({
    Key key,
    this.data,
    @required this.type,
    @required this.onItemTap,
    this.onDelete
  }) : assert(type != null),
       assert(onItemTap != null),
       assert(onDelete != null || type != MangaListType.PROGRESS),
       super(key: key);

  @override
  _MangaListState createState() => _MangaListState();
}

class _MangaListState extends State<MangaList> with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive => true;

  Widget _buildListItems(BuildContext context, int index) {
    if(index % 2 == 0) {
      List<MangaListItem> oneRow = [];

      switch (widget.type) {
        case MangaListType.UPLOADER:
          oneRow.add(
          MangaListItemWithUploader(
            data: widget.data[index],
            onTap: (id) => widget.onItemTap(id),
          ));

          if((index + 1) != widget.data.length) {
            oneRow.add(
              MangaListItemWithUploader(
                data: widget.data[index + 1],
                onTap: (id) => widget.onItemTap(id),
              )
            );
          }
          break;

        case MangaListType.PROGRESS:
          oneRow.add(
          MangaListItemWithProgress(
            onDelete: (id) => widget.onDelete(id),
            data: widget.data[index],
            onTap: (id) => widget.onItemTap(id),
          ));

          if((index + 1) != widget.data.length) {
            oneRow.add(
              MangaListItemWithProgress(
                onDelete: (id) => widget.onDelete(id),
                data: widget.data[index + 1],
                onTap: (id) => widget.onItemTap(id),
              )
            );
          }
          break;
      }

      return Row(
        children: oneRow,
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if(widget.data != null) {
      return Container(
        child: ListView.builder(
          itemCount: widget.data.length,
          itemBuilder: (context, index) => this._buildListItems(context, index),
        )
      );
    } else {
      return Container(height: 8);
    }
  }
}


abstract class MangaListItem extends StatelessWidget {
    final ValueChanged<int> onTap;

    MangaListItem({
    Key key,
    @required this.onTap
    }) : assert(onTap != null),
         super(key: key);

}

class MangaListItemWithUploader extends MangaListItem {
  final PostModel data;
  
  MangaListItemWithUploader({
    Key key,
    @required this.data,
    ValueChanged<int> onTap
    }) : assert(data != null),
        super(key: key, onTap: onTap);

  @override
  Widget build(BuildContext context) {

    Widget coverImage = ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10)
      ),
      child: Image.network(
        data.coverImage,
        fit: BoxFit.fill,
        width: ScreenUtil().setWidth(140),
        height: ScreenUtil().setHeight(188),
      )
    );

    Widget title = Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        top: ScreenUtil().setHeight(3),
        bottom: ScreenUtil().setHeight(3),
      ),
      child: Text(
        data.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(12),
        ),
      ),
    );

    Widget uploader = Container(
      height: 19,
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.network(
              data.uploader.avatar,
              width: ScreenUtil().setWidth(16),
              height: ScreenUtil().setWidth(16),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(5)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data.uploader.username,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(8)
                  ),
                ),
                Text(
                  DateTimeUtil.parseTimeFromUTCToLocalString(data.addTime),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(6)
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );

    return GestureDetector(
      onTap: () => this.onTap(this.data.id),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              spreadRadius: 0.01,
              blurRadius: 5,
              color: Colors.black.withOpacity(0.1),
            )
          ]
        ),
        margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(20),
          right: ScreenUtil().setWidth(20),
          top: ScreenUtil().setHeight(8),
          bottom: ScreenUtil().setHeight(8)
        ),
        width: ScreenUtil().setWidth(140),
        height: ScreenUtil().setHeight(230),
        child: Column(
          children: <Widget>[
            coverImage,
            Container(
              padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(12),
                right: ScreenUtil().setWidth(12)
              ),
              child: Column(
                children: <Widget>[
                  title,
                  uploader
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}

class MangaListItemWithProgress extends MangaListItem {
  final ReadlistModel data;
  final ValueChanged<int> onDelete;
  
  MangaListItemWithProgress({
    Key key,
    @required this.data,
    @required this.onDelete,
    ValueChanged<int> onTap,
    }) : assert(data != null), 
         assert(onDelete != null),
         super(key: key, onTap: onTap);

  @override
  Widget build(BuildContext context) {

    Widget coverImage = ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10)
      ),
      child: Image.network(
        data.coverImage,
        fit: BoxFit.fill,
        width: ScreenUtil().setWidth(140),
        height: ScreenUtil().setHeight(188),
      )
    );

    Widget title = Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        top: ScreenUtil().setHeight(3),
        bottom: ScreenUtil().setHeight(3),
      ),
      child: Text(
        data.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(12),
        ),
      ),
    );

    Widget progress = Container(
      height: 19,
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(70),
            height: ScreenUtil().setHeight(2),
            child: LinearProgressIndicator(
              value: data.readProgress,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(8),
              right: ScreenUtil().setWidth(8)
            ),
            child: Text(
              (this.data.readProgress * 100).toInt().toString() + "%",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(8),
              ),
            ),
          )
        ],
      )
    );

    Widget action =  GestureDetector(
      onTap: () => this.onDelete(this.data.id),
      child: Container(
      child: Icon(
          Icons.delete,
          size: ScreenUtil().setSp(18),
        )
      ),
    );

    return GestureDetector(
      onTap: () => this.onTap(this.data.id),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              spreadRadius: 0.01,
              blurRadius: 5,
              color: Colors.black.withOpacity(0.1),
            )
          ]
        ),
        margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(20),
          right: ScreenUtil().setWidth(20),
          top: ScreenUtil().setHeight(8),
          bottom: ScreenUtil().setHeight(8)
        ),
        width: ScreenUtil().setWidth(140),
        height: ScreenUtil().setHeight(230),
        child: Column(
          children: <Widget>[
            coverImage,
            Container(
              padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    title,
                    progress
                  ],
                ), action]
              ),
            )
          ],
        ),
      )
    );
  }
}