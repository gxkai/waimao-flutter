import 'package:demo/views/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  static String tag = 'login-page';

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {

    final logo =
            Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
                image: AssetImage("assets/images/logo.png"),
                fit: BoxFit.cover
            )
          ),
        );
    final name = Text("外贸易",style: TextStyle(fontSize: 20, color: Colors.white),);

    final username = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      initialValue: 'master',
      decoration: InputDecoration(
          prefixIcon: Icon(IconData(0xe63a, fontFamily: "iconfont")),
          hintText: '账号',
          fillColor: Color.fromRGBO(100, 100, 200, 0.1),
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none
          )
      ),
    );

    final password = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      initialValue: '',
      decoration: InputDecoration(
          prefixIcon: Icon(IconData(0xe618, fontFamily: "iconfont")),
          hintText: '密码',
          fillColor: Color.fromRGBO(100, 100, 200, 0.1),
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none
          )
      ),
    );

    final website = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      initialValue: '',
      decoration: InputDecoration(
          prefixIcon: Icon(IconData(0xe634, fontFamily: "iconfont")),
          hintText: '网址',
          fillColor: Color.fromRGBO(100, 100, 200, 0.1),
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none
          )
      ),
    );


    final loginButton = Row(
      children: <Widget>[
        Expanded(
        child:MaterialButton(
            color: Colors.blue,
            elevation: 20,
            onPressed: () {
              Navigator.of(context).pushNamed(HomePage.tag);
            },
            child: Text("登陆", style: TextStyle(color: Colors.white),))
        )
      ],
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 44),
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/login_bg.png"),fit: BoxFit.cover)
      ),
      alignment: AlignmentDirectional.topCenter,
      child: Column(
        children: <Widget>[
          SizedBox(height: 150.0,),
          logo,
          SizedBox(height: 5.0,),
          name,
          SizedBox(height: 30.0,),
          username,
          SizedBox(height: 20.0,),
          password,
          SizedBox(height: 20.0,),
          website,
          SizedBox(height: 30.0,),
          loginButton
        ],
      ),
    );
  }
}