import 'package:waimao/model/visit_by_country_info.dart';
import 'package:waimao/model/visit_by_hour_info.dart';
import 'package:waimao/model/visit_by_os_info.dart';
import 'package:waimao/provider/view_state_refresh_plain_model.dart';
import 'package:waimao/utils/data_utils.dart';

class TerminalDeviceModel extends ViewStateRefreshPlainModel {
  String _fromDate;
  String _toDate;
  num _index = 0;
  List<VisitByOsInfo> _list = [];
  List<VisitByOsInfo> get items => _list;
  String get fromDate => _fromDate;
  String get toDate => _toDate;
  num get index => _index;
  TerminalDeviceModel(this._fromDate, this._toDate);
  Future loadData() async {
    _list = await DataUtils.visitByOs({fromDate: _fromDate, toDate: toDate});
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