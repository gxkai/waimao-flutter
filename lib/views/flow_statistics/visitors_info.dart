import 'package:flutter/material.dart';
import 'package:waimao/charts/rtl_line_segments.dart';
import 'package:waimao/views/flow_statistics/visitors_info_select.dart';

class VisitorsInfo extends StatefulWidget {
  static String tag = 'visitors-info';

  @override
  VisitorsInfoState createState() => new VisitorsInfoState();
}

class VisitorsInfoState extends State<VisitorsInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('流量统计'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
                Navigator.pop(context);
            }
                ),
        actions: <Widget>[
          IconButton(
            icon: Icon(IconData(0xe67e, fontFamily: "iconfont"),
              color: Colors.white,),
              onPressed: () {
                Navigator.of(context).pushNamed(VisitorsInfoSelect.tag);
              }
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        alignment: AlignmentDirectional.topCenter,
        color:  Color.fromRGBO(237, 237, 237, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("最近30天浏览/访客量", style: TextStyle(color: Colors.black),)
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: <Widget>[
                        Expanded(child:
                        Table(
                          columnWidths: const {
                            0: FixedColumnWidth(50.0),
                            1: FixedColumnWidth(50.0),
                            2: FixedColumnWidth(50.0),
                          },
                          border: TableBorder.all(
                              color: Colors.grey, width: 1.0, style: BorderStyle.solid),
                          children: const [
                            TableRow(
                              decoration: BoxDecoration(color: Color.fromRGBO(241, 241, 241, 1)),
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Text('日期', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),),),
                                Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Text('浏览量PV', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),),),
                                Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Text('访客量UV', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),),),
                              ],
                            ),
                            TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Text('A1', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),),),
                                Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Text('A2', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),),),
                                Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Text('A3', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),),),
                              ],
                            ),
                            TableRow(
                              decoration: BoxDecoration(color: Color.fromRGBO(241, 241, 241, 1)),
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Text('A1', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),),),
                                Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Text('A2', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),),),
                                Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Text('A3', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),),),
                              ],
                            ),
                          ],
                        ))
                      ],
                    )
                  ],
                )
              )
            ),
            SizedBox(height: 10,),
            Card(
                color: Colors.white,
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text("最近30天浏览/访客量折线图", style: TextStyle(color: Colors.black),)
                          ],
                        ),
                        Container(
                          height: 200,
                          child: RTLLineSegments.withSampleData(),
                        )
                      ],
                    )
                )
            ),
            Row(
              children: <Widget>[
              ],
            )
          ],
        ),
      )
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
  void didUpdateWidget(VisitorsInfo oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}