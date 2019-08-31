import 'package:flutter/material.dart';
import 'package:waimao/views/message/message.dart';
import 'package:waimao/views/ranking/ranking.dart';
import 'package:waimao/views/components/drawer.dart';
import 'package:waimao/utils/net_utils.dart';
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

  int messageCount = 24;
  int todayCount = 8;
  int unread = 14;
  int readed = 10;

  int keywords = 5;
  int firstPageKeywords = 4;
  int secondPageKeywords = 10;
  int thirdPageKeywords = 8;

  int pv = 381;
  int uv = 84;
  String newVisit = "22%";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        InkWell(
          onTap: (){
            Navigator.of(context).pushNamed(Message.tag);
          },
          child: Card(
            color: Colors.lightBlue,
            elevation: 5.0,
            margin: const EdgeInsets.all(10.0),
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
                  trailing: IconButton(
                    icon: Icon(Icons.more_horiz, color: Colors.white,),
                    onPressed: (){
                      //Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> new Message()));
                    },
                  ),
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
                            new Text("${ readed }", style: TextStyle(color: Colors.white, fontSize: 20.0)),
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

        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(Ranking.tag);
          },
          child: Card(
            color: Colors.lightBlueAccent,
            elevation: 5.0,
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: new Column(
              //横轴起始测对齐
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new ListTile(
                  title: Text(
                    '昨日关键词排名',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.more_horiz, color: Colors.white,),
                    onPressed: (){
                      print('点击昨日关键词排名');
                    },
                  ),
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
          ),
        ),

        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(FlowStatistics.tag);
          },
          child: Card(
            color: Colors.deepPurpleAccent,
            elevation: 5.0,
            margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
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
                  trailing: IconButton(
                    icon: Icon(Icons.more_horiz, color: Colors.white,),
                    onPressed: (){
                      print('点击访客流量');
                    },
                  ),
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
                            new Text("${ newVisit }", style: TextStyle(color: Colors.white, fontSize: 20.0)),
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
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
              "Copyright ©2018 祥云平台",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.0, color: Colors.grey)
          ),
        )
      ],
    );
  }
}