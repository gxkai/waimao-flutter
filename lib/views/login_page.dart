import 'package:flutter/material.dart';
import 'package:waimao/model/user_info_cache.dart';
import 'package:waimao/utils/data_utils.dart';
import 'package:waimao/utils/progress_dialog.dart';
import 'package:waimao/views/home_page.dart';
import 'package:loading_overlay/loading_overlay.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;
  // 利用FocusNode和_focusScopeNode来控制焦点 可以通过FocusNode.of(context)来获取widget树中默认的_focusScopeNode
  FocusNode _emailFocusNode = new FocusNode();
  FocusNode _passwordFocusNode = new FocusNode();
  FocusNode _siteFocusNode = new FocusNode();
  FocusScopeNode _focusScopeNode = new FocusScopeNode();
  UserInfoControlModel _userInfoControlModel = new UserInfoControlModel();

  GlobalKey<FormState> _signInFormKey = new GlobalKey();
  TextEditingController _userNameEditingController =
      new TextEditingController();
  TextEditingController _passwordEditingController =
      new TextEditingController();
  TextEditingController _siteEditingController = new TextEditingController();

  bool isShowPassWord = false;
  String username = '';
  String password = '';
  String site = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    try {
      _userInfoControlModel.getAllInfo().then((list) {
        if (list.length > 0) {
          UserInfo _userInfo = list[0];
          print(
              '获取的数据：${_userInfo.username} ${_userInfo.password} ${_userInfo.site}');
          setState(() {
            _userNameEditingController.text = _userInfo.username;
            _passwordEditingController.text = "";
            _siteEditingController.text = _userInfo.site;
            username = _userInfo.username;
            password = _userInfo.password;
            site = _userInfo.site;
          });
        }
      });
    } catch (err) {
      print('读取用户本地存储的用户信息出错 $err');
    }
  }

// 创建登录界面的TextForm
  Widget buildSignInTextForm() {
    return new Form(
      //  * Flutter提供了一个Form widget，它可以对输入框进行分组，然后进行一些统一操作，如输入内容校验、输入框重置以及输入内容保存。
      key: _signInFormKey,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: TextFormField(
              controller: _userNameEditingController,
              //关联焦点
              focusNode: _emailFocusNode,
              onEditingComplete: () {
                if (_focusScopeNode == null) {
                  _focusScopeNode = FocusScope.of(context);
                }
                _focusScopeNode.requestFocus(_passwordFocusNode);
              },

              decoration: new InputDecoration(
                  prefixIcon: Icon(
                    IconData(0xe63a, fontFamily: "iconfont"),
                    color: Colors.white,
                  ),
                  hintText: "账号",
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))),
              style: new TextStyle(fontSize: 16, color: Colors.white),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "账号不可为空!";
                }
              },
              onSaved: (value) {
                setState(() {
                  username = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Flexible(
            child: TextFormField(
              controller: _passwordEditingController,
              //关联焦点
              focusNode: _passwordFocusNode,
              decoration: new InputDecoration(
                  prefixIcon: Icon(
                    IconData(0xe618, fontFamily: "iconfont"),
                    color: Colors.white,
                  ),
                  hintText: "密码",
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))),
              style: new TextStyle(fontSize: 16, color: Colors.white),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "密码不可为空!";
                }
              },
              onSaved: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Flexible(
            child: TextFormField(
              controller: _siteEditingController,
              //关联焦点
              focusNode: _siteFocusNode,
              decoration: new InputDecoration(
                  prefixIcon: Icon(
                    IconData(0xe62b, fontFamily: "iconfont"),
                    color: Colors.white,
                  ),
                  hintText: "网址",
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))),
              style: new TextStyle(fontSize: 16, color: Colors.white),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "网址不可为空!";
                }
              },
              onSaved: (value) {
                setState(() {
                  site = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSignInButton() {
    return Row(
      children: <Widget>[
        Expanded(
            child: MaterialButton(
                color: Colors.blue,
                height: 50,
                elevation: 20,
                onPressed: () {
                  if (_signInFormKey.currentState.validate()) {
                    doLogin();
                  }
                },
                child: Text(
                  "登 录",
                  style: TextStyle(color: Colors.white),
                )))
      ],
    );
  }

  // 登陆操作
  doLogin() {
    _signInFormKey.currentState.save();
    setState(() {
      _loading = true;
    });
    DataUtils.doLogin(
            {'username': username, 'password': password, 'site': site})
        .then((result) {
      print(result);
      try {
        _userInfoControlModel.deleteAll().then((result) {
          // print('删除结果：$result');
          _userInfoControlModel
              .insert(
                  UserInfo(password: password, username: username, site: site))
              .then((value) {
            // print('存储成功:$value');
            Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(builder: (context) => HomePage()),
                (route) => route == null);
          });
        });
      } catch (err) {
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(builder: (context) => HomePage()),
            (route) => route == null);
      }
    }).catchError((onError) {
      print(onError);
    }).whenComplete(() {
      setState(() {
        _loading = false;
      });
    });
  }

// 点击控制密码是否显示
  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
//          color: Theme.of(context).primaryColor,
            alignment: AlignmentDirectional.topCenter,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/login_bg.png"),
                    fit: BoxFit.cover)),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 150.0),
                      Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain,
                        width: 50.0,
                        height: 50.0,
                      ),
                      SizedBox(height: 50.0),
                      buildSignInTextForm(),
                      SizedBox(height: 50.0),
                      buildSignInButton(),
                      SizedBox(height: 35.0),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        ProgressDialog(
            isLoading: _loading,
            message: '正在加载...',
            alpha: 0.35,
            child: Container()),
      ],
    ));
  }
}
