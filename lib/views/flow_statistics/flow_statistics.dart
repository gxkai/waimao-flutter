import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:waimao/charts/combo_chart/date_time_line_point.dart';
import 'package:waimao/model/visit_by_day_info.dart';
import 'package:waimao/utils/data_utils.dart';
import 'package:waimao/views/flow_statistics/visitors_info_select.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FlowStatistics extends StatefulWidget {
  static String tag = 'flow-statistics';

  @override
  FlowStatisticsState createState() => new FlowStatisticsState();
}

class FlowStatisticsState extends State<FlowStatistics> {
  List<VisitByDayInfo> rows = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  void _onRefresh() async {
    try {
      await loadData();
      // if failed,use refreshFailed()
      _refreshController.refreshCompleted();
    } catch (e) {
      _refreshController.refreshFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('流量统计'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                IconData(0xe65f, fontFamily: "iconfont"),
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(FlowStatisticsSelect.tag);
              }),
        ],
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: WaterDropHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: Container(
          padding: EdgeInsets.all(15),
          alignment: AlignmentDirectional.topCenter,
          color: Color.fromRGBO(237, 237, 237, 1),
          child: ListView(
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
                                "最近30天浏览/访客量",
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                          Container(
                            height: 300,
                            padding: EdgeInsets.all(16.0),
                            child: ListView(
                              children: <Widget>[
                                DataTable(
                                  columnSpacing: 20,
                                  columns: [
                                    DataColumn(
                                      label: Text('日期'),
                                    ),
                                    DataColumn(
                                      label: Text('浏览量uv'),
                                    ),
                                    DataColumn(
                                      label: Text('访客量pv'),
                                    ),
                                  ],
                                  rows: rows.map((row) {
                                    return DataRow(cells: [
                                      DataCell(Text(new DateFormat('yyyy-MM-dd')
                                          .format(row.key))),
                                      DataCell(Text(row.pv.toString())),
                                      DataCell(Text(row.uv.toString())),
                                    ]);
                                  }).toList(),
                                ),
                              ],
                            ),
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
                                "最近30天浏览/访客量折线图",
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                          Container(
                            height: 200,
                            child:
                                DateTimeComboLinePointChart.withVisitByDayData(
                                    rows),
                          )
                        ],
                      ))),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  loadData() async {
    var formatter = new DateFormat('yyyy-MM-dd');
    var from = new DateTime.now().add(new Duration(days: -29));
    var to = new DateTime.now();
    String fromDate = formatter.format(from);
    String toDate = formatter.format(to);
    List<VisitByDayInfo> list =
        await DataUtils.visitByDay({'fromDate': fromDate, 'toDate': toDate});
    setState(() {
      rows = list;
    });
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
