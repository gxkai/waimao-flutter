import 'package:flutter/material.dart';
import 'package:waimao/views/flow_statistics/visitors_info.dart';
import 'package:waimao/views/flow_statistics/visitors_info_select.dart';
import 'package:waimao/views/home_page.dart';
import 'package:waimao/views/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder> {
    LoginPage.tag: (context) => LoginPage(),
    HomePage.tag: (context) => HomePage(),
    VisitorsInfo.tag: (context) => VisitorsInfo(),
    VisitorsInfoSelect.tag: (context) => VisitorsInfoSelect()
  };
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        primaryColor: Colors.black
      ),
      home: new Scaffold(body: showWelcomePage()),
      routes: routes,
    );
  }

  showWelcomePage() {
    return VisitorsInfo();
  }
}
