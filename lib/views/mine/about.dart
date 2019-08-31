import 'package:flutter/material.dart';
import 'package:waimao/utils/shared_preferences.dart';

SpUtil sp;

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  String version = 'v0.0.1';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVersion();
  }

  getVersion() async{
    sp = await SpUtil.getInstance();
    setState(() {
      version = sp.get('version');
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('关于'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/wm.png', width: 100.0,),
              Text('版本信息${ version }')
            ],
          ),
        ),
      )
    );
  }
}

