import 'package:flutter/material.dart';
import 'package:waimao/model/keyword_count.dart';
import 'package:waimao/models/keyword.dart';
import 'package:waimao/models/keywordData.dart';
import 'package:waimao/utils/data_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:waimao/utils/progress_dialog.dart';

class KeywordRanking extends StatefulWidget {
  static String tag = 'keyword-ranking';

  @override
  KeywordRankingState createState() => new KeywordRankingState();
}

class KeywordRankingState extends State<KeywordRanking> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  bool _loading = false;
  int _limit = 8;
  int _currentPage = 1;
  int _lastPage = 1;
  List<TableRow> _tableRows = new List();
  KeywordCount keywordCount;
  num sum = 0;
  num first = 0;
  num second = 0;
  num third = 0;

  Map<num, String> _rank = {1: '首', 2: '二', 3: '三'};

  void _onRefresh() async {
    try {
      await _loadData();
      // if failed,use refreshFailed()
      _refreshController.refreshCompleted();
    } catch (e) {
      _refreshController.refreshFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    final RankingCount = Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '第一页排名数量',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          first.toString(),
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Divider(color: Colors.blue)
                    ],
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '第二页排名数量',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          second.toString(),
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Divider(color: Colors.blue)
                    ],
                  ),
                ),
                flex: 1,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '第三页排名数量',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          third.toString(),
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Divider(color: Colors.blue)
                    ],
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '合计',
                        style: TextStyle(fontSize: 16),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          sum.toString(),
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Divider(color: Colors.blue)
                    ],
                  ),
                ),
                flex: 1,
              ),
            ],
          ),
        ],
      ),
    );
    final RankingList = Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: <Widget>[
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                //列宽
                0: FlexColumnWidth(0.6),
                1: FlexColumnWidth(2.0),
                2: FlexColumnWidth(1.2),
              },
              //表格边框样式
              border: TableBorder.all(
                color: Color.fromRGBO(227, 227, 227, 1),
                width: 1.0,
                style: BorderStyle.solid,
              ),
              children: _tableRows,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                MaterialButton(
                  onPressed: () async {
                    if (_currentPage > 1) {
                      setState(() {
                        _currentPage--;
                      });
                      try {
                        setState(() {
                          _loading = true;
                        });
                        await _loadKeyword();
                      } finally {
                        setState(() {
                          _loading = false;
                        });
                      }
                    }
                  },
                  child: Text(_currentPage > 1 ? '上一页' : ''),
                ),
                Text("$_currentPage / $_lastPage"),
                MaterialButton(
                  onPressed: () async {
                    if (_currentPage < _lastPage) {
                      setState(() {
                        _currentPage++;
                      });
                      try {
                        setState(() {
                          _loading = true;
                        });
                        await _loadKeyword();
                      } finally {
                        setState(() {
                          _loading = false;
                        });
                      }
                    }
                  },
                  child: Text(_currentPage < _lastPage ? '下一页' : ''),
                )
              ],
            )
          ],
        ));
    return Scaffold(
        backgroundColor: Color.fromRGBO(237, 237, 237, 1),
        appBar: AppBar(
          title: Text('关键词排名'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Stack(
          children: <Widget>[
            SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                header: WaterDropHeader(),
                controller: _refreshController,
                onRefresh: _onRefresh,
                child: ListView(
                    padding: EdgeInsets.all(15),
                    children: <Widget>[RankingCount, RankingList])),
            ProgressDialog(
                isLoading: _loading,
                message: '正在加载...',
                alpha: 0.35,
                child: Container()),
          ],
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tableRows.add(
      TableRow(
          //第一行样式 添加背景色
          decoration: BoxDecoration(
            color: Color.fromRGBO(241, 241, 241, 1),
          ),
          children: [
            // 表头
            Text(
              '序号',
              style: TextStyle(color: Colors.black, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                '关键词',
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
            Text(
              '最新排名',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ]),
    );
    _initData();
  }

  _loadKeywordCount() async {
    KeywordCount keywordCount = await DataUtils.visitByKeywordCount();
    setState(() {
      first = keywordCount.first;
      second = keywordCount.second;
      third = keywordCount.third;
      sum = keywordCount.first + keywordCount.second + keywordCount.third;
    });
  }

  _loadKeyword() async {
    Keyword keyword = await DataUtils.visitByKeywordData(
        {"limit": _limit.toString(), "page": _currentPage.toString()});
    List<KeywordData> list = keyword.data;
    num currentPage = keyword.currentPage;
    num lastPage = keyword.lastPage;
    num serialNumber = _limit * (currentPage - 1); // 序号累加数
    if (_tableRows.length > 1) {
      _tableRows.removeRange(1, _tableRows.length);
    }
    list.forEach((item) {
      _tableRows.add(TableRow(children: [
        Text(
          (list.indexOf(item) + 1 + serialNumber).toString(),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            item.keyword,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: FlatButton(
            onPressed: (){},
            color: Colors.blue,
            textColor: Colors.white,
            highlightColor: Colors.blue[700],
            splashColor: Colors.blue[700],
            child: Text('${_rank[item.page]}: ${item.number}', style: TextStyle(fontSize: 13),),
          ),
        ),
      ]));
    });
    setState(() {
      _tableRows = _tableRows;
      _currentPage = currentPage;
      _lastPage = lastPage;
    });
  }

  _initData() async {
    try {
      setState(() {
        _loading = true;
      });
      await _loadData();
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  _loadData() async {
    await _loadKeywordCount();
    await _loadKeyword();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(KeywordRanking oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
