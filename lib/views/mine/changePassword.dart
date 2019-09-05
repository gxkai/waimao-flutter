import 'package:flutter/material.dart';
import 'package:waimao/utils/shared_preferences.dart';
import 'package:waimao/utils/data_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

SpUtil sp;

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String oldPassword;
  String newPassword;
  String rnewPassword;  // 确认新密码

  void _forSubmitted() async{
    var _form = _formKey.currentState;
    _form.save();

    if (_form.validate()) {

      if (newPassword != rnewPassword) {
        Fluttertoast.showToast(
            msg: "两次输入的新密码不一致",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
            textColor: Colors.white,
            fontSize: 16.0
        );
        return ;
      }

      sp = await SpUtil.getInstance();
      String username = sp.get('username');
      String state = await DataUtils.changePassword({
        'username': username,
        'password': newPassword,
        'password_old': oldPassword,
        'password_confirmation': rnewPassword
      });

      if (state == 'success') {
        Fluttertoast.showToast(
            msg: "密码修改成功",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
            textColor: Colors.white,
            fontSize: 16.0
        );
      } else {
        Fluttertoast.showToast(
            msg: "密码修改失败",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
            textColor: Colors.white,
            fontSize: 14.0
        );
        return ;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(237, 237, 237, 1),
      appBar: AppBar(
        title: Text('修改密码'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15.0),
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0)
          ),
          child: Form(
            key: _formKey,

            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  child: TextFormField(
                    decoration: new InputDecoration(
                        hintText: "旧密码",
                        contentPadding: EdgeInsets.all(10.0),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)
                        )
                    ),
                    obscureText: true,
                    style: new TextStyle(fontSize: 16),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "旧密码不可为空!";
                      }
                    },
                    onSaved: (value) {
                      setState(() {
                        oldPassword = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Flexible(
                  child: TextFormField(
                    decoration: new InputDecoration(
                        hintText: "新密码",
                        contentPadding: EdgeInsets.all(10.0),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)
                        )
                    ),
                    obscureText: true,
                    style: new TextStyle(fontSize: 16),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "新密码不可为空!";
                      }
                    },
                    onSaved: (value) {
                      setState(() {
                        newPassword = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Flexible(
                  child: TextFormField(
                    decoration: new InputDecoration(
                        hintText: "确认新密码",
                        contentPadding: EdgeInsets.all(10.0),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)
                        )
                    ),
                    obscureText: true,
                    style: new TextStyle(fontSize: 16),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "确认新密码不可为空!";
                      }
                    },
                    onSaved: (value) {
                      setState(() {
                        rnewPassword = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: MaterialButton(
                            color: Colors.blue,
                            height: 50,
                            onPressed: () {
                              _forSubmitted();
                            },
                            child: Text(
                              "确 认",
                              style: TextStyle(color: Colors.white),
                            )
                        )
                    )
                  ],
                )
              ]
            )
          ),
        ),
      ),
    );
  }
}