import 'package:flutter/material.dart';
import 'package:waimao/views/message/message_detail.dart';

class Message extends StatefulWidget {
  static String tag = '询盘信息';

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  TabController _tabController;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new DefaultTabController(
      length: 3,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('询盘信息'),
          centerTitle: true,
          bottom: new PreferredSize(
              preferredSize: Size.fromHeight(48),
              child: Material(
                color: Colors.white,
                child: TabBar(
                  indicatorColor: Colors.blue,//选中下划线颜色,如果使用了indicator这里设置无效
                  controller: _tabController,
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.black54,
                  tabs: <Widget>[
                    new Tab(text: '所有信息'),
                    new Tab(text: '已读信息'),
                    new Tab(text: '未读信息'),
                  ],
                ),
              ),
            )
        ),
        body: new TabBarView(
          children: <Widget>[
            new Center(child: RenderList(type: 1)),
            new Center(child: RenderList(type: 2)),
            new Center(child: RenderList(type: 3)),
          ],
        ),
      ),
    );
  }
}

class RenderList extends StatefulWidget {
  final int type;
  RenderList({Key key, this.type }): super(key : key);
  @override
  _RenderListState createState() => _RenderListState();
}

class _RenderListState extends State<RenderList> {

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: (){
          _onRefresh();
        },
        child: Container(
            padding: const EdgeInsets.all(10.0),
            color: Colors.grey[300],
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                children: <Widget>[
                  DataTable(
                      columns: [
                        DataColumn(label: Text('发件人')),
                        DataColumn(label: Text('未读')),
                        DataColumn(label: Text('询盘时间')),
                        DataColumn(label: Text('操作')),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text('张三')),
                          DataCell(RaisedButton(child: Text('未读'),onPressed: (){showDetail();})),
                          DataCell(Text('2019-6-1')),
                          DataCell(
                              Text('查看'),
                              onTap: (){
                                showDetail();
                              }
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('张三')),
                          DataCell(RaisedButton(child: Text('未读'),onPressed: (){showDetail();})),
                          DataCell(Text('2019-6-1')),
                          DataCell(
                              Text('查看'),
                              onTap: (){
                                showDetail();
                              }
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('张三')),
                          DataCell(RaisedButton(child: Text('未读'),onPressed: (){showDetail();})),
                          DataCell(Text('2019-6-1')),
                          DataCell(
                              Text('查看'),
                              onTap: (){
                                showDetail();
                              }
                          ),
                        ]),
                      ]
                  )
                ],
              ),
            )
        )

    );
  }

  void showDetail() {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => MessageDetail()));
  }
  Future<Null> _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000), () {
      print('refresh');
      setState(() {

      });
    });
  }
}