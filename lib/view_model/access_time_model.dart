import 'package:waimao/model/visit_by_hour_info.dart';
import 'package:waimao/provider/view_state_refresh_plain_model.dart';
import 'package:waimao/utils/data_utils.dart';

class AccessTimeModel extends ViewStateRefreshPlainModel {
  String _fromDate;
  String _toDate;
  num _index = 0;
  List<VisitByHourInfo> _list = [];
  List<VisitByHourInfo> get items => _list;
  String get fromDate => _fromDate;
  String get toDate => _toDate;
  num get index => _index;
  AccessTimeModel(this._fromDate, this._toDate);
  Future loadData() async {
    _list = await DataUtils.visitByHour({'fromDate': _fromDate, 'toDate': _toDate});
  }
  Future changeData(String fromDate, String toDate) async {
    _fromDate = fromDate;
    _toDate = toDate;
    await initData();
  }
  changeIndex(index) {
    _index = index;
    notifyListeners();
  }
}