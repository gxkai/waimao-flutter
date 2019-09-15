import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:waimao/models/dashboard.dart';
import 'package:waimao/provider/view_state_refresh_plain_model.dart';
import 'package:waimao/utils/data_utils.dart';

class HomeModel extends ViewStateRefreshPlainModel {
  Dashboard _dashboard;
  num messageCount = 0;
  num todayCount = 0;
  num unread = 0;
  num isRead = 0;
  num keywords = 0;
  num firstPageKeywords = 0;
  num secondPageKeywords = 0;
  num thirdPageKeywords = 0;
  num pv = 0;
  num uv = 0;
  num divide = 0;
  num newVisit = 0;
  Dashboard get dashboard => _dashboard;
  Future loadData() async {
    _dashboard = await DataUtils.dashboard();
    messageCount = dashboard.message.read + dashboard.message.unread;
    todayCount = dashboard.message.messageCount;
    unread = dashboard.message.unread;
    isRead = dashboard.message.read;

    keywords = dashboard.keyword.keywordCount;
    firstPageKeywords = dashboard.keyword.page1;
    secondPageKeywords = dashboard.keyword.page2;
    thirdPageKeywords =  dashboard.keyword.page3;

    pv = dashboard.visit.pv;
    uv = dashboard.visit.uv;
    if (dashboard.visit.pv != 0) {
      divide = (dashboard.visit.uv/dashboard.visit.pv)*100;
      newVisit = divide.floor();
    }
  }
}