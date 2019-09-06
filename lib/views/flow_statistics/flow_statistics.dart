import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:waimao/model/visit_by_day_info.dart';
import 'package:waimao/utils/data_utils.dart';
import 'package:waimao/utils/progress_dialog.dart';
import 'package:waimao/views/flow_statistics/visitors_info_select.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:waimao/views/home_page.dart';

class FlowStatistics extends StatefulWidget {
  static String tag = 'flow-statistics';

  @override
  FlowStatisticsState createState() => new FlowStatisticsState();
}

class FlowStatisticsState extends State<FlowStatistics> {
  bool _loading = false;
  List<VisitByDayInfo> rows = [VisitByDayInfo(key: DateTime.now(), pv: 0, uv: 0)];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    try {
      await _loadData();
      // if failed,use refreshFailed()
      _refreshController.refreshCompleted();
    } catch (e) {
      _refreshController.refreshFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(237, 237, 237, 1),
        appBar: AppBar(
          title: Text('流量统计'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).popAndPushNamed(HomePage.tag);
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
        body: Stack(
          children: <Widget>[
            SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              header: WaterDropHeader(),
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: ListView(
                padding: EdgeInsets.all(15),
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
                                padding: EdgeInsets.symmetric(vertical: 5.0),
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
                                          DataCell(Text(
                                              new DateFormat('yyyy-MM-dd')
                                                  .format(row.key))),
                                          DataCell(Text(
                                            row.uv.toString(),
                                            textAlign: TextAlign.end,
                                          )),
                                          DataCell(Text(row.pv.toString())),
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
                              SizedBox(height: 10,),
                              Container(
                                  height: 200,
                                  child: getLegendCustomizedChart(true)
//                            DateTimeComboLinePointChart.withVisitByDayData(
//                                rows),
                                  )
                            ],
                          ))),
                ],
              ),
            ),
            ProgressDialog(
                isLoading: _loading,
                message: '正在加载...',
                alpha: 0.35,
                child: Container()),
          ],
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    _initData();
    super.initState();
  }

  void _initData() async {
    try {
      setState(() {
        _loading = true;
      });
      await _loadData();
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  _loadData() async {
    var formatter = new DateFormat('yyyy-MM-dd');
    var from = new DateTime.now().add(new Duration(days: -29));
    var to = new DateTime.now();
    String fromDate = formatter.format(from);
    String toDate = formatter.format(to);
    List<VisitByDayInfo> list =
        await DataUtils.visitByDay({'fromDate': fromDate, 'toDate': toDate});
    setState(() {
      rows = list;
      rows.sort((a, b) => b.key.compareTo(a.key));
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

  SfCartesianChart getLegendCustomizedChart(bool isTileView) {
    return SfCartesianChart(
        plotAreaBorderColor: Colors.transparent,
        title: ChartTitle(
            text: isTileView ? '' : 'Automobile production by category'),
        legend: Legend(
          position: LegendPosition.top,
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap,
        ),
        primaryXAxis: DateTimeAxis(
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            majorGridLines: MajorGridLines(width: 0),
            dateFormat: DateFormat.Md()),
        primaryYAxis: NumericAxis(
          minimum: 0,
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(size: 0),
        ),
        series: getLineSeries(isTileView),
        trackballBehavior: TrackballBehavior(
            enable: true,
            activationMode: ActivationMode.singleTap,
            tooltipSettings: InteractiveTooltip(
                format: 'point.x : point.y', borderWidth: 0)));
  }

  List<ChartSeries<VisitByDayInfo, DateTime>> getLineSeries(bool isTileView) {
    return <ChartSeries<VisitByDayInfo, DateTime>>[
      LineSeries<VisitByDayInfo, DateTime>(
        width: 2,
        markerSettings: MarkerSettings(isVisible: false),
        dataSource: rows,
        xValueMapper: (VisitByDayInfo sales, _) => sales.key,
        yValueMapper: (VisitByDayInfo sales, _) => sales.uv,
        color: Color.fromRGBO(104, 126, 244, 1),
        name: 'uv',
      ),
      LineSeries<VisitByDayInfo, DateTime>(
          markerSettings: MarkerSettings(isVisible: false),
          width: 2,
          dataSource: rows,
          color: Color.fromRGBO(104, 186, 244, 1),
          xValueMapper: (VisitByDayInfo sales, _) => sales.key,
          yValueMapper: (VisitByDayInfo sales, _) => sales.pv,
          name: 'pv'),
    ];
  }
}
