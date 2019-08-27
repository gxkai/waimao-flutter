import 'package:flutter/material.dart';

class VisitorsInfoSelect extends StatefulWidget {
  static String tag = 'visitors-info-select';

  @override
  VisitorsInfoSelectState createState() => new VisitorsInfoSelectState();
}

class VisitorsInfoSelectState extends State<VisitorsInfoSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('访客信息选择'),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {
          Navigator.pop(context);
        }),
        actions: <Widget>[
          SizedBox(
            height: 10,
            width: 60,
            child: Center(
              child: GestureDetector(
                onTap: () { Navigator.pop(context); },
                child: Text("关闭",
                  style: TextStyle(fontSize: 16),),),),)
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: GridView.count(
          crossAxisCount: 4,
          padding: EdgeInsets.all(20),
          children: [
            Column(
              children: <Widget>[
                Icon(Icons.home),
                SizedBox(height: 10,),
                GestureDetector(
                  child: Text("流量统计"),
                  onTap: () {},
                )
              ],
            ),
            Column(
              children: <Widget>[
                Icon(Icons.home),
                SizedBox(height: 10,),
                GestureDetector(
                  child: Text("访问时间"),
                  onTap: () {},
                )
              ],
            ),
            Column(
              children: <Widget>[
                Icon(Icons.home),
                SizedBox(height: 10,),
                GestureDetector(
                  child: Text("地域分布"),
                  onTap: () {},
                )
              ],
            ),
            Column(
              children: <Widget>[
                Icon(Icons.home),
                SizedBox(height: 10,),
                GestureDetector(
                  child: Text("终端设备"),
                  onTap: () {},
                )
              ],
            )
          ]
      ),)
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(VisitorsInfoSelect oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}