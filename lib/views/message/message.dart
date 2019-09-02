import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:waimao/utils/data_utils.dart';
import 'package:waimao/model/message.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessageList extends StatefulWidget {
  static String tag = '询盘信息';

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<MessageList> {
  TabController _tabController;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new DefaultTabController(
      length: 3,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('询盘信息'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }
          ),
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
                    new Tab(text: '未读信息'),
                    new Tab(text: '已读信息'),
                  ],
                ),
              ),
            )
        ),
        body: new TabBarView(
          children: <Widget>[
            new Center(child: RenderList(type: 0)),
            new Center(child: RenderList(type: 2)),
            new Center(child: RenderList(type: 1)),
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

  List<Message> messages = [];

  // 上拉加载提示
  bool _isAll = false;

  RefreshController _refreshController = RefreshController(initialRefresh: true);
  ScrollController _scrollController = ScrollController(); //listview的控制器
  int _page = 1; //加载的页数

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('加载更多');
        _getMore(widget.type);
      }
    });
  }

  void _onRefresh() async {
    await getData(widget.type);
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  getData(int type) async{
    List<Message> list = await DataUtils.message({'type':type, 'page':1, 'limit':10});
    setState(() {
      messages = list;
    });
  }

  _getMore(int type) async {
      int newPage = _page + 1;
      List<Message> newList =await DataUtils.message({'type':type, 'page':newPage, 'limit':10});
      if (newList.isEmpty) {
        setState(() {
          _isAll = true;
        });
      } else {
        setState(() {
          messages.addAll(newList);
          _page = newPage;
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: WaterDropHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: Container(
            padding: const EdgeInsets.all(10.0),
            color: Colors.grey[300],
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)
              ),
              child: ListView(
                padding: const EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
                children: <Widget>[
                  DataTable(
                      columnSpacing: 30.0,
                      columns: [
                        DataColumn(label: Text('发件人')),
                        DataColumn(label: Text('状态')),
                        DataColumn(label: Text('询盘时间')),
                        DataColumn(label: Text('操作')),
                      ],
                      rows: messages.map((row) {
                        return DataRow(cells: [
                          DataCell(Text(row.name)),
                          DataCell(
                            SizedBox(
                                width: 60.0,
                                child: RaisedButton(
                                    color: row.isRead == 1 ? Colors.grey : Colors.blue,
                                    child: Text(row.isRead == 1 ? '已读' : '未读',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {

                                    }
                                )
                            ),
                          ),
                          DataCell(Text(new DateFormat('yyyy-MM-dd').format(
                              row.createdAt))),
                          DataCell(
                              Text('查看'),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(message: row),));
                              }
                          )
                        ]);
                      }).toList(),
                  ),
                  _isAll ? Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text('没有更多内容', textAlign: TextAlign.center,)
                  ) : Container()
                ],
                controller: _scrollController,
              ),
            )
        )

    );
  }
}


// 询盘详情
class DetailPage extends StatelessWidget {

  final Message message;

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
            }
        ),
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
                title: Text('发件人: ${ message.name }'),
              ),
              Divider(height:10.0,indent:0.0,color: Colors.black26,),
              ListTile(
                title: Text('电话: ${ message.phone }'),
              ),
              Divider(height:10.0,indent:0.0,color: Colors.black26,),
              ListTile(
                title: Text('邮箱: ${ message.email }'),
              ),
              Divider(height:10.0,indent:0.0,color: Colors.black26,),
              ListTile(
                title: Text('地址: ${ message.address }'),
              ),
              Divider(height:10.0,indent:0.0,color: Colors.black26,),
              ListTile(
                title: Text('内容: ${ message.content }'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
