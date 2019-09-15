import 'package:waimao/model/keyword_count.dart';
import 'package:waimao/model/visit_by_country_info.dart';
import 'package:waimao/model/visit_by_hour_info.dart';
import 'package:waimao/model/visit_by_os_info.dart';
import 'package:waimao/models/keyword.dart';
import 'package:waimao/models/keywordData.dart';
import 'package:waimao/provider/view_state_refresh_plain_model.dart';
import 'package:waimao/utils/data_utils.dart';

class KeywordRankingModel extends ViewStateRefreshPlainModel {
  KeywordCount _keywordCount;
  num  get first => _keywordCount.first;
  num get second => _keywordCount.second;
  num get third => _keywordCount.third;
  num get sum => _keywordCount.first + _keywordCount.second + _keywordCount.third;
  List<KeywordData> _list;
  List<KeywordData> get list => _list;
  num _currentPage = 1;
  num _lastPage = 1;
  num _limit = 6;
  num get currentPage => _currentPage;
  num get lastPage => _lastPage;
  num get limit => _limit;
  num get serialNumber => _limit * (currentPage - 1);
  KeywordRankingModel(this._currentPage);
  Future loadData() async {
    _keywordCount = await DataUtils.visitByKeywordCount();
    await loadPage();
  }
  Future loadPage({Direction direction}) async {
    if(direction == Direction.forward) {
      if(_currentPage < _lastPage) {
        _currentPage ++;
      }
    }
    if(direction == Direction.backup) {
      if(_currentPage > 1) {
        _currentPage --;
      }
    }
    Keyword keyword = await DataUtils.visitByKeywordData(
        {"limit": "$_limit", "page": "$_currentPage"});
    _list = keyword.data;
    _currentPage = keyword.currentPage;
    _lastPage = keyword.lastPage;
    notifyListeners();
  }
}
enum Direction { forward, backup }
