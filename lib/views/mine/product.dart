import 'package:flutter/material.dart';

class Product extends StatelessWidget {
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
                    trailing: Text('天津双街钢管有限公司')
                ),
                Divider(),
                ListTile(
                  title: Text('套餐版本'),
                  trailing: Text('标准版'),
                ),
                Divider(),
                ListTile(
                  title: Text('服务开始时间'),
                  trailing: Text('2018-10-17'),
                ),
                Divider(),
                ListTile(
                  title: Text('服务年限'),
                  trailing: Text('1'),
                ),
                Divider()
              ],
            ),
        ),
      ),
    );
  }
}