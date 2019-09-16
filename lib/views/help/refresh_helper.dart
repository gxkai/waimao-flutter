import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 通用的footer
class RefresherFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClassicFooter(
      failedText: '加载失败',
      idleText: '上拉加载更多',
      loadingText: '加载中...',
      noDataText: '没有更多数据了',
    );
  }
}
