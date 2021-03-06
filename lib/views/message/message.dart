//import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
//import 'package:waimao/utils/data_utils.dart';
//import 'package:waimao/model/message_model.dart';
//import 'package:waimao/views/message/message_detail.dart';
//import 'package:pull_to_refresh/pull_to_refresh.dart';  // 下拉刷新
//import 'package:waimao/utils/progress_dialog.dart';     // 加载动画
//
//class MessageList extends StatefulWidget {
//  static String tag = '询盘信息';
//
//  @override
//  _MessageState createState() => _MessageState();
//}
//
//class _MessageState extends State<MessageList> {
//  TabController _tabController;
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return new DefaultTabController(
//      length: 3,
//      child: new Scaffold(
//        backgroundColor: Color.fromRGBO(237, 237, 237, 1),
//        appBar: new AppBar(
//            title: new Text('询盘信息'),
//            leading: IconButton(
//                icon: Icon(Icons.arrow_back_ios),
//                onPressed: () {
//                  Navigator.pop(context);
//                }),
//            bottom: new PreferredSize(
//              preferredSize: Size.fromHeight(48),
//              child: Material(
//                color: Colors.white,
//                child: TabBar(
//                  indicatorColor: Colors.blue, //选中下划线颜色,如果使用了indicator这里设置无效
//                  controller: _tabController,
//                  labelColor: Colors.blue,
//                  unselectedLabelColor: Colors.black54,
//                  tabs: <Widget>[
//                    new Tab(text: '所有信息'),
//                    new Tab(text: '未读信息'),
//                    new Tab(text: '已读信息'),
//                  ],
//                ),
//              ),
//            )),
//        body: new TabBarView(
//          children: <Widget>[
//            new Center(child: RenderList(type: 0)),
//            new Center(child: RenderList(type: 2)),
//            new Center(child: RenderList(type: 1)),
//          ],
//        ),
//      ),
//    );
//  }
//
//  @override
//  void didUpdateWidget(MessageList oldWidget) {
//    // TODO: implement didUpdateWidget
//    super.didUpdateWidget(oldWidget);
//  }
//}
//
//class RenderList extends StatefulWidget {
//  final int type;
//  RenderList({Key key, this.type}) : super(key: key);
//  @override
//  _RenderListState createState() => _RenderListState();
//}
//
//class _RenderListState extends State<RenderList> {
//  List<Message> messages = [];
//
//  bool _loading = false;
//  // 上拉加载提示
//  bool _loadingMore = false;
//  bool _isAll = false;
//
//  RefreshController _refreshController =
//      RefreshController(initialRefresh: false);
//  ScrollController _scrollController = ScrollController(); //listview的控制器
//  int _page = 1; //加载的页数
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    _initData();
//    _scrollController.addListener(() {
//      if (_scrollController.position.pixels ==
//          _scrollController.position.maxScrollExtent) {
//        print('加载更多');
//        _getMore(widget.type);
//      }
//    });
//  }
//
//  void _onRefresh() async {
//    try {
//      await getData(widget.type);
//      // if failed,use refreshFailed()
//      _refreshController.refreshCompleted();
//    } catch (e) {
//      _refreshController.loadFailed();
//    }
//  }
//
//  void _initData() async {
//    try {
//      setState(() {
//        _loading = true;
//      });
//      await getData(widget.type);
//    } finally {
//      setState(() {
//        _loading = false;
//      });
//    }
//  }
//
//  getData(int type) async {
//    List<Message> list =
//        await DataUtils.message({'type': type, 'page': 1, 'limit': 12});
//    setState(() {
//      messages = list;
//    });
//  }
//
//  _getMore(int type) async {
//    if (!_loadingMore) {
//      setState(() {
//        _loadingMore = true;
//      });
//      int newPage = _page + 1;
//      List<Message> newList =
//      await DataUtils.message({'type': type, 'page': newPage, 'limit': 12});
//      if (newList.isEmpty) {
//        setState(() {
//          _isAll = true;
//        });
//      } else {
//        await Future.delayed(Duration(milliseconds: 500), () {
//          setState(() {
//            messages.addAll(newList);
//            _page = newPage;
//            _loadingMore = false;
//          });
//        });
//      }
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    final Widget _messageList = ListView(
//            padding: const EdgeInsets.all(15.0),
//            children: <Widget>[
//              Container(
//                padding: EdgeInsets.symmetric(horizontal: 10.0),
//                decoration: BoxDecoration(
//                  color: Colors.white,
//                  borderRadius: BorderRadius.circular(5.0)
//                ),
//                child: Column(
//                  children: <Widget>[
//                    DataTable(
//                      columnSpacing: 10,
//                      horizontalMargin: 0,
//                      columns: [
//                        DataColumn(label: Text('发件人')),
//                        DataColumn(label: Text('状态', textAlign: TextAlign.center,)),
//                        DataColumn(label:  SizedBox(
//                            width: 65.0,
//                            child: Text('询盘时间', textAlign: TextAlign.center,))
//                        ),
//                        DataColumn(label: SizedBox(
//                            width: 70.0,
//                            child:Text('操作', textAlign: TextAlign.center,)
//                          ),
//                        )
//                      ],
//                      rows: messages.map((row) {
//                        return DataRow(cells: [
//                          DataCell(SizedBox(width: 80, child: Text(row.name))),
//                          DataCell(
//                            Container(
//                              padding: EdgeInsets.all(4.0),
//                              margin: EdgeInsets.symmetric(vertical: 10.0),
//                              decoration: BoxDecoration(
//                                  color: row.isRead == 1
//                                      ? Colors.grey
//                                      : Colors.blue,
//                                  borderRadius: BorderRadius.circular(4.0)
//                              ),
//
//                              child: Text(
//                                row.isRead == 1 ? '已读' : '未读',
//                                style: TextStyle(color: Colors.white),
//                              ),
//                            ),
//                          ),
//                          DataCell(Text(new DateFormat('yyyy-MM-dd')
//                              .format(row.createdAt))),
//                          DataCell(
//                              SizedBox(
//                                  width: 70.0,
//                                  child:RaisedButton(
//                                      color: Colors.blue,
//                                      child: Text('查看', style: TextStyle(color:Colors.white)),
//                                      onPressed: () {
//                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(message: row)));
//                                      }
//                                  )
//                              )
//                          )
//                        ]);
//                      }).toList(),
//                    ),
//                    _isAll
//                        ? Container(
//                        padding: EdgeInsets.symmetric(vertical: 10.0),
//                        child: Text(
//                          '没有更多内容',
//                          textAlign: TextAlign.center,
//                        ))
//                        : _loadingMore ? Column(
//                      children: <Widget>[
//                        Padding(
//                          padding: EdgeInsets.only(top: 10.0),
//                          child: SizedBox(
//                              height: 30.0,
//                              child: Image.asset('assets/images/loading.gif')
//                          ),
//                        ),
//                        Padding(
//                          padding: EdgeInsets.symmetric(vertical: 10.0),
//                          child: Text('加载更多'),
//                        )
//                      ],
//                    ) : Container()
//                  ]
//                )
//              )
//            ],
//            controller: _scrollController,
//    );
//
//    return Stack(
//      children: <Widget>[
//        SmartRefresher(
//          enablePullDown: true,
//          enablePullUp: false,
//          header: WaterDropHeader(),
//          controller: _refreshController,
//          onRefresh: _onRefresh,
//          child: _messageList,
//        ),
//        ProgressDialog(
//            isLoading: _loading,
//            message: '正在加载...',
//            alpha: 0.35,
//            child: Container()
//        ),
//      ],
//    );
//  }
//
//  @override
//  void didChangeDependencies() {
//    // TODO: implement didChangeDependencies
//    super.didChangeDependencies();
//  }
//
//  @override
//  void didUpdateWidget(RenderList oldWidget) {
//    // TODO: implement didUpdateWidget
//    super.didUpdateWidget(oldWidget);
//  }
//
//  @override
//  void dispose() {
//    // TODO: implement dispose
//    super.dispose();
//    _scrollController.dispose();
//    _refreshController.dispose();
//  }
//}
//

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:waimao/provider/provider_widget.dart';
import 'package:waimao/provider/view_state_widget.dart';
import 'package:waimao/view_model/message_model.dart';
import 'package:waimao/views/flow_statistics/visitors_info_select.dart';
import 'package:waimao/views/help/refresh_helper.dart';
import 'package:waimao/views/home_page.dart';
import 'package:waimao/views/message/message_detail.dart';

class Message extends StatefulWidget {
  static String tag = '询盘信息';
  @override
  MessageState createState() => new MessageState();
}

class MessageState extends State<Message> {
  ValueNotifier<int> valueNotifier = ValueNotifier(0);
  TabController tabController;
  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = [
      Tab(text: '所有信息'),
      Tab(text: '未读信息'),
      Tab(text: '已读信息'),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("询盘信息"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).popAndPushNamed(HomePage.tag);
            }),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                IconData(0xe65f, fontFamily: "iconfont"),
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(FlowStatisticsSelect.tag);
              }),
        ],
      ),
      body: ValueListenableProvider<int>.value(
        value: valueNotifier,
        child: DefaultTabController(
            length: tabs.length,
            initialIndex: valueNotifier.value,
            child: Builder(builder: (context) {
              return Scaffold(
                  backgroundColor: Color.fromRGBO(237, 237, 237, 1),
                  appBar: PreferredSize(
                      child: AppBar(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        bottom: TabBar(
                          tabs: tabs,
                          labelColor: Colors.blue,
                          labelStyle: TextStyle(fontSize: 15),
                          unselectedLabelColor: Colors.black,
                          indicatorSize: TabBarIndicatorSize.label,
                          labelPadding: EdgeInsets.zero,
                        ),
                      ),
                      preferredSize: Size.fromHeight(60)),
                  body: Builder(builder: (BuildContext context) {
                    if (tabController == null) {
                      tabController = DefaultTabController.of(context);
                      tabController.addListener(() async {
                        valueNotifier.value = tabController.index;
                      });
                    }
                    return TabBarView(
                        children: List.generate(
                            tabs.length, (index) => CellList(index)));
                  }));
            })),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(Message oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}

class CellList extends StatefulWidget {
  final index;
  CellList(this.index);
  @override
  CellListState createState() => new CellListState();
}

class CellListState extends State<CellList> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MessageModel>(
      model: MessageModel(widget.index),
      onModelReady: (model) async => await model.initData(),
      builder: (context, model, child) {
        if (model.busy) {
          return Center(child: CircularProgressIndicator());
        } else if (model.error) {
          return ViewStateWidget(onPressed: model.initData);
        }
        return Container(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 100),
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: WaterDropHeader(),
            footer: RefresherFooter(),
            onLoading: () async {
              await model.loadMore();
            },
            controller: model.refreshController,
            onRefresh: () async {
              await model.refresh();
            },
            child: ListView(
              padding: const EdgeInsets.all(15.0),
              children: <Widget>[
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Column(children: <Widget>[
                      DataTable(
                        columnSpacing: 10,
                        horizontalMargin: 0,
                        columns: [
                          DataColumn(label: Text('发件人')),
                          DataColumn(
                              label: Text(
                            '状态',
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: SizedBox(
                                  width: 65.0,
                                  child: Text(
                                    '询盘时间',
                                    textAlign: TextAlign.center,
                                  ))),
                          DataColumn(
                            label: SizedBox(
                                width: 70.0,
                                child: Text(
                                  '操作',
                                  textAlign: TextAlign.center,
                                )),
                          )
                        ],
                        rows: model.list.map((row) {
                          return DataRow(cells: [
                            DataCell(
                                SizedBox(width: 80, child: Text(row.name))),
                            DataCell(
                              Container(
                                padding: EdgeInsets.all(4.0),
                                margin: EdgeInsets.symmetric(vertical: 10.0),
                                decoration: BoxDecoration(
                                    color: row.isRead == 1
                                        ? Colors.grey
                                        : Colors.blue,
                                    borderRadius: BorderRadius.circular(4.0)),
                                child: Text(
                                  row.isRead == 1 ? '已读' : '未读',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            DataCell(Text(new DateFormat('yyyy-MM-dd')
                                .format(row.createdAt))),
                            DataCell(SizedBox(
                                width: 70.0,
                                child: RaisedButton(
                                    color: Colors.blue,
                                    child: Text('查看',
                                        style: TextStyle(color: Colors.white)),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailPage(message: row)));
                                    })))
                          ]);
                        }).toList(),
                      ),
                    ]))
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(CellList oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
