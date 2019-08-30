import 'package:flutter/material.dart';
import 'package:waimao/charts/line_chart/stacked_area.dart';
import 'package:waimao/views/flow_statistics/visitors_info_select.dart';

class FlowStatistics extends StatefulWidget {
  static String tag = 'flow-statistics';

  @override
  FlowStatisticsState createState() => new FlowStatisticsState();
}

class FlowStatisticsState extends State<FlowStatistics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('流量统计'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
                Navigator.pop(context);
            }
                ),
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
      body: Container(
        padding: EdgeInsets.all(15),
        alignment: AlignmentDirectional.topCenter,
        color:  Color.fromRGBO(237, 237, 237, 1),
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
                        Text("最近30天浏览/访客量", style: TextStyle(color: Colors.black),)
                      ],
                    ),
                    SizedBox(height: 20,),
                    Table(
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
                                      child: Text("日期"),
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
                                      child: Text("2019-07-31"),
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
                    )
                  ],
                )
              )
            ),
            SizedBox(height: 10,),
            Card(
                color: Colors.white,
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text("最近30天浏览/访客量折线图", style: TextStyle(color: Colors.black),)
                          ],
                        ),
                        Container(
                          height: 200,
                          child: StackedAreaLineChart.withSampleData(),
                        )
                      ],
                    )
                )
            ),
            Row(
              children: <Widget>[
              ],
            )
          ],
        ),
      )
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
  void didUpdateWidget(FlowStatistics oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}