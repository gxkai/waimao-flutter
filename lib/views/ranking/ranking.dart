import 'package:flutter/material.dart';

class Ranking extends StatelessWidget {
  static String tag = '排名';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('关键词排名'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[200],
        child: Container(
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            children: <Widget>[
              RankingCount(),
              RankingList(),
            ],
          )
        )
      ),
    );
  }
}

class RankingCount extends StatefulWidget {
  @override
  _RankingCountState createState() => _RankingCountState();
}

class _RankingCountState extends State<RankingCount> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      return Container(
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
                        Text('第一页排名数量', style: TextStyle(fontSize: 16.0),),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text('137', style: TextStyle(fontSize: 20.0),),
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
                        Text('第二页排名数量', style: TextStyle(fontSize: 16.0),),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text('28', style: TextStyle(fontSize: 20.0),),
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
                        Text('第三页排名数量', style: TextStyle(fontSize: 16.0),),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text('12', style: TextStyle(fontSize: 20.0),),
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
                        Text('合计', style: TextStyle(fontSize: 16),),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text('177', style: TextStyle(fontSize: 20.0),),
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
  }
}

class RankingList extends StatefulWidget {
  @override
  _RankingListState createState() => _RankingListState();
}

class _RankingListState extends State<RankingList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const{
          //列宽
          0: FlexColumnWidth(0.5),
          1: FlexColumnWidth(2.0),
          2: FlexColumnWidth(1.0),
        },
        //表格边框样式
        border: TableBorder.all(
          color: Color.fromRGBO(227, 227, 227, 1),
          width: 1.0,
          style: BorderStyle.solid,
        ),
        children: [
          TableRow(
            //第一行样式 添加背景色
            decoration: BoxDecoration(
              color: Color.fromRGBO(241, 241, 241, 1),
            ),
            children: [
              // 表头
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  '序号',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  '关键词',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                '最新排名',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ]
          ),
          TableRow(
            children: [
              Text('1',textAlign: TextAlign.center,),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('Hunting Tent Quotes', maxLines: 1,),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: FlatButton(
                  onPressed: (){
                    print('');
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  highlightColor: Colors.blue[700],
                  splashColor: Colors.blue[700],
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Text('首：2'),
                ),
              ),
            ]
          ),
          TableRow(
              children: [
                Text('2',textAlign: TextAlign.center,),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text('Pop Up Beach Tent Quotes', maxLines: 1,),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: FlatButton(
                    onPressed: (){
                      print('');
                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                    highlightColor: Colors.blue[700],
                    splashColor: Colors.blue[700],
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Text('首：5'),
                  ),
                ),
              ]
          ),
        ],
      )
    );
  }
}