import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:waimao/provider/provider_widget.dart';
import 'package:waimao/provider/view_state_widget.dart';
import 'package:waimao/view_model/product_model.dart';

class MyProduct extends StatefulWidget {
  @override
  _MyProductState createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("我的产品"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: ProviderWidget<ProductModel>(
          model: ProductModel(),
          onModelReady: (model) async => await model.initData(),
          builder: (context, model, child) {
            if (model.busy) {
              return Center(child: CircularProgressIndicator());
            } else if (model.error) {
              return ViewStateWidget(onPressed: model.initData,);
            }
            return Container(
              color: Color.fromRGBO(237, 237, 237, 1),
              child: Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0)),
                child: ListView(
                  children: <Widget>[
                    ListTile(
                        title: Text('网站名称'),
                        trailing: Text("${model.product.name}")),
                    Divider(),
                    ListTile(
                      title: Text('套餐版本'),
                      trailing: Text("${model.product.package}"),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('服务开始时间'),
                      trailing: Text("${model.product.startedAt}"),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('服务年限'),
                      trailing: Text("${model.product.year}年"),
                    ),
                    Divider()
                  ],
                ),
              ),
            );
          },
        ));
  }
}
