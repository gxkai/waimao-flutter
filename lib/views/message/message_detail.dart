import 'package:flutter/material.dart';

class MessageDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('询盘信息'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        color: Colors.grey[200],
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0)
          ),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            children: <Widget>[
              ListTile(
                title: Text('发件人:Peng Michael'),
              ),
              Divider(height:10.0,indent:0.0,color: Colors.black26,),
              ListTile(
                title: Text('电话:Peng Michael'),
              ),
              Divider(height:10.0,indent:0.0,color: Colors.black26,),
              ListTile(
                title: Text('邮箱:Peng Michael'),
              ),
              Divider(height:10.0,indent:0.0,color: Colors.black26,),
              ListTile(
                title: Text('地址:Peng Michael'),
              ),
              Divider(height:10.0,indent:0.0,color: Colors.black26,),
              ListTile(
                title: Text('内容:Peng MichaelPeng MichaelPeng MichaelPeng MichaelPeng MichaelPeng MichaelPeng MichaelPeng MichaelPeng MichaelPeng Michael'),
              )
            ],
          ),
        ),
      ),
    );
  }
}