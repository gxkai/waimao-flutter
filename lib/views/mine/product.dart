import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:waimao/utils/data_utils.dart';

class MyProduct extends StatefulWidget {

  @override
  _MyProductState createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  var product = {
    'name': '55555',
    'package': '55555',
    'started': '55555',
    'year': 1
  };

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("我的产品"),
        centerTitle: true,
      ),
      body: Container(
            color: Colors.grey[200],
            child: Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0)
              ),
              child: ListView(
                  children: <Widget>[
                    ListTile(
                        title: Text('网站名称'),
                        trailing: Text("${ product['name'] }")
                    ),
                    Divider(),
                    ListTile(
                      title: Text('套餐版本'),
                      trailing: Text('${ product['package'] }'),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('服务开始时间'),
                      trailing: Text('${ product['started'] }'),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('服务年限'),
                      trailing: Text('${ product['year'] }年'),
                    ),
                    Divider()
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
    loadData();
  }

  loadData() {
    DataUtils.myProduct().then((result) {
      setState(() {
        product['name'] = result.name;
        product['package'] = result.package;
        product['started'] = result.started;
        product['year'] = result.year;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(MyProduct oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}