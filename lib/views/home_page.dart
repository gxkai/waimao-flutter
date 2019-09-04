import 'package:flutter/material.dart';
import 'dart:math';
import 'package:waimao/views/keyword_ranking/keyword_ranking.dart';
import 'package:waimao/views/message/message.dart';
import 'package:waimao/views/components/drawer.dart';
import 'package:waimao/utils/data_utils.dart';
import 'package:waimao/models/dashboard.dart';
import 'package:waimao/views/flow_statistics/flow_statistics.dart';

class HomePage extends StatefulWidget {
  static String tag = '首页';

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("外贸易"),
      ),
      drawer: new MyDrawer(), //侧边栏
      body: new HomeContent(),
    );
  }
}

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {

  int messageCount = 0;
  int todayCount = 0;
  int unread = 0;
  int isRead = 0;

  int keywords = 0;
  int firstPageKeywords = 0;
  int secondPageKeywords = 0;
  int thirdPageKeywords = 0;

  int pv = 0;
  int uv = 0;
  num divide = 0;
  num newVisit = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async{
    Dashboard dashboard = await DataUtils.dashboard();
    setState(() {
      messageCount = dashboard.message.read + dashboard.message.unread;
      todayCount = dashboard.message.messageCount;
      unread = dashboard.message.unread;
      isRead = dashboard.message.read;

      keywords = dashboard.keyword.keywordCount;
      firstPageKeywords = dashboard.keyword.page1;
      secondPageKeywords = dashboard.keyword.page2;
      thirdPageKeywords =  dashboard.keyword.page3;

      pv = dashboard.visit.pv;
      uv = dashboard.visit.uv;
      if (dashboard.visit.pv != 0) {
        divide = (dashboard.visit.uv/dashboard.visit.pv)*100;
        newVisit = divide.floor();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        Card(
          elevation: 5.0,
          margin: const EdgeInsets.all(10.0),
          child: Material(
            borderRadius: BorderRadius.circular(4.0),
            color: Colors.lightBlue,
            child:InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(MessageList.tag);
              }, 
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new ListTile(
                    title: Text(
                      '询盘数量',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                    trailing: Icon(Icons.more_horiz, color: Colors.white,),
                  ),
                  ListTile(
                    leading: Icon(IconData(0xe6fd, fontFamily: "iconfont"), size: 40.0, color: Colors.white,),
                    contentPadding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                    trailing: Text(
                      '${ messageCount }',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Divider(height:10.0, indent:0.0, color: Colors.white,),
                  new Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child:  new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text("${ todayCount }", style: TextStyle(color: Colors.white, fontSize: 20.0)),
                              new Text(""),
                              new Text("今日询盘", style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child:  new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text("${ unread }", style: TextStyle(color: Colors.white, fontSize: 20.0)),
                              new Text(""),
                              new Text("未读询盘", style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child:  new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text("${ isRead }", style: TextStyle(color: Colors.white, fontSize: 20.0)),
                              new Text(""),
                              new Text("已读询盘", style: TextStyle(color: Colors.white)),
                            ],
                          ),

                        ),
                        flex: 1,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),

        Card(
          elevation: 5.0,
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Material(
            borderRadius: BorderRadius.circular(4.0),
            color: Colors.lightBlueAccent,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(KeywordRanking.tag);
              },
              child: new Column(
                //横轴起始测对齐
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new ListTile(
                    title: Text(
                      '关键词排名',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                    trailing: Icon(Icons.more_horiz, color: Colors.white,),
                  ),
                  ListTile(
                    leading: Icon(IconData(0xe661, fontFamily: "iconfont"), size: 40.0, color: Colors.white,),
                    contentPadding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                    trailing: Text(
                      '${ keywords }',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Divider(height:10.0, indent:0.0, color: Colors.white,),
                  new Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child:  new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text("${ firstPageKeywords }", style: TextStyle(color: Colors.white, fontSize: 20.0)),
                              new Text(""),
                              new Text("第一页排名数量", style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child:  new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text("${ secondPageKeywords }", style: TextStyle(color: Colors.white, fontSize: 20.0)),
                              new Text(""),
                              new Text("第二页排名数量", style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child:  new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text("${ thirdPageKeywords }", style: TextStyle(color: Colors.white, fontSize: 20.0)),
                              new Text(""),
                              new Text("第三页排名数量", style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                        flex: 1,
                      ),
                    ],
                  )
                ],
              ),
            )
          ),
        ),

        Card(
          elevation: 5.0,
          margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: Material(
            borderRadius: BorderRadius.circular(4.0),
            color: Colors.deepPurpleAccent,
              child:InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(FlowStatistics.tag);
                },
                child: new Column(
                  //横轴起始测对齐
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new ListTile(
                      title: Text(
                        '访客流量',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                      trailing: Icon(Icons.more_horiz, color: Colors.white,),
                    ),
                    ListTile(
                      leading: Icon(IconData(0xe61f, fontFamily: "iconfont"), size: 40.0, color: Colors.white,),
                      contentPadding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                      trailing: Text(
                        '${ pv }',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Divider(height:10.0, indent:0.0, color: Colors.white,),

                    new Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child:  new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Text("${ pv }", style: TextStyle(color: Colors.white, fontSize: 20.0)),
                                new Text(""),
                                new Text("浏览量PV", style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                          flex: 2,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child:  new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Text("${ uv }", style: TextStyle(color: Colors.white, fontSize: 20.0)),
                                new Text(""),
                                new Text("访客量UV", style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                          flex: 2,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child:  new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Text("${ newVisit }%", style: TextStyle(color: Colors.white, fontSize: 20.0)),
                                new Text(""),
                                new Text("新访量百分比", style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                          flex: 2,
                        ),
                      ],
                    )
                  ],
                ),
              )
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
              "Copyright ©2019 祥云平台",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.0, color: Colors.grey)
          ),
        )
      ],
    );
  }
}