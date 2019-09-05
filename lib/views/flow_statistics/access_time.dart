import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:waimao/charts/combo_chart/numeric_line_point.dart';
import 'package:waimao/model/visit_by_hour_info.dart';
import 'package:waimao/utils/data_utils.dart';
import 'package:waimao/utils/progress_dialog.dart';
import 'package:waimao/views/flow_statistics/visitors_info_select.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:waimao/views/home_page.dart';

class AccessTime extends StatefulWidget {
  static String tag = 'access-time';

  @override
  AccessTimeState createState() => new AccessTimeState();
}

class AccessTimeState extends State<AccessTime>
    with SingleTickerProviderStateMixin {
  bool click = false;
  bool _loading = false;
  static TabController tabController;
  List<Tab> _kTabs;
  List<VisitByHourInfo> items = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  static var formatter = new DateFormat('yyyy-MM-dd');
  String b29 =
      formatter.format(new DateTime.now().add(new Duration(days: -29)));
  String b6 = formatter.format(new DateTime.now().add(new Duration(days: -6)));
  String b1 = formatter.format(new DateTime.now().add(new Duration(days: -1)));
  String b0 = formatter.format(new DateTime.now());
  String fromDate;
  String toDate;

  void _onRefresh() async {
    try {
      await _loadData(fromDate, toDate);
      _refreshController.refreshCompleted();
    } catch (e) {
      _refreshController.loadFailed();
    }
    // if failed,use refreshFailed()
  }

  @override
  Widget build(BuildContext context) {
    final _kTabPageContainer = ListView(
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
                              children: [
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
                                            child: Text('01'),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text('02'),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text('03'),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text('04'),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text('05'),
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
                                            child: Text(items.isEmpty
                                                ? '0'
                                                : items[0].docCount.toString()),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text(items.isEmpty
                                                ? '0'
                                                : items[1].docCount.toString()),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text(items.isEmpty
                                                ? '0'
                                                : items[2].docCount.toString()),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text(items.isEmpty
                                                ? '0'
                                                : items[3].docCount.toString()),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text(items.isEmpty
                                                ? '0'
                                                : items[4].docCount.toString()),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text(items.isEmpty
                                                ? '0'
                                                : items[5].docCount.toString()),
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
                                            child: Text('06'),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text('07'),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text('08'),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text('09'),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text('10'),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text('11'),
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
                                            child: Text(items.isEmpty
                                                ? '0'
                                                : items[6].docCount.toString()),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text(items.isEmpty
                                                ? '0'
                                                : items[7].docCount.toString()),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text(items.isEmpty
                                                ? '0'
                                                : items[8].docCount.toString()),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text(items.isEmpty
                                                ? '0'
                                                : items[9].docCount.toString()),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text(items.isEmpty
                                                ? '0'
                                                : items[10].docCount.toString()),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text(items.isEmpty
                                                ? '0'
                                                : items[11].docCount.toString()),
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
                                            child: Text('12'),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text('13'),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text('14'),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text('15'),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text('16'),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text('17'),
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
                                            child: Text(items.isEmpty
                                                ? '0'
                                                : items[12].docCount.toString()),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text(items.isEmpty
                                                ? '0'
                                                : items[13].docCount.toString()),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text(items.isEmpty
                                                ? '0'
                                                : items[14].docCount.toString()),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text(items.isEmpty
                                                ? '0'
                                                : items[15].docCount.toString()),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text(items.isEmpty
                                                ? '0'
                                                : items[16].docCount.toString()),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text(items.isEmpty
                                                ? '0'
                                                : items[17].docCount.toString()),
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
                                            child: Text('18'),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text('19'),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text('20'),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text('21'),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text('22'),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text('23'),
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
                                            child: Text(items.isEmpty
                                                ? '0'
                                                : items[18].docCount.toString()),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text(items.isEmpty
                                                ? '0'
                                                : items[19].docCount.toString()),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text(items.isEmpty
                                                ? '0'
                                                : items[20].docCount.toString()),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text(items.isEmpty
                                                ? '0'
                                                : items[21].docCount.toString()),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text(items.isEmpty
                                                ? '0'
                                                : items[22].docCount.toString()),
                                          ),
                                        )),
                                    TableCell(
                                        child: SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text(items.isEmpty
                                                ? '0'
                                                : items[23].docCount.toString()),
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
                      child: NumericComboLinePointChart.withVisitByHourData(
                          items),
                    )
                  ],
                )
            )
        ),
      ],
    );
    final _kTabPage = SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      header: WaterDropHeader(),
      controller: _refreshController,
      onRefresh: _onRefresh,
      child: _kTabPageContainer,
    );
    final _kTabPages = <Widget>[
      _kTabPage,
      _kTabPage,
      _kTabPage,
      _kTabPage,
      _kTabPage
    ];
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
      body: Scaffold(
          backgroundColor: Color.fromRGBO(237, 237, 237, 1),
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
                  labelPadding: EdgeInsets.zero,
                  controller: tabController,
                ),
              ),
              preferredSize: Size.fromHeight(60)),
          body: Stack(
            children: <Widget>[
              TabBarView(
                children: _kTabPages,
                controller: tabController,
              ),
              ProgressDialog(
                  isLoading: _loading,
                  message: '正在加载...',
                  alpha: 0.35,
                  child: Container()),
            ],
          )),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fromDate = b0;
    toDate = b0;
    _initData(fromDate, toDate);
    _kTabs = [
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
            click = true;
            tabController.animateTo(4);
            final List<DateTime> picked = await DateRagePicker.showDatePicker(
                context: context,
                locale: Locale("zh"),
                initialFirstDate: new DateTime.now(),
                initialLastDate: new DateTime.now(),
                firstDate: new DateTime(2000),
                lastDate: new DateTime.now());
            if (picked != null && picked.length == 2) {
              fromDate = formatter.format(picked[0]);
              toDate = formatter.format(picked[1]);
              _initData(fromDate, toDate);
            }
          },
        ),
      ),
    ];
    // 添加监听器
    tabController = TabController(length: _kTabs.length, vsync: this)
      ..addListener(() async {
        if (tabController.index.toDouble() == tabController.animation.value) {
          switch (tabController.index) {
            case 0:
              print(0);
              fromDate = b0;
              toDate = b0;
              _initData(fromDate, toDate);
              break;
            case 1:
              print(1);
              fromDate = b1;
              toDate = b1;
              _initData(fromDate, toDate);
              break;
            case 2:
              print(2);
              fromDate = b6;
              toDate = b0;
              _initData(fromDate, toDate);
              break;
            case 3:
              print(3);
              fromDate = b29;
              toDate = b0;
              _initData(fromDate, toDate);
              break;
            case 4:
              print(4);
              if(click == false) {
                final List<DateTime> picked = await DateRagePicker.showDatePicker(
                    context: context,
                    locale: Locale("zh"),
                    initialFirstDate: new DateTime.now(),
                    initialLastDate: new DateTime.now(),
                    firstDate: new DateTime(2000),
                    lastDate: new DateTime.now());
                if (picked != null && picked.length == 2) {
                  fromDate = formatter.format(picked[0]);
                  toDate = formatter.format(picked[1]);
                  _initData(fromDate, toDate);
                }
              } else {
                click = false;
              }
              break;
          }
        }
      });
  }

  _loadData(String fromDate, String toDate) async {
    List<VisitByHourInfo> list =
        await DataUtils.visitByHour({'fromDate': fromDate, 'toDate': toDate});
    setState(() {
      items = list;
    });
  }

  void _initData(String fromDate, String toDate) async {
    try {
      setState(() {
        _loading = true;
      });
      await _loadData(fromDate, toDate);
    } finally {
      setState(() {
        _loading = false;
      });
    }
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
