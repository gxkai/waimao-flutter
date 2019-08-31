import 'package:flutter/material.dart';
import 'package:waimao/views/components/drawer.dart';
import 'package:waimao/views/mine/product.dart';
import 'package:waimao/views/mine/changePassword.dart';
import 'package:waimao/views/mine/about.dart';

class MinePage extends StatelessWidget {
  static String tag = '我的';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("我的"),
        centerTitle: true,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              // 打开侧边菜单
              Scaffold.of(context).openDrawer();
            },
          );
        }),
      ),
      drawer: new MyDrawer(), //侧边栏
      body: new Index(),
    );
  }
}

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.grey[200],
        child:ListView(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0)
                ),
                child: ListTile(
                  leading: Image.asset("assets/images/logo.png", width: 40.0,),
                  title: Text("超级管理员"),
                  subtitle: Text("登录账号：master"),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: ListTile(
                        title: Text("我的产品"),
                        trailing: Icon(Icons.arrow_forward_ios, size: 14.0,),
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => MyProduct()));
                        },
                      ),
                    ),
                    Divider(),

                    Container(
                      child: ListTile(
                        title: Text("修改密码"),
                        trailing: Icon(Icons.arrow_forward_ios, size: 14.0,),
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ChangePassword()));
                        },
                      ),
                    ),
                    Divider(),

                    Container(
                      child: ListTile(
                        title: Text("关于"),
                        trailing: Icon(Icons.arrow_forward_ios, size: 14.0,),
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => About()));
                        },
                      ),
                    )
                  ],
                )
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text('退出登录',
                    textAlign:TextAlign.center,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              )
            ]
        )
    );
  }
}