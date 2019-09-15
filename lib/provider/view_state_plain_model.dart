

import 'package:waimao/provider/view_state_model.dart';

/// 基于
abstract class ViewStatePlainModel<T> extends ViewStateModel {

  /// 第一次进入页面loading skeleton
  initData() async {
    setBusy(true);
    await refresh(init: true);
  }

  // 下拉刷新
  refresh({bool init = false}) async {
    try {
      await loadData();
      setBusy(true);
      if(init) {
      } else {
        notifyListeners();
      }
    } catch (e, s) {
      handleCatch(e, s);
    }
  }

  // 加载数据
  Future<T> loadData();
}
