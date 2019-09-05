import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:waimao/utils/data_utils.dart';
import 'package:waimao/utils/shared_preferences.dart';

SpUtil sp;

class MyProduct extends StatefulWidget {

  @override
  _MyProductState createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {

  dynamic product;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("我的产品"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }
        ),
      ),
      body: Container(
            color: Color.fromRGBO(237, 237, 237, 1),
            child: Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0)
              ),
              child: ListView(
                  children: <Widget>[
                    ListTile(
                        title: Text('网站名称'),
                        trailing: Text(product != null ? "${ product['name'] }" :'555')
                    ),
                    Divider(),
                    ListTile(
                      title: Text('套餐版本'),
                      trailing: Text(product != null ? "${ product['package'] }" :'555'),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('服务开始时间'),
                      trailing: Text(product != null ? "${ product['started_at'] }" :'555'),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('服务年限'),
                      trailing: Text(product != null ? "${ product['year'] }年" :'1年'),
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

  loadData() async{
   sp = await SpUtil.getInstance();
   dynamic list = sp.getString('product');

    if ( list == null ) {
      list = await DataUtils.myProduct();
      list = json.encode(list);
      sp.putString('product', list);
    }

    setState(() {
      product = json.decode(list);
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