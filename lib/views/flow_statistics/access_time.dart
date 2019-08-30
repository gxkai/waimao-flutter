import 'package:flutter/material.dart';
import 'package:waimao/charts/line_chart/stacked_area.dart';
import 'package:waimao/utils/data_utils.dart';
import 'package:waimao/views/flow_statistics/visitors_info_select.dart';

class AccessTime extends StatefulWidget {
  static String tag = 'access-time';

  @override
  AccessTimeState createState() => new AccessTimeState();
}

class AccessTimeState extends State<AccessTime> {
  @override
  Widget build(BuildContext context) {
    final _kTabPages = <Widget>[
      Container(
        padding: EdgeInsets.all(15),
        alignment: AlignmentDirectional.topCenter,
        color: Color.fromRGBO(237, 237, 237, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
                color: Colors.white,
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "访客时间统计表（24小时）",
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: Table(
                              border: TableBorder.all(
                                  color: Color.fromRGBO(227, 227, 227, 1),
                                  width: 1.0,
                                  style: BorderStyle.solid),
                              children: const [
                                TableRow(
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(241, 241, 241, 1)),
                                  children: [
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                  ],
                                ),
                                TableRow(
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(255, 255, 255, 1)),
                                  children: [
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                  ],
                                ),
                                TableRow(
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(241, 241, 241, 1)),
                                  children: [
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                  ],
                                ),
                                TableRow(
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(255, 255, 255, 1)),
                                  children: [
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                  ],
                                ),
                                TableRow(
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(241, 241, 241, 1)),
                                  children: [
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                  ],
                                ),
                                TableRow(
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(255, 255, 255, 1)),
                                  children: [
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                  ],
                                ),
                                TableRow(
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(241, 241, 241, 1)),
                                  children: [
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                  ],
                                ),
                                TableRow(
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(255, 255, 255, 1)),
                                  children: [
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                    TableCell(
                                        child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text('00'),
                                      ),
                                    )),
                                  ],
                                ),
                              ],
                            ))
                          ],
                        )
                      ],
                    ))),
            SizedBox(
              height: 10,
            ),
            Card(
                color: Colors.white,
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "访问时间分布",
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                        Container(
                          height: 200,
                          child: StackedAreaLineChart.withSampleData(),
                        )
                      ],
                    ))),
            Row(
              children: <Widget>[],
            )
          ],
        ),
      ),
      Center(
        child: Icon(
          Icons.cloud,
          color: Colors.teal,
        ),
      ),
      Center(
        child: Icon(
          Icons.cloud,
          color: Colors.teal,
        ),
      ),
      Center(
        child: Icon(
          Icons.cloud,
          color: Colors.teal,
        ),
      ),
      Center(
        child: Icon(
          Icons.cloud,
          color: Colors.teal,
        ),
      ),
    ];
    final _kTabs = <Tab>[
      Tab(
        text: '今日',
      ),
      Tab(
        text: '昨天',
      ),
      Tab(
        text: '最近7天',
      ),
      Tab(
        text: '最近30天',
      ),
      Tab(
        text: '自定义',
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("访问时间"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                IconData(0xe67e, fontFamily: "iconfont"),
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(FlowStatisticsSelect.tag);
              }),
        ],
      ),
      body: DefaultTabController(
        length: _kTabs.length,
        child: Scaffold(
          appBar: PreferredSize(
              child: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                bottom: TabBar(
                    tabs: _kTabs,
                    labelColor: Colors.blue,
                    labelStyle: TextStyle(fontSize: 15),
                    unselectedLabelColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelPadding: EdgeInsets.zero),
              ),
              preferredSize: Size.fromHeight(60)),
          body: TabBarView(children: _kTabPages),
        ),
      ),
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
  void didUpdateWidget(AccessTime oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
