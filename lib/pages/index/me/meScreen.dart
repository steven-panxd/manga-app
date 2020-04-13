import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manga/api/apiV1.dart';
import 'package:manga/db/models.dart';
import 'package:manga/widget/meBar.dart';


class MeScreen extends StatefulWidget {
  @override
  _MeScreenState createState() => _MeScreenState();
}

class _MeScreenState extends State<MeScreen> {
  UserModel meData;
  List<PostModel> collectionData;

  @override
  void initState() {
    super.initState();
    this.initData();
  }

  Future initData() async {
    UserModel data1 = await ApiV1.getUserData();
    List<PostModel> data2 = await ApiV1.getSubscriptionData();
    setState(() {
      this.meData = data1;
      this.collectionData = data2;
    });
  }

  Widget _buildListTile(IconData leading, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(leading),
      title: Text(title),
      onTap: () => onTap(),
    );
  }

  List<Widget> _buildCollectionItems() {
    List<Widget> widgets = [];
    this.collectionData.forEach((item) {
      if (widgets.length < 3) {
         widgets.add(
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 0.01,
                        blurRadius: 5,
                        color: Colors.black.withOpacity(0.1),
                      )
                    ]
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10), 
                    child: Image.network(
                      item.coverImage,
                      fit: BoxFit.fitWidth,
                      width: ScreenUtil().setWidth(100),
                      height: ScreenUtil().setHeight(60),
                    ),
                  ),
                ),
                Container(
                  width: ScreenUtil().setWidth(100),
                  padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(6)
                  ),
                  child: Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(12)
                    ),
                  ),
                )
              ],
            ),
          )
        );
      }
    });
    return widgets;
  }

  void _goToCollectionPage() {

  }

  void _goToDownloadedPage() {

  }

  void _goToContributionPage() {

  }

  void _goToSettingsPage() {

  }

  void _goToHelpAndFeedbackPage() {

  }

  void _goToAboutPage() {

  }

  @override
  Widget build(BuildContext context) {

    Widget divider = Divider(height: 1, color: Color.fromRGBO(112, 112, 112, 1));

    Widget collection = Container(
      width: ScreenUtil().scaleWidth,
      height: ScreenUtil().setHeight(140),
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(20),
        right: ScreenUtil().setWidth(20),
        top: ScreenUtil().setWidth(11.75),
        bottom: ScreenUtil().setWidth(11.75),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              bottom: ScreenUtil().setHeight(8)
            ),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Collection',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(18)
                  ),
                ),
                GestureDetector(
                  onTap: () => _goToCollectionPage(),
                  child: Text(
                    'Show All',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: this._buildCollectionItems(),
          )
        ],
      ),
    );
    
    return Scaffold(
      appBar: MeBar(),
      body: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) {
          switch(index) {
            case 1:
              return collection;
            case 2:
              return this._buildListTile(Icons.file_download, 'Downloaded', () => this._goToDownloadedPage());
            case 3:
              return this._buildListTile(Icons.send, 'Contribution', () => this._goToContributionPage());
            case 5:
              return this._buildListTile(Icons.settings, 'Settings', () => this._goToSettingsPage());
            case 6:
              return this._buildListTile(Icons.feedback, 'Help & Feedback', () => this._goToHelpAndFeedbackPage());
            case 7:
              return this._buildListTile(Icons.info, 'About', () => this._goToAboutPage());
            default:
              return divider;
          }
        },
      ),
    );
  }
}
