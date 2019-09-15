import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:waimao/model/visit_by_day_info.dart';
import 'package:waimao/provider/provider_widget.dart';
import 'package:waimao/provider/view_state_widget.dart';
import 'package:waimao/view_model/flow_statistics_model.dart';
import 'package:waimao/views/flow_statistics/visitors_info_select.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:waimao/views/home_page.dart';

class FlowStatistics extends StatefulWidget {
  static String tag = 'flow-statistics';

  @override
  FlowStatisticsState createState() => new FlowStatisticsState();
}

class FlowStatisticsState extends State<FlowStatistics> {
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
        body: MainContent());
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

class MainContent extends StatefulWidget {
  @override
  MainContentState createState() => new MainContentState();
}

class MainContentState extends State<MainContent> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<FlowStatisticsModel>(
      model: FlowStatisticsModel(),
      onModelReady: (model) {
        model.initData();
      },
      builder: (context, model, child) {
        if (model.busy) {
          return Center(child: CircularProgressIndicator());
        } else if (model.error) {
          return ViewStateWidget(onPressed: model.initData);
        }
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: WaterDropHeader(),
          controller: model.refreshController,
          onRefresh: () async {
            await model.refresh();
          },
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
                                  rows: model.rows.map((row) {
                                    return DataRow(cells: [
                                      DataCell(Text(new DateFormat('yyyy-MM-dd')
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
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              height: 200,
                              child: getLegendCustomizedChart(true, model.rows))
                        ],
                      ))),
            ],
          ),
        );
      },
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
  void didUpdateWidget(MainContent oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  SfCartesianChart getLegendCustomizedChart(bool isTileView, List rows) {
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
        series: getLineSeries(isTileView, rows),
        trackballBehavior: TrackballBehavior(
            enable: true,
            activationMode: ActivationMode.singleTap,
            tooltipSettings: InteractiveTooltip(
                format: 'point.x : point.y', borderWidth: 0)));
  }

  List<ChartSeries<VisitByDayInfo, DateTime>> getLineSeries(bool isTileView, List rows) {
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
