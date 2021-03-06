import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:waimao/model/visit_by_country_info.dart';
import 'package:waimao/provider/provider_widget.dart';
import 'package:waimao/provider/view_state_widget.dart';
import 'package:waimao/view_model/areal_distribution_model.dart';
import 'package:waimao/views/flow_statistics/visitors_info_select.dart';
import 'package:waimao/views/home_page.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

class ArealDistribution extends StatefulWidget {
  static String tag = 'areal-distribution';
  @override
  ArealDistributionState createState() => new ArealDistributionState();
}

class ArealDistributionState extends State<ArealDistribution> {
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
          title: Text("地域分布"),
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
        body: ProviderWidget<ArealDistributionModel>(
            onModelReady: (model) async => await model.initData(),
            model: ArealDistributionModel(b0, b0),
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
                      if (tabController == null) {
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
                          } else if (model.items.isEmpty) {
                            return ViewStateEmptyWidget();
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
                                children: [
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
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    "日期范围:${model.fromDate}-${model.toDate}",
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                  height: 200,
                                                  child: getLegendDefaultChart(
                                                      true, model.items))
                                            ],
                                          ))),
                                  Card(
                                    child: Container(
                                      height: 300,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: ListView(
                                        children: <Widget>[
                                          DataTable(
                                            columnSpacing: 10,
                                            columns: [
                                              DataColumn(
                                                label: Text('序列'),
                                              ),
                                              DataColumn(
                                                label: Text('国家地区'),
                                              ),
                                              DataColumn(
                                                label: Text('浏览量uv'),
                                              ),
                                              DataColumn(
                                                label: Text('访客量pv'),
                                              ),
                                            ],
                                            rows: model.items.map((item) {
                                              return DataRow(cells: [
                                                DataCell(Text(
                                                    (model.items.indexOf(item) + 1)
                                                        .toString())),
                                                DataCell(
                                                  SizedBox(
                                                      width: 80.0,
                                                      child: Text(item.key)),
                                                ),
                                                DataCell(
                                                    Text(item.uv.toString())),
                                                DataCell(
                                                    Text(item.pv.toString())),
                                              ]);
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ));
                          return TabBarView(
                              children: List.generate(
                                  tabs.length, (index) => tabWidget));
                        }));
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
  void didUpdateWidget(ArealDistribution oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  SfCircularChart getLegendDefaultChart(bool isTileView, List items) {
    return SfCircularChart(
      title: ChartTitle(text: isTileView ? '' : 'Electricity sectors'),
      legend:
          Legend(isVisible: true, overflowMode: LegendItemOverflowMode.none),
      series: getPieSeries(isTileView, items),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  List<DoughnutSeries<VisitByCountryInfo, String>> getPieSeries(
      bool isTileView, List items) {
    return <DoughnutSeries<VisitByCountryInfo, String>>[
      DoughnutSeries<VisitByCountryInfo, String>(
          dataSource: items,
          xValueMapper: (VisitByCountryInfo data, _) => data.key,
          yValueMapper: (VisitByCountryInfo data, _) => data.pv,
          startAngle: 90,
          endAngle: 90,
          dataLabelSettings: DataLabelSettings(
              isVisible: true, labelPosition: LabelPosition.inside)),
    ];
  }
}
