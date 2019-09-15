import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:waimao/model/visit_by_hour_info.dart';
import 'package:waimao/provider/provider_widget.dart';
import 'package:waimao/provider/view_state_widget.dart';
import 'package:waimao/view_model/access_time_model.dart';
import 'package:waimao/views/flow_statistics/visitors_info_select.dart';
import 'package:waimao/views/home_page.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

class AccessTime extends StatefulWidget {
  static String tag = 'access-time';
  @override
  AccessTimeState createState() => new AccessTimeState();
}

class AccessTimeState extends State<AccessTime> {
  TabController tabController;
  bool click = false;
  static var formatter = new DateFormat('yyyy-MM-dd');
  final String b29 =
      formatter.format(new DateTime.now().add(new Duration(days: -29)));
  final String b6 =
      formatter.format(new DateTime.now().add(new Duration(days: -6)));
  final String b1 =
      formatter.format(new DateTime.now().add(new Duration(days: -1)));
  final String b0 = formatter.format(new DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("访问时间"),
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
        body: ProviderWidget<AccessTimeModel>(
            onModelReady: (model) async => await model.initData(),
            model: AccessTimeModel(b0, b0),
            builder: (context, model, child) {
              List<Tab> tabs = [
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
                  child: GestureDetector(
                    child: Text("自定义"),
                    onTap: () async {
                      if(tabController == null) {
                        tabController = DefaultTabController.of(context);
                      }
                      tabController.animateTo(4);
                      final List<DateTime> picked =
                      await DateRagePicker.showDatePicker(
                          context: context,
                          locale: Locale("zh"),
                          initialFirstDate: new DateTime.now(),
                          initialLastDate: new DateTime.now(),
                          firstDate: new DateTime(2000),
                          lastDate: new DateTime.now());
                      if (picked != null && picked.length == 2) {
                        await model.changeData(formatter.format(picked[0]),
                            formatter.format(picked[1]));
                      }
                    },
                  ),
                ),
              ];
              return DefaultTabController(
                  length: tabs.length,
                  initialIndex: model.index,
                  child: Builder(builder: (context) {
                    return Scaffold(
                        backgroundColor: Color.fromRGBO(237, 237, 237, 1),
                        appBar: PreferredSize(
                            child: AppBar(
                              backgroundColor: Colors.white,
                              elevation: 0,
                              bottom: TabBar(
                                tabs: tabs,
                                labelColor: Colors.blue,
                                labelStyle: TextStyle(fontSize: 15),
                                unselectedLabelColor: Colors.black,
                                indicatorSize: TabBarIndicatorSize.label,
                                labelPadding: EdgeInsets.zero,
                              ),
                            ),
                            preferredSize: Size.fromHeight(60)),
                        body: Builder(builder: (BuildContext context) {
                          if (model.busy) {
                            return Center(child: CircularProgressIndicator());
                          } else if (model.error) {
                            return ViewStateWidget(onPressed: model.initData);
                          }
                          if (tabController == null) {
                            tabController = DefaultTabController.of(context);
                            tabController.addListener(() async {
                              if (tabController.index.toDouble() ==
                                  tabController.animation.value) {
                                model.changeIndex(tabController.index);
                                switch (model.index) {
                                  case 0:
                                    await model.changeData(b0, b0);
                                    break;
                                  case 1:
                                    await model.changeData(b1, b1);
                                    break;
                                  case 2:
                                    await model.changeData(b6, b0);
                                    break;
                                  case 3:
                                    await model.changeData(b29, b0);
                                    print(model.fromDate);
                                    break;
                                  default:
                                    break;
                                }
                              }
                            });
                          }
                          List<TableRow> tableRows = [];
                          List.generate(4, (index) {
                            tableRows.addAll([
                              TableRow(
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(241, 241, 241, 1)),
                                  children: List.generate(
                                      6,
                                          (index1) => TableCell(
                                          child: SizedBox(
                                            height: 30,
                                            child: Center(
                                              child: Text(model
                                                  .items[index1 + index * 6].key),
                                            ),
                                          )))),
                              TableRow(
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(255, 255, 255, 1)),
                                  children: List.generate(
                                      6,
                                          (index1) => TableCell(
                                          child: SizedBox(
                                            height: 30,
                                            child: Center(
                                              child: Text(
                                                  "${model.items[index1 + index * 6].docCount}"),
                                            ),
                                          )))),
                            ]);
                          });
                          Widget tabWidget = SmartRefresher(
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
                                                  "访客时间统计表（24小时）",
                                                  style:
                                                  TextStyle(color: Colors.black),
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
                                                            color: Color.fromRGBO(
                                                                227, 227, 227, 1),
                                                            width: 1.0,
                                                            style: BorderStyle.solid),
                                                        children: tableRows))
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
                                                  style:
                                                  TextStyle(color: Colors.black),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                                height: 200,
                                                child: getLegendCustomizedChart(
                                                    true, model.items))
                                          ],
                                        ))),
                              ],
                            ),
                          );
                          return TabBarView(
                              children: List.generate(
                                  tabs.length, (index) => tabWidget));
                        })
                    );
                  }));
            }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
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

  SfCartesianChart getLegendCustomizedChart(bool isTileView, List items) {
    return SfCartesianChart(
        plotAreaBorderColor: Colors.transparent,
        title: ChartTitle(
            text: isTileView ? '' : 'Automobile production by category'),
        legend: Legend(
          position: LegendPosition.top,
          isVisible: false,
          overflowMode: LegendItemOverflowMode.wrap,
        ),
        primaryXAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          minimum: 0,
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(size: 0),
        ),
        series: getLineSeries(isTileView, items),
        trackballBehavior: TrackballBehavior(
            enable: true,
            activationMode: ActivationMode.singleTap,
            tooltipSettings: InteractiveTooltip(
                format: 'point.x : point.y', borderWidth: 0)));
  }

  List<ChartSeries<VisitByHourInfo, num>> getLineSeries(
      bool isTileView, List items) {
    return <ChartSeries<VisitByHourInfo, num>>[
      LineSeries<VisitByHourInfo, num>(
        width: 2,
        markerSettings: MarkerSettings(isVisible: false),
        dataSource: items,
        color: Color.fromRGBO(104, 186, 244, 1),
        xValueMapper: (VisitByHourInfo sales, _) => int.parse(sales.key),
        yValueMapper: (VisitByHourInfo sales, _) => sales.docCount,
        name: 'uv',
      ),
    ];
  }
}
