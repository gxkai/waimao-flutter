import 'package:flutter/material.dart';
import 'package:waimao/views/flow_statistics/access_time.dart';
import 'package:waimao/views/flow_statistics/areal_distribution.dart';
import 'package:waimao/views/flow_statistics/flow_statistics.dart';
import 'package:waimao/views/flow_statistics/terminal_device.dart';

class FlowStatisticsSelect extends StatefulWidget {
  static String tag = 'visitors-info-select';

  @override
  FlowStatisticsSelectState createState() => new FlowStatisticsSelectState();
}

class FlowStatisticsSelectState extends State<FlowStatisticsSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('访客信息选择'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: <Widget>[
            SizedBox(
              height: 10,
              width: 60,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "关闭",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(top: 10),
          child: GridView.count(
              crossAxisCount: 4,
              childAspectRatio: 1.3,
              padding: EdgeInsets.all(20),
              children: [
                Material(
                  child: InkWell(
                    splashColor: Colors.blue[200],
                    highlightColor: Colors.transparent,
                    child: Column(
                      children: <Widget>[
                        Icon(IconData(0xe636, fontFamily: "iconfont")),
                        SizedBox(
                          height: 10,
                        ),
                        Text("流量统计")
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(FlowStatistics.tag);
                    },
                  ),
                ),
                Material(
                  child: InkWell(
                    splashColor: Colors.blue[200],
                    highlightColor: Colors.transparent,
                    child: Column(
                      children: <Widget>[
                        Icon(IconData(0xe619, fontFamily: "iconfont")),
                        SizedBox(
                          height: 10,
                        ),
                        Text("访问时间")
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(AccessTime.tag);
                    },
                  ),
                ),
                Material(
                  child: InkWell(
                    splashColor: Colors.blue[200],
                    highlightColor: Colors.transparent,
                    child: Column(
                      children: <Widget>[
                        Icon(IconData(0xe65b, fontFamily: "iconfont")),
                        SizedBox(
                          height: 10,
                        ),
                        Text("地域分布")
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(ArealDistribution.tag);
                    },
                  ),
                ),
                Material(
                  child: InkWell(
                    splashColor: Colors.blue[200],
                    highlightColor: Colors.transparent,
                    child: Column(
                      children: <Widget>[
                        Icon(IconData(0xe673, fontFamily: "iconfont")),
                        SizedBox(
                          height: 10,
                        ),
                        Text("终端设备")
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(TerminalDevice.tag);
                    },
                  ),
                )
              ]),
        ));
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
  void didUpdateWidget(FlowStatisticsSelect oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
