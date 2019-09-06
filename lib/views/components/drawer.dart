import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:waimao/views/flow_statistics/flow_statistics.dart';
import "package:waimao/views/home_page.dart";
import 'package:waimao/views/keyword_ranking/keyword_ranking.dart';
import "package:waimao/views/mine/index.dart";
import "package:waimao/views/message/message.dart";

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key key, this.height}) : super(key: key);
  final num height;

  @override
  _DrawerState createState() => _DrawerState();
}

class _DrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
          context: context,
          // DrawerHeader consumes top MediaQuery padding.
          removeTop: true,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                    child: Container(
                      color: Color.fromRGBO(240, 240, 240, 1),
                      height: MediaQueryData.fromWindow(window).padding.top,
                    )
                ),
                SizedBox(
                    height: widget.height,
                    child: Container(
                      color: Color.fromRGBO(240, 240, 240, 1),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 12, right: 25),
                            child: ClipOval(
                              child: Image.asset(
                                "assets/images/logo.png",
                                width: 40,
                              ),
                            ),
                          ),
                          Text(
                            "外贸易",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )),
                Expanded(
                    child: Container(
                  color: Colors.white,
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.home),
                        title: const Text('首页'),
                        contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                        onTap: () {
                          Navigator.of(context).pushNamed(HomePage.tag);
                        },
                      ),
                      Divider(
                        height: 10.0,
                        indent: 0.0,
                        color: Colors.black26,
                      ),
                      ListTile(
                          leading: const Icon(Icons.message),
                          title: const Text('询盘信息'),
                          contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                          onTap: () {
                            Navigator.of(context).pushNamed(MessageList.tag);
                          }),
                      Divider(
                        height: 10.0,
                        indent: 0.0,
                        color: Colors.black26,
                      ),
                      ListTile(
                        leading: const Icon(Icons.equalizer),
                        title: const Text('关键词排名'),
                        contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                        onTap: () {
                          Navigator.of(context).pushNamed(KeywordRanking.tag);
                        },
                      ),
                      Divider(
                        height: 10.0,
                        indent: 0.0,
                        color: Colors.black26,
                      ),
                      ListTile(
                        leading: const Padding(padding: EdgeInsets.only(left: 3), child: Icon(
                          IconData(0xe601, fontFamily: "iconfont"),size: 18,)),
                        title: const Text('访客流量'),
                        contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                        onTap: () {
                          Navigator.of(context).pushNamed(FlowStatistics.tag);
                        },
                      ),
                      Divider(
                        height: 10.0,
                        indent: 0.0,
                        color: Colors.black26,
                      ),
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: const Text('我的'),
                        contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                        onTap: () {
                          Navigator.of(context).pushNamed(MinePage.tag);
                        },
                      ),
                    ],
                  ),
                )),
              ],
            ),
          )),
    );
  }
}
