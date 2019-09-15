import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:waimao/provider/provider_widget.dart';
import 'package:waimao/provider/view_state_widget.dart';
import 'package:waimao/view_model/home_model.dart';
import 'package:waimao/views/components/drawer.dart';
import 'package:waimao/views/flow_statistics/flow_statistics.dart';
import 'package:waimao/views/keyword_ranking/keyword_ranking.dart';
import 'package:waimao/views/message/message.dart';

class HomePage extends StatefulWidget {
  static String tag = '首页';

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text("外贸易"),
      leading: IconButton(
          icon: Icon(IconData(0xe64f, fontFamily: "iconfont"), size: 15),
          onPressed: () => _scaffoldKey.currentState.openDrawer()),
    );
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar,
      drawer: new MyDrawer(height: appBar.preferredSize.height), //侧边栏
      body: new HomeContent(),
    );
  }
}

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<HomeModel>(
        model: HomeModel(),
        onModelReady: (model) {
          model.initData();
        },
        builder: (context, model, child) {
          if (model.busy) {
            return Center(child: CircularProgressIndicator());
          } else if (model.error) {
            return ViewStateWidget(onPressed: model.initData);
          }
          return SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            header: WaterDropHeader(),
            controller: model.refreshController,
            onRefresh: () async {
              await model.refresh();
            },
            child: ListView(
              children: <Widget>[
                Card(
                  elevation: 5.0,
                  margin: const EdgeInsets.all(15.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.lightBlue,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(MessageList.tag);
                      },
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new ListTile(
                            contentPadding: EdgeInsets.only(
                                top: 16, left: 16, right: 16),
                            title: Text(
                              '询盘数量',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            trailing: Icon(Icons.more_horiz, color: Colors.white,),
                          ),
                          ListTile(
                            leading: Icon(
                              IconData(0xe834, fontFamily: "iconfont"), size: 40.0,
                              color: Colors.white,),
                            contentPadding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                            trailing: Text(
                              '${ model.messageCount }',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Divider(height: 10.0, indent: 0.0, color: Colors.white,),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text("${ model.todayCount }",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 20.0)),
                                      new Text("今日询盘",
                                          style: TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                                flex: 1,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text("${ model.unread }",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 20.0)),
                                      new Text("未读询盘",
                                          style: TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                                flex: 1,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text("${ model.isRead }",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 20.0)),
                                      new Text("已读询盘",
                                          style: TextStyle(color: Colors.white)),
                                    ],
                                  ),

                                ),
                                flex: 1,
                              ),
                            ],
                          ),
                          SizedBox(height: 16,)
                        ],
                      ),
                    ),
                  ),
                ),

                Card(
                  elevation: 5.0,
                  margin: const EdgeInsets.only(left: 15.0, right: 15.0),
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
                              contentPadding: EdgeInsets.only(
                                  top: 16, left: 16, right: 16),
                              title: Text(
                                '关键词排名',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              trailing: Icon(Icons.more_horiz, color: Colors.white,),
                            ),
                            ListTile(
                              leading: Icon(
                                IconData(0xe661, fontFamily: "iconfont"), size: 40.0,
                                color: Colors.white,),
                              contentPadding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                              trailing: Text(
                                '${ model.keywords }',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Divider(height: 10.0, indent: 0.0, color: Colors.white,),
                            new Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: new Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Text("${ model.firstPageKeywords }",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 20.0)),
                                        new Text("第一页排名数量",
                                            style: TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: new Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Text("${ model.secondPageKeywords }",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 20.0)),
                                        new Text("第二页排名数量",
                                            style: TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: new Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Text("${ model.thirdPageKeywords }",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 20.0)),
                                        new Text("第三页排名数量",
                                            style: TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                  flex: 1,
                                ),
                              ],
                            ),
                            SizedBox(height: 16,)
                          ],
                        ),
                      )
                  ),
                ),

                Card(
                  elevation: 5.0,
                  margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                  child: Material(
                      borderRadius: BorderRadius.circular(4.0),
                      color: Colors.deepPurpleAccent,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(FlowStatistics.tag);
                        },
                        child: new Column(
                          //横轴起始测对齐
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new ListTile(
                              contentPadding: EdgeInsets.only(
                                  top: 16, left: 16, right: 16),
                              title: Text(
                                '访客流量',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              trailing: Icon(Icons.more_horiz, color: Colors.white,),
                            ),
                            ListTile(
                              leading: Icon(
                                IconData(0xe636, fontFamily: "iconfont"), size: 40.0,
                                color: Colors.white,),
                              contentPadding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                              trailing: Text(
                                '${ model.pv }',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Divider(height: 10.0, indent: 0.0, color: Colors.white,),

                            new Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: new Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Text("${ model.pv }",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 20.0)),
                                        new Text("浏览量PV",
                                            style: TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                  flex: 2,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: new Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Text("${ model.uv }",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 20.0)),
                                        new Text("访客量UV",
                                            style: TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                  flex: 2,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: new Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Text("${ model.newVisit }%",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 20.0)),
                                        new Text("新访量百分比",
                                            style: TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                  flex: 2,
                                ),
                              ],
                            ),
                            SizedBox(height: 16,)
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
            ),
          );
        });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
