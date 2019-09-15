import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:waimao/provider/view_state_plain_model.dart';

/// 基于
abstract class ViewStateRefreshPlainModel<T> extends ViewStatePlainModel {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  /// 下拉刷新
  @override
  Future refresh({bool init = false}) async {
    try {
      await loadData();
      setBusy(false);
      if (init) {
      } else {
        notifyListeners();
      }
      refreshController.refreshCompleted();
    } catch (e, s) {
      handleCatch(e, s);
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
