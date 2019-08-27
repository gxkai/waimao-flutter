import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("外贸易"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(child:
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child:Image(image: AssetImage("assets/images/logo.png"),),
                    ),
                Text("外贸易", style: TextStyle(color: Colors.white, fontSize: 30.0),)
              ],
            ),
                height: 100.0,color:Colors.black87,
                padding: EdgeInsets.only(left: 10.0, top: 55.0)
            ),
            ListTile(
                title: Text("首页"),
                leading: Icon(IconData(0xe699, fontFamily: "iconfont"), color: Colors.black87,)
            ),
            Divider(),
            ListTile(
                title: Text("询盘信息"),
                leading: Icon(IconData(0xe61c, fontFamily: "iconfont"), color: Colors.black87,)
            ),
            Divider(),
            ListTile(
                title: Text("关键词排名"),
                leading: Icon(IconData(0xe613, fontFamily: "iconfont"), color: Colors.black87,)
            ),
            Divider(),
            ListTile(
                title: Text("流量统计"),
                leading: Icon(IconData(0xe612, fontFamily: "iconfont"), color: Colors.black87,)
            ),
            Divider(),
            ListTile(
                title: Text("我的"),
                leading: Icon(IconData(0xe63a, fontFamily: "iconfont"), color: Colors.black87,)
            ),
            Divider()
          ],
        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
      ),
    );
  }
}