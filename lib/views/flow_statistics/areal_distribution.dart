import 'package:flutter/material.dart';
import 'package:waimao/charts/legends/datum_legend_with_measures.dart';
import 'package:waimao/views/flow_statistics/visitors_info_select.dart';

class ArealDistribution extends StatefulWidget {
  static String tag = 'areal-distribution';

  @override
  ArealDistributionState createState() => new ArealDistributionState();
}

class ArealDistributionState extends State<ArealDistribution> {
  @override
  Widget build(BuildContext context) {
    var a = '2019-08-29--2019-08-29';
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
                              "访问者国家地区比重",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[Text("日期范围:$a")],
                        ),
                        Container(
                          height: 200,
                          child: DatumLegendWithMeasures.withRandomData(),
                        )
                      ],
                    ))),
            Card(
              child: Container(
                  child: Table(
                border: TableBorder.all(
                    color: Color.fromRGBO(241, 241, 241, 1),
                    width: 1.0,
                    style: BorderStyle.solid),
                children: const [
                  TableRow(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(241, 241, 241, 1)),
                      children: const [
                        TableCell(
                            child: SizedBox(
                          height: 30,
                          child: Center(
                            child: Text("序列"),
                          ),
                        )),
                        TableCell(
                            child: SizedBox(
                          height: 30,
                          child: Center(
                            child: Text("国家"),
                          ),
                        )),
                        TableCell(
                            child: SizedBox(
                          height: 30,
                          child: Center(
                            child: Text("浏览量PV"),
                          ),
                        )),
                        TableCell(
                            child: SizedBox(
                          height: 30,
                          child: Center(
                            child: Text("访客量UV"),
                          ),
                        ))
                      ]),
                  TableRow(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 1)),
                      children: const [
                        TableCell(
                            child: SizedBox(
                          height: 30,
                          child: Center(
                            child: Text("1"),
                          ),
                        )),
                        TableCell(
                            child: SizedBox(
                          height: 30,
                          child: Center(
                            child: Text("中国"),
                          ),
                        )),
                        TableCell(
                            child: SizedBox(
                          height: 30,
                          child: Center(
                            child: Text("68"),
                          ),
                        )),
                        TableCell(
                            child: SizedBox(
                          height: 30,
                          child: Center(
                            child: Text("28"),
                          ),
                        ))
                      ]),
                ],
              )),
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
        title: Text("地域分布"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          IconButton(
              icon: Icon(IconData(0xe67e, fontFamily: "iconfont"),
                color: Colors.white,),
              onPressed: () {
                Navigator.of(context).pushNamed(FlowStatisticsSelect.tag);
              }
          ),
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
  void didUpdateWidget(ArealDistribution oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
