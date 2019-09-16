import 'package:flutter/material.dart';
import 'package:waimao/provider/provider_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:waimao/provider/view_state_widget.dart';
import 'package:waimao/view_model/keyword_ranking_model.dart';

class KeywordRanking extends StatefulWidget {
  static String tag = 'keyword-ranking';

  @override
  KeywordRankingState createState() => new KeywordRankingState();
}

class KeywordRankingState extends State<KeywordRanking> {
  List<TableRow> _tableRows = [TableRow(
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
      ])];
  Map<num, String> _rank = {1: '首', 2: '二', 3: '三'};
  @override
  Widget build(BuildContext context) {
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
        body: ProviderWidget<KeywordRankingModel>(
          model: KeywordRankingModel(1),
          onModelReady: (model) async => await model.initData(),
          builder: (context, model, child) {
            if (model.busy) {
              return Center(child: CircularProgressIndicator());
            } else if (model.error) {
              return ViewStateWidget(onPressed: model.initData);
            }
            Widget rankingCount = Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5.0)),
              ),
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
                                  "${model.first}",
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
                                  "${model.second}",
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
                                  "${model.third}",
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
                                  "${model.sum}",
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


            if (_tableRows.length > 1) {
              _tableRows.removeRange(1, _tableRows.length);
            }
            model.list.forEach((item) {
              _tableRows.add(TableRow(children: [
                Text(
                  (model.list.indexOf(item) + 1 + model.serialNumber).toString(),
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
            Widget rankingList = Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0))),
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: <Widget>[
                    Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
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
                            model.setBusy(true);
                            await model.loadPage(direction: Direction.backup);
                            model.setBusy(false);
                          },
                          child: Text(model.currentPage > 1 ? '上一页' : ''),
                        ),
                        Text("${model.currentPage} / ${model.lastPage}"),
                        MaterialButton(
                          onPressed: () async {
                            model.setBusy(true);
                            await model.loadPage(direction: Direction.forward);
                            model.setBusy(false);
                          },
                          child: Text(
                              model.currentPage < model.lastPage ? '下一页' : ''),
                        )
                      ],
                    )
                  ],
                ));
            return SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                header: WaterDropHeader(),
                controller: model.refreshController,
                onRefresh: () async => await model.refresh(),
                child: ListView(
                    padding: EdgeInsets.all(15),
                    children: <Widget>[rankingCount, rankingList]));
          },
        ));
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
