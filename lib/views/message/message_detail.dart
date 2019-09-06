import 'package:flutter/material.dart';
import 'package:waimao/model/message.dart';
import 'package:waimao/utils/TelAndSmsService.dart';
import 'package:waimao/utils/ServiceLocator.dart';

// 询盘详情
class DetailPage extends StatelessWidget {
  final Message message;
  final TelAndSmsService _service = locator<TelAndSmsService>();

  DetailPage({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('询盘信息'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        color: Color.fromRGBO(237, 237, 237, 1),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: <Widget>[
              ListTile(
                title: Text('发件人: ${message.name}'),
              ),
              Divider(
                height: 10.0,
                indent: 0.0,
                color: Colors.black26,
              ),
              ListTile(
                title: Text('电话: ${message.phone}'),
              ),
              Divider(
                height: 10.0,
                indent: 0.0,
                color: Colors.black26,
              ),
              ListTile(
                title: Text('邮箱: ${message.email}'),
              ),
              Divider(
                height: 10.0,
                indent: 0.0,
                color: Colors.black26,
              ),
              ListTile(
                title: Text('地址: ${message.address}'),
              ),
              Divider(
                height: 10.0,
                indent: 0.0,
                color: Colors.black26,
              ),
              ListTile(
                title: Text('内容: ${message.content}'),
              ),
              SizedBox(height: 40),
              RaisedButton(
                  color: Colors.blue,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text("回复", style: TextStyle(color: Colors.white),),
                  ),
                  onPressed: (){
                    print(message.email);
                    _service.sendEmail(message.email);
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}