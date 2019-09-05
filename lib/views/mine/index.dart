import 'package:flutter/material.dart';
import 'package:waimao/views/components/drawer.dart';
import 'package:waimao/views/mine/product.dart';
import 'package:waimao/views/mine/changePassword.dart';
import 'package:waimao/views/mine/about.dart';
import 'package:waimao/views/login_page.dart';
import 'package:waimao/utils/shared_preferences.dart';

SpUtil sp;
class MinePage extends StatelessWidget {
  static String tag = '我的';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("我的"),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.menu),
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
  String role;
  String username;

  // 退出登录弹窗
  _logOutDialog() {
    return AlertDialog(
      content: Text('确定退出登录吗？'),
      actions: <Widget>[
        FlatButton(
          child: Text('取消', style: TextStyle(color: Colors.blue[500]),),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('确定', style: TextStyle(color: Colors.blue[500]),),
          onPressed: () {
            logOut();
            Navigator.of(context).pushNamedAndRemoveUntil(LoginPage.tag, (route) => route == null);
          },
        ),
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfo();
  }

  getInfo() async{
    sp = await SpUtil.getInstance();
    print(sp.get('role'));
    setState(() {
      role = sp.get('role');
      username = sp.get('username');
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Color.fromRGBO(237, 237, 237, 1),
        child:ListView(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0)
                ),
                child: ListTile(
                  leading: Image.asset("assets/images/logo.png", width: 40.0,),
                  title: Text("${ role }"),
                  subtitle: Text("登录账号：${ username }"),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
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
                margin: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)
                ),
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  child: InkWell(
                    onTap: () => showDialog(
                        context: context, builder: (_) => _logOutDialog()
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text('退出登录',
                        textAlign:TextAlign.center,
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                    ),
                  ),
                )
              )
            ]
        )
    );
  }
  
  void logOut() async{
    sp = await SpUtil.getInstance();
    // 清空本地存储的信息
    sp.clear();
  } 
}