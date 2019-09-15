import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:waimao/model/visit_by_day_info.dart';
import 'package:waimao/provider/view_state_refresh_plain_model.dart';
import 'package:waimao/utils/data_utils.dart';

class FlowStatisticsModel extends ViewStateRefreshPlainModel {
  List<VisitByDayInfo> _list = [VisitByDayInfo(key: DateTime.now(), pv: 0, uv: 0)];
  List<VisitByDayInfo> get rows => _list;
  @override
  Future loadData() async {
    // TODO: implement loadData
    var formatter = new DateFormat('yyyy-MM-dd');
    var from = new DateTime.now().add(new Duration(days: -29));
    var to = new DateTime.now();
    String fromDate = formatter.format(from);
    String toDate = formatter.format(to);
    _list = await DataUtils.visitByDay({'fromDate': fromDate, 'toDate': toDate});
    _list.sort((a, b) => b.key.compareTo(a.key));
    return null;
  }
}