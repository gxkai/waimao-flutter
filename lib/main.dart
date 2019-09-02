import 'package:flutter/material.dart';
import 'package:waimao/utils/provider.dart';
import 'package:waimao/utils/shared_preferences.dart';
import 'package:waimao/views/flow_statistics/access_time.dart';
import 'package:waimao/views/flow_statistics/areal_distribution.dart';
import 'package:waimao/views/flow_statistics/flow_statistics.dart';
import 'package:waimao/views/flow_statistics/terminal_device.dart';
import 'package:waimao/views/flow_statistics/visitors_info_select.dart';
import 'package:waimao/views/home_page.dart';
import 'package:waimao/views/keyword_ranking/keyword_ranking.dart';
import 'package:waimao/views/login_page.dart';
import 'package:waimao/views/message/message.dart';
import 'package:waimao/views/mine/index.dart';

//import 'views/welcome_page/index.dart';

SpUtil sp;
var db;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    HomePage.tag: (context) => HomePage(),
    MinePage.tag: (context) => MinePage(),
    MessageList.tag: (context) => MessageList(),
    FlowStatistics.tag: (context) => FlowStatistics(),
    AccessTime.tag: (context) => AccessTime(),
    TerminalDevice.tag: (context) => TerminalDevice(),
    ArealDistribution.tag: (context) => ArealDistribution(),
    FlowStatisticsSelect.tag: (context) => FlowStatisticsSelect(),
    KeywordRanking.tag: (context) => KeywordRanking()
  };

  @override
  void initState() {
    super.initState();
  }

  showWelcomePage() {
    var authorization = sp.get('Authorization');
    if(authorization != null) {
      return HomePage();
    } else {
      return LoginPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'title',
      home: new Scaffold(body: showWelcomePage()),
      debugShowCheckedModeBanner: false,
      routes: routes,
    );
  }
}

void main() async {
  final provider = new Provider();
  await provider.init(true);
  sp = await SpUtil.getInstance();
  db = Provider.db;
  runApp(new MyApp());
}
