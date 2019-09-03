import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:waimao/charts/legends/datum_legend_with_measures.dart';
import 'package:waimao/model/visit_by_country_info.dart';
import 'package:waimao/utils/data_utils.dart';
import 'package:waimao/views/flow_statistics/visitors_info_select.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

class ArealDistribution extends StatefulWidget {
  static String tag = 'areal-distribution';

  @override
  ArealDistributionState createState() => new ArealDistributionState();
}

class ArealDistributionState extends State<ArealDistribution>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  List<LinearSales> lsList = new List();
  List<VisitByCountryInfo> items = new List();
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
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  RefreshController _refreshControllerDefault =
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
      // if failed,use refreshFailed()
      _refreshController.refreshCompleted();
    } catch(e) {
      _refreshController.loadFailed();
    }
  }

  void _onRefreshDefault() async {
    try {
      await _loadData(fromDate, toDate);
      // if failed,use refreshFailed()
      _refreshControllerDefault.refreshCompleted();
    } catch(e) {
      _refreshControllerDefault.loadFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _kTabPageContainer = Container(
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
                            "访问者国家地区比重",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: <Widget>[
                          Text(
                            "日期范围:$fromDate-$toDate",
                            style: TextStyle(
                              fontSize: 12
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 200,
                        child: DatumLegendWithMeasures.withSampleData(lsList),
                      )
                    ],
                  ))),
          Card(
            child: Container(
              height: 300,
              padding: EdgeInsets.all(16.0),
              child: ListView(
                children: <Widget>[
                  DataTable(
                    columnSpacing: 20,
                    columns: [
                      DataColumn(
                        label: Text('序列'),
                      ),
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
                    rows: items.map((item) {
                      return DataRow(cells: [
                        DataCell(Text((items.indexOf(item) + 1).toString())),
                        DataCell(Text(item.key)),
                        DataCell(Text(item.pv.toString())),
                        DataCell(Text(item.uv.toString())),
                      ]);
                    }).toList(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
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
      SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: WaterDropHeader(),
        controller: _refreshControllerDefault,
        onRefresh: _onRefreshDefault,
        child: _kTabPageContainer,
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
        body: TabBarView(
          children: _kTabPages,
          controller: tabController,
        ),
      ),
    );
  }

  _loadData(String fromDate, String toDate) async {
    List<VisitByCountryInfo> list = await DataUtils.visitByCountry(
        {'fromDate': fromDate, 'toDate': toDate});
    lsList.clear();
    list.forEach((item) {
      lsList.add(new LinearSales(item.key, item.pv));
    });
    setState(() {
      items = list;
      lsList = lsList;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fromDate = b0;
    toDate = b0;
    // 添加监听器
    tabController = TabController(length: _kTabs.length, vsync: this)
      ..addListener(() async {
        if (tabController.index.toDouble() == tabController.animation.value) {
          switch (tabController.index) {
            case 0:
              print(0);
              fromDate = b0;
              toDate = b0;
              break;
            case 1:
              print(1);
              fromDate = b1;
              toDate = b1;
              break;
            case 2:
              print(2);
              fromDate = b6;
              toDate = b0;
              break;
            case 3:
              print(3);
              fromDate = b29;
              toDate = b0;
              break;
            case 4:
              print(4);
              final List<DateTime> picked = await DateRagePicker.showDatePicker(
                  context: context,
                  initialFirstDate: new DateTime.now(),
                  initialLastDate: new DateTime.now(),
                  firstDate: new DateTime(2000),
                  lastDate: new DateTime.now());
              if (picked != null && picked.length == 2) {
                fromDate = formatter.format(picked[0]);
                toDate = formatter.format(picked[1]);
                _loadData(fromDate, toDate);
              }
              break;
          }
        }
      });
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
