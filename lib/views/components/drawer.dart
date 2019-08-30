import 'package:flutter/material.dart';
import 'package:waimao/views/flow_statistics/flow_statistics.dart';
import "package:waimao/views/home_page.dart";
import "package:waimao/views/mine/index.dart";
import "package:waimao/views/message/message.dart";

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        // DrawerHeader consumes top MediaQuery padding.
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('首页'),
                    contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                    onTap: (){
                      Navigator.of(context).pushNamed(HomePage.tag);
                    },
                  ),
                  Divider(height:10.0,indent:0.0,color: Colors.black26,),

                  ListTile(
                    leading: const Icon(Icons.message),
                    title: const Text('询盘信息'),
                    contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                    onTap: (){
                      Navigator.of(context).pushNamed(Message.tag);
                    }
                  ),
                  Divider(height:10.0,indent:0.0,color: Colors.black26,),
                  ListTile(
                    leading: const Icon(Icons.equalizer),
                    title: const Text('关键词排名'),
                    contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                    onTap: (){
                      print('关键词排名');
                    },
                  ),
                  Divider(height:10.0,indent:0.0,color: Colors.black26,),

                  ListTile(
                    leading: const Icon(Icons.trending_up),
                    title: const Text('访客流量'),
                    contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                    onTap: (){
                      Navigator.of(context).pushNamed(FlowStatistics.tag);
                    },
                  ),
                  Divider(height:10.0,indent:0.0,color: Colors.black26,),

                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('我的'),
                    contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                    onTap: (){
                      Navigator.of(context).pushNamed(MinePage.tag);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}